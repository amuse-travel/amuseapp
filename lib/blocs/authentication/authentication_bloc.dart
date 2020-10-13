import 'dart:async';

import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
    if (event is AuthenticationFinished) {
      yield* _mapAuthenticationFinishedToState(event);
    }
  }

  Stream<AuthenticationState> _mapAuthenticationTriedToState(AuthenticationTried event) async* {
    yield AuthenticationInProgress();
    try {
      final bool _isLogin = await authenticationRepository.signIn(
        userName: event.userName,
        avatar: event.avatar,
      );
      if (_isLogin) {
        yield AuthenticationTrySuccess();
      } else {
        authenticationRepository.destroySocketConnection();
        yield AuthenticationFailure();
      }
    } catch (e) {
      print(']-----] _mapAuthenticationTriedToState [-----[ ${e.toString()}');
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationFinishedToState(AuthenticationFinished event) async* {
    yield AuthenticationInProgress();
    try {
      authenticationRepository.destroySocketConnection();
      yield AuthenticationFinishSuccess();
    } catch (e) {
      print(']-----] _mapAuthenticationFinishedToState [-----[ ${e.toString()}');
      yield AuthenticationFailure();
    }
  }
}
