part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => <Object>[];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailure extends LoginState {
  const LoginFailure({
    @required this.message,
  }) : assert(message != null);
  final String message;

  @override
  List<Object> get props => <Object>[message];
}

class LoginTrySuccess extends LoginState {}
