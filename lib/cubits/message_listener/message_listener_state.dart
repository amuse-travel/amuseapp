part of 'message_listener_cubit.dart';

abstract class MessageListenerState extends Equatable {
  const MessageListenerState();
}

class MessageListenerInitial extends MessageListenerState {
  @override
  List<Object> get props => [];
}
