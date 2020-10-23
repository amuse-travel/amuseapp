import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:flutter/widgets.dart';

class ChatRepositoryImpl extends ChatRepository {
  final SocketIo _socketIo = SocketIo();

  @override
  Future<void> fetchMessages({String userName}) {
    try {
      dynamic _fetchedData;

      _socketIo.socket(userName: userName).emitWithAck(
        'messages',
        <String, dynamic>{
          'room': 'general',
        },
        ack: (dynamic data) {
          print(data);
          _fetchedData = data;
        },
      );

      print(_fetchedData.toString());
    } catch (e) {
      print('===| fetchMessages |=======[ ${e.toString()}');
    }
  }

  @override
  Future<bool> sendMessage({String userName, String message}) async {
    try {
      _socketIo.socket(userName: userName).emitWithAck(
        'input',
        <String, String>{
          'room': 'general',
          'message': message,
        },
        ack: (dynamic data) {
          print(data);
        },
      );
      return true;
    } catch (e) {
      print('===| sendMessage |=======[ ${e.toString()}');
      return false;
    }
  }
}
