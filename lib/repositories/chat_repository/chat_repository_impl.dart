import 'package:amuse_app/model/chat_message_list.dart';
import 'package:amuse_app/model/custom_chat_message.dart';
import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:amuse_app/services/socket_io.dart';

class ChatRepositoryImpl extends ChatRepository {
  final SocketIo _socketIo = SocketIo();

  @override
  Future<ChatMessageList> fetchMessages({String userName}) async {
    try {
      ChatMessageList _chatMessages;

      _socketIo.socketConnection().emitWithAck(
        'messages',
        <String, dynamic>{
          'room': 'general',
        },
        ack: (dynamic data) {
          if (data != null) {
            final List<dynamic> jsonResponse = data as List<dynamic>;
            // _chatMessages = ChatMessageList.fromJson(jsonResponse[1] as Map<String, dynamic>);
          }
        },
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      if (_chatMessages != null) {
        return _chatMessages;
      } else {
        return null;
      }
    } catch (e) {
      print('===| fetchMessages |=======[ ${e.toString()}');
      return null;
    }
  }

  @override
  Future<ChatMessageList> fetchMoreMessages({String userName, String lastMsId}) async {
    try {
      ChatMessageList _chatMessages;

      _socketIo.socketConnection().emitWithAck(
        'messages',
        <String, dynamic>{
          'room': 'general',
          'msid': lastMsId,
        },
        ack: (dynamic data) {
          final List<dynamic> jsonResponse = data as List<dynamic>;
          _chatMessages = ChatMessageList.fromJson(jsonResponse[1] as Map<String, dynamic>);
        },
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      if (_chatMessages != null) {
        return _chatMessages;
      } else {
        return null;
      }
    } catch (e) {
      print('===| fetchMoreMessages |=======[ ${e.toString()}');
      return null;
    }
  }

  @override
  Future<bool> sendMessage({String userName, String message}) async {
    try {
      _socketIo.socketConnection().emitWithAck(
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
