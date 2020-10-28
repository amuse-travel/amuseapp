import 'package:amuse_app/model/chat_message_list.dart';
import 'package:amuse_app/model/custom_chat_message.dart';

abstract class ChatRepository {
  Future<bool> enrollChatUser({String userName});

  Future<ChatMessageList> fetchMessages({String userName, String room});

  Future<ChatMessageList> fetchMoreMessages({String userName, String room, String lastMsId});

  Future<bool> sendMessage({String userName, String room, String message});
}
