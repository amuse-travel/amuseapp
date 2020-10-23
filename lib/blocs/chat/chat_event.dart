part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => <Object>[];
}

class ChatMessagesFetchTried extends ChatEvent {
  const ChatMessagesFetchTried({
    @required this.userName,
  }) : assert(userName != null);

  final String userName;
}

class ChatMessageSendTried extends ChatEvent {
  const ChatMessageSendTried({
    @required this.userName,
    @required this.chatMessage,
  })  : assert(userName != null),
        assert(chatMessage != null);

  final String userName;
  final ChatMessage chatMessage;
}
