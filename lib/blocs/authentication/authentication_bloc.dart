import 'dart:async';

import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(AuthenticationInitial());

  final AuthenticationRepository authenticationRepository;

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationTried) {
      yield* _mapAuthenticationTriedToState(event);
    }
    if (event is AuthenticationOut) {
      yield* _mapAuthenticationFinishedToState(event);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationTriedToState(AuthenticationTried event) async* {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    yield AuthenticationInProgress();
    try {
      final User user = await authenticationRepository.authenticate();
      if (user != null) {
        yield AuthenticationTrySuccess();
      } else {
        yield AuthenticationRequired();
      }
    } catch (e) {
      yield AuthenticationFailure(errorCode: 'AuthenticationTried ${e.toString()}');
    }
  }

  Stream<AuthenticationState> _mapAuthenticationFinishedToState(AuthenticationOut event) async* {
    yield AuthenticationInProgress();
    try {
      authenticationRepository.disprove();
      yield AuthenticationRequired();
    } catch (e) {
      yield AuthenticationFailure(errorCode: 'AuthenticationFinished ${e.toString()}');
    }
  }
}
