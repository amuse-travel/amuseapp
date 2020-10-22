import 'dart:async';

import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
  }

  Stream<LoginState> _mapLoginWithGoogleTriedToState(LoginWithGoogleTried event) async* {
    yield LoginInProgress();
    try {
      final AuthCredential _authCredential = await authenticationRepository.googleSignIn();
      if (_authCredential != null) {
        final User _user = await authenticationRepository.authenticate();
        if (_user != null) {
          yield LoginWithGoogleTrySuccess();
        } else {
          yield const LoginFailure(message: 'LoginWithGoogleTried');
        }
      } else {
        yield const LoginFailure(message: 'LoginWithGoogleTried');
      }
    } catch (e) {
      yield LoginFailure(message: 'LoginViaEmailTried ${e.toString()}');
    }
  }
}