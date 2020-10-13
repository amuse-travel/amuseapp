import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:flutter/widgets.dart';

class ChatRepositoryImpl extends ChatRepository {
  final SocketIo _socketIo = SocketIo();

  @override
  Future<void> sendMessage({@required String message}) async {
    try {
      _socketIo.socket.emitWithAck(
        'newMessage',
        <String, String>{
          'room': 'general',
          'message': message,
        },
        ack: (dynamic data) {
          print(data);
        },
      );
    } catch (e) {
      print(']-----] sendMessage [-----[ ${e.toString()}');
    }
  }
}
