import 'package:flutter/widgets.dart';

abstract class AuthenticationRepository {
  Future<bool> createSocketConnection();

  Future<void> destroySocketConnection();

  Future<bool> signIn({
    @required String userName,
    @required String avatar,
  });
}
