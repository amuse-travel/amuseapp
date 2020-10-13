import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:flutter/widgets.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final SocketIo _socketIo = SocketIo();

  @override
  void destroySocketConnection() {
    _socketIo.socket.dispose();
  }

  @override
  Future<bool> signIn({
    @required String userName,
    @required String avatar,
  }) async {
    try {
      _socketIo.createSocketConnection();

      _socketIo.socket.emitWithAck(
        'initUser',
        <String, String>{
          'username': userName,
          'avatar': avatar,
        },
        ack: (dynamic data) {
          print(data);
        },
      );

      return true;
    } catch (e) {
      print(']-----] signIn [-----[ ${e.toString()}');
      return false;
    }
  }
}
