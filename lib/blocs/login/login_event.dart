part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => <Object>[];
}

class LoginWithGoogleTried extends LoginEvent {}

class LoginWithAppleTried extends LoginEvent {}

class LoginWithGuestTried extends LoginEvent {}