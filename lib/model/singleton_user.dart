class SingletonUser {
  factory SingletonUser() {
    return _singletonUser;
  }

  SingletonUser._internal() {
    userName = null;
  }

  static final SingletonUser _singletonUser = SingletonUser._internal();

  String userName;
}
