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
    if (event is LoginWithGuestTried) {
      yield* _mapLoginWithGuestTriedToState(event);
    }
  }

  Stream<LoginState> _mapLoginWithGoogleTriedToState(LoginWithGoogleTried event) async* {
    yield LoginInProgress();
    try {
      final String _uid = await authenticationRepository.googleSignIn();
      if (_uid != null) {
        yield LoginTrySuccess(uid: _uid);
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
      final String _uid = await authenticationRepository.appleSignIn();
      if (_uid != null) {
        yield LoginTrySuccess(uid: _uid);
      } else {
        yield const LoginFailure(message: 'LoginWithAppleTried');
      }
    } catch (e) {
      yield LoginFailure(message: 'LoginWithAppleTried ${e.toString()}');
    }
  }

  Stream<LoginState> _mapLoginWithGuestTriedToState(LoginWithGuestTried event) async* {
    yield LoginInProgress();
    yield const LoginTrySuccess(uid: null);
  }
}
