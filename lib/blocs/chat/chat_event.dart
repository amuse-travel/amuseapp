part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => <Object>[];
}

class ChatMessageSendTried extends ChatEvent {
  const ChatMessageSendTried({
    @required this.chatMessage,
  }) : assert(chatMessage != null);

  final ChatMessage chatMessage;
}
