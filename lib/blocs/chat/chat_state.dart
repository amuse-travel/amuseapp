part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => <Object>[];
}

class ChatInitial extends ChatState {}

class ChatInProgress extends ChatState {}

class ChatFailure extends ChatState {
  const ChatFailure({
    @required this.message,
  }) : assert(message != null);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}

class ChatMessagesFetchTrySuccess extends ChatState {
  const ChatMessagesFetchTrySuccess({
    @required this.chatMessageList,
  }) : assert(chatMessageList != null);

  final ChatMessageList chatMessageList;

  @override
  List<Object> get props => <Object>[chatMessageList];
}

class ChatMessagesFetchMoreTrySuccess extends ChatState {
  const ChatMessagesFetchMoreTrySuccess({
    @required this.chatMessageList,
  }) : assert(chatMessageList != null);

  final ChatMessageList chatMessageList;

  @override
  List<Object> get props => <Object>[chatMessageList];
}

class ChatMessageSendTrySuccess extends ChatState {
  const ChatMessageSendTrySuccess({
    @required this.chatMessage,
  }) : assert(chatMessage != null);

  final ChatMessage chatMessage;

  @override
  List<Object> get props => <Object>[chatMessage];
}
