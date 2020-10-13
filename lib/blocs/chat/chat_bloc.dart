import 'dart:async';

import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({@required this.chatRepository})
      : assert(chatRepository != null),
        super(ChatInitial());

  final ChatRepository chatRepository;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatMessageSendTried) {
      yield* _mapChatMessageSendTriedToState(event);
    }
  }

  Stream<ChatState> _mapChatMessageSendTriedToState(ChatMessageSendTried event) async* {
    yield ChatInProgress();
    try {
      await chatRepository.sendMessage(message: event.chatMessage.text);
      yield ChatMessageSendTrySuccess(chatMessage: event.chatMessage);
    } catch (e) {
      print(']-----] _mapChatMessageSendTriedToState [-----[ ${e.toString}');
      yield ChatFailure();
    }
  }
}
