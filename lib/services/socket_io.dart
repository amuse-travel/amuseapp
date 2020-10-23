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
          // 'avatar': 'https://ui-avatars.com/api/?name=$userName',
        }
      },
    );

    return _socket;
  }

  // Future<bool> createSocketConnection({String userName}) async {
  //   socket = io(
  //     'http://localhost:3210',
  //     <String, dynamic>{
  //       'transports': <String>['websocket'],
  //       'query': <String, dynamic>{
  //         'username': userName,
  //         'avatar': 'https://www.tinygraphs.com/squares/$userName?theme=frogideas&numcolors=4'
  //         // 'avatar': 'https://ui-avatars.com/api/?name=$userName',
  //       }
  //     },
  //   );
  //
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 600));
  //
  //   if (socket.connected) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  void destroySocketConnection() {
    // socket.dispose();
  }
}
