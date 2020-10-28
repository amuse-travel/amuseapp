import 'dart:io';

import 'package:amuse_app/model/singleton_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketIo {
  final SingletonUser _singletonUser = SingletonUser();

  Socket socketConnection() {
    String _userName;

    if (_singletonUser.userName != null) {
      _userName = _singletonUser.userName;
    } else {
      _userName = 'tester';
    }

    final String localHost = Platform.isAndroid ? 'http://10.0.2.2:3210' : 'http://localhost:3210';
    final String chatApi = DotEnv().env['CHAT_API'];

    final Socket _socket = io(
      chatApi,
      <String, dynamic>{
        'transports': <String>['websocket'],
        'query': <String, dynamic>{
          'username': _userName,
          'avatar': 'https://www.tinygraphs.com/squares/$_userName?theme=frogideas&numcolors=4',
        },
      },
    );
    return _socket;
  }

  void destroySocketConnection() {
    // socket.dispose();
  }
}
