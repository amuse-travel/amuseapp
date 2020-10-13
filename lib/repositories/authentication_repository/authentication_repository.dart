import 'package:flutter/widgets.dart';

abstract class AuthenticationRepository {
  void destroySocketConnection();

  Future<bool> signIn({
    @required String userName,
    @required String avatar,
  });
}
