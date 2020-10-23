import 'package:socket_io_client/socket_io_client.dart';

class SocketIo {
  Socket socket = io(
    'http://localhost:3210',
    <String, dynamic>{
      'transports': <String>['websocket'],
      'query': <String, dynamic>{
        'username': '야야야',
        'avatar': 'https://www.tinygraphs.com/squares/test?theme=frogideas&numcolors=4',
      }
    },
  );

  void destroySocketConnection() {
    // socket.dispose();
  }
}
