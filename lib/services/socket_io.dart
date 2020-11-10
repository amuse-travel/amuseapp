import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../model/singleton_user.dart';

class SocketIo {
  final SingletonUser _singletonUser = SingletonUser();

  Socket socketConnection() {
    String _userName;

    Socket _socket;

    final String chatApi = DotEnv().env['CHAT_API'];

    if (_singletonUser.userName != null) {
      _userName = _singletonUser.userName;
      _socket = io(
        chatApi,
        <String, dynamic>{
          'transports': <String>['websocket'],
          'autoConnect': false,
          'query': <String, dynamic>{
            'username': _userName,
            'avatar': 'https://ui-avatars.com/api/?name=$_userName',
          },
        },
      );

      return _socket;
    } else {
      return null;
    }
  }
}
