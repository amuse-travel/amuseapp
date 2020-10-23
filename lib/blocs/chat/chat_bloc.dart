import 'dart:async';

import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    @required this.chatRepository,
  })  : assert(chatRepository != null),
        super(ChatInitial());

  final ChatRepository chatRepository;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if(event is ChatMessagesFetchTried) {
      yield* _mapChatMessagesFetchTriedToState(event);
    }
    if (event is ChatMessageSendTried) {
      yield* _mapChatMessageSendTriedToState(event);
    }
  }

  Stream<ChatState> _mapChatMessagesFetchTriedToState(ChatMessagesFetchTried event) async* {
    yield ChatInProgress();
    try {
      await chatRepository.fetchMessages(userName: event.userName);
      yield ChatMessagesFetchTrySuccess();
    } catch (e) {
      print('===| _mapChatMessagesFetchTriedToState |=======[ ${e.toString}');
      yield ChatFailure();
    }
  }

  Stream<ChatState> _mapChatMessageSendTriedToState(ChatMessageSendTried event) async* {
    yield ChatInProgress();
    try {
      final bool _isSent = await chatRepository.sendMessage(userName: event.userName, message: event.chatMessage.text);
      if (_isSent) {
        yield ChatMessageSendTrySuccess(chatMessage: event.chatMessage);
      } else {
        yield ChatFailure();
      }
    } catch (e) {
      print('===| _mapChatMessageSendTriedToState |=======[ ${e.toString}');
      yield ChatFailure();
    }
  }
}
