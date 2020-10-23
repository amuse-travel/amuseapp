import 'package:amuse_app/model/chat_message_list.dart';

abstract class ChatRepository {
  Future<ChatMessageList> fetchMessages({String userName});

  Future<bool> sendMessage({String userName, String message});
}
