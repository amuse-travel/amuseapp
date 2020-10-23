import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_listener_state.dart';

class MessageListenerCubit extends Cubit<MessageListenerState> {
  MessageListenerCubit() : super(MessageListenerInitial());
}
