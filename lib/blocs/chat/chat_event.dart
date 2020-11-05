part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => <Object>[];
}

class ChatMessagesFetchTried extends ChatEvent {
  const ChatMessagesFetchTried({
    @required this.userName,
    @required this.room,
  })  : assert(userName != null),
        assert(room != null);

  final String userName;
  final String room;
}

class ChatMessagesFetchMoreTried extends ChatEvent {
  const ChatMessagesFetchMoreTried({
    @required this.userName,
    @required this.room,
    @required this.lastMsId,
  })  : assert(userName != null),
        assert(room != null),
        assert(lastMsId != null);

  final String userName;
  final String room;
  final String lastMsId;
}

class ChatMessageSendTried extends ChatEvent {
  const ChatMessageSendTried({
    @required this.userName,
    @required this.room,
    @required this.chatMessage,
  })  : assert(userName != null),
        assert(room != null),
        assert(chatMessage != null);

  final String userName;
  final String room;
  final ChatMessage chatMessage;
}

class ChatIncomingMessageFetched extends ChatEvent {
  const ChatIncomingMessageFetched({
    @required this.customChatMessage,
  }) : assert(customChatMessage != null);

  final CustomChatMessage customChatMessage;
}
