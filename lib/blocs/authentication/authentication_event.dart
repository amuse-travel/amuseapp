part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => <Object>[];
}

class AuthenticationTried extends AuthenticationEvent {}

class AuthenticationTemporaryTried extends AuthenticationEvent {}

class AuthenticationOut extends AuthenticationEvent {}

class AuthenticationUserDelete extends AuthenticationEvent {}
