import 'package:amuse_app/model/chat_message_list.dart';
import 'package:amuse_app/model/custom_chat_message.dart';

abstract class ChatRepository {
  Future<ChatMessageList> fetchMessages({String userName});

  Future<ChatMessageList> fetchMoreMessages({String userName, String lastMsId});

  Future<bool> sendMessage({String userName, String message});
}
