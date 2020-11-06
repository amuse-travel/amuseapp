import 'dart:developer';
import 'dart:io';

import 'package:amuse_app/model/singleton_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

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
            'avatar': 'https://www.tinygraphs.com/squares/$_userName?theme=frogideas&numcolors=4',
          },
        },
      );

      log(_socket.opts.toString());
      return _socket;
    } else {
      return null;
    }
  }
}
