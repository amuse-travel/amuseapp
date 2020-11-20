import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../repositories/authentication_repository/authentication_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(LoginInitial());

  final AuthenticationRepository authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithGoogleTried) {
      yield* _mapLoginWithGoogleTriedToState(event);
    }
    if (event is LoginWithAppleTried) {
      yield* _mapLoginWithAppleTriedToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithGoogleTriedToState(LoginWithGoogleTried event) async* {
    yield LoginInProgress();
    try {
      final bool _isGoogleSignedIn = await authenticationRepository.googleSignIn();
      if (_isGoogleSignedIn) {
        yield LoginTrySuccess();
      } else {
        yield const LoginFailure(message: 'LoginWithGoogleTried');
      }
    } catch (e) {
      yield LoginFailure(message: 'LoginWithGoogleTried ${e.toString()}');
    }
  }

  Stream<LoginState> _mapLoginWithAppleTriedToState(LoginWithAppleTried event) async* {
    yield LoginInProgress();
    try {
      final bool _isAppleSignedIn = await authenticationRepository.appleSignIn();
      if (_isAppleSignedIn) {
        yield LoginTrySuccess();
      } else {
        yield const LoginFailure(message: 'LoginWithAppleTried');
      }
    } catch (e) {
      yield LoginFailure(message: 'LoginWithAppleTried ${e.toString()}');
    }
  }
}
