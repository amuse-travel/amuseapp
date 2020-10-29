part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => <Object>[];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  const AuthenticationFailure({
    @required this.message,
  }) : assert(message != null);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}

class AuthenticationTrySuccess extends AuthenticationState {}

class AuthenticationRequired extends AuthenticationState {}

class AuthenticationFinishSuccess extends AuthenticationState {}
