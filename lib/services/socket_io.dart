import 'package:socket_io_client/socket_io_client.dart';

class SocketIo {
  Socket socket({String userName}) {
    Socket _socket;
    _socket = io(
      'http://localhost:3210',
      <String, dynamic>{
        'transports': <String>['websocket'],
        'query': <String, dynamic>{
          'username': 'tester',
          'avatar': 'https://www.tinygraphs.com/squares/tester?theme=frogideas&numcolors=4'
        }
      },
    );

    return _socket;
  }

  void destroySocketConnection() {
    // socket.dispose();
  }
}
