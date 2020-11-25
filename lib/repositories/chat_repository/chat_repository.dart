import '../../model/chat_message_list.dart';

abstract class ChatRepository {
  Future<bool> enrollChatUser({String userName, String uid});

  Future<ChatMessageList> fetchMessages({String userName, String room});

  Future<ChatMessageList> fetchMoreMessages({String userName, String room, String lastMsId});

  Future<bool> sendMessage({String userName, String room, String message});
}
