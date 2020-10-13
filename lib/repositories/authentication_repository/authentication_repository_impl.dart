import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:flutter/widgets.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final SocketIo _socketIo = SocketIo();

  @override
  Future<bool> createSocketConnection() async {
    try {
      _socketIo.createSocketConnection();
      if (_socketIo.socket.connected) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(']-----] createSocketConnection [-----[ ${e.toString()}');
    }
  }

  @override
  Future<void> destroySocketConnection() async {
    _socketIo.socket.dispose();
  }

  @override
  Future<bool> signIn({
    @required String userName,
    @required String avatar,
  }) async {
    try {
      _socketIo.socket.emit(
        'initUser',
        <String, String>{
          'username': userName,
          'avatar': avatar,
        },
      );

      return true;
    } catch (e) {
      print(']-----] signIn [-----[ ${e.toString()}');
      return false;
    }
  }
}
