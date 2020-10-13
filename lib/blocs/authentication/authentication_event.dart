part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => <Object>[];
}

class AuthenticationTried extends AuthenticationEvent {
  const AuthenticationTried({
    @required this.userName,
    @required this.avatar,
  })  : assert(userName != null),
        assert(avatar != null);

  final String userName;
  final String avatar;
}

class AuthenticationFinished extends AuthenticationEvent {}