part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => <Object>[];
}

class AuthenticationSignUpTried extends AuthenticationEvent {
  const AuthenticationSignUpTried({
    @required this.userName,
    @required this.password,
  })  : assert(userName != null),
        assert(password != null);

  final String userName;
  final String password;
}

class AuthenticationTried extends AuthenticationEvent {}

class AuthenticationOut extends AuthenticationEvent {}
