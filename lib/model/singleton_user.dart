import 'package:firebase_auth/firebase_auth.dart';

class SingletonUser {
  factory SingletonUser() {
    return _singletonUser;
  }

  SingletonUser._internal() {
    user = null;
  }

  static final SingletonUser _singletonUser = SingletonUser._internal();

  User user;
}
