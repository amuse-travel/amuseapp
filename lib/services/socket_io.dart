import 'package:socket_io_client/socket_io_client.dart';

class SocketIo {
  SocketIo();

  Socket socket = io(
    'http://localhost:3000',
    <String, dynamic>{
      'transports': ['websocket'],
      // 'autoConnect': false,
    },
  );

  void createSocketConnection() {
    socket.connect();
  }
}
