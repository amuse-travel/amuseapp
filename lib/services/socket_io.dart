import 'package:socket_io_client/socket_io_client.dart';

class SocketIo {
  Socket socket = io(
    'http://localhost:3000',
    <String, dynamic>{
      'transports': <String>['websocket'],
      'autoConnect': false,
    },
  );

  Future<bool> createSocketConnection() async {
    socket.onconnect();

    if(socket.connected) {
      return true;
    } else {
      return false;
    }
  }

  void destroySocketConnection() {
    socket.dispose();
  }
}
