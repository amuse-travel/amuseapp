import 'package:amuse_app/model/custom_chat_message.dart';

class ChatMessageList {
  ChatMessageList({
    this.msId,
    this.room,
    this.messages,
  });

  ChatMessageList.fromJson(Map<String, dynamic> json) {
    if (json['next'] != null) {
      msId = json['next']['msid'] as String;
      room = json['next']['room'] as String;
    }
    if (json['messages'] != null) {
      final List<dynamic> messageList = json['messages'] as List<dynamic>;
      messages = messageList.map((dynamic parsedJson) => CustomChatMessage.fromJson(parsedJson as Map<String, dynamic>)).toList();
    }
  }

  String msId;
  String room;
  List<CustomChatMessage> messages;
}
