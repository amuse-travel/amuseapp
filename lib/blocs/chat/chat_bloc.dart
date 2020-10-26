import 'dart:async';
import 'dart:developer';

import 'package:amuse_app/model/chat_message_list.dart';
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
    if (event is ChatMessagesFetchTried) {
      yield* _mapChatMessagesFetchTriedToState(event);
    }
    if (event is ChatMessagesFetchMoreTried) {
      yield* _mapChatMessagesFetchMoreTriedToState(event);
    }
    if (event is ChatMessageSendTried) {
      yield* _mapChatMessageSendTriedToState(event);
    }
  }

  Stream<ChatState> _mapChatMessagesFetchTriedToState(ChatMessagesFetchTried event) async* {
    yield ChatInProgress();
    try {
      final ChatMessageList _chatMessages = await chatRepository.fetchMessages(userName: event.userName);
      if (_chatMessages != null) {
        yield ChatMessagesFetchTrySuccess(chatMessageList: _chatMessages);
      } else {
        yield const ChatFailure(
          message: '메세지 불러오기 실패',
        );
      }
    } catch (e) {
      log('===| _mapChatMessagesFetchTriedToState |=======[ ${e.toString}');
      yield const ChatFailure(
        message: '메세지 불러오기 실패',
      );
    }
  }

  Stream<ChatState> _mapChatMessagesFetchMoreTriedToState(ChatMessagesFetchMoreTried event) async* {
    yield ChatInProgress();
    try {
      final ChatMessageList _chatMessages = await chatRepository.fetchMoreMessages(userName: event.userName, lastMsId: event.lastMsId);
      if (_chatMessages != null) {
        yield ChatMessagesFetchMoreTrySuccess(chatMessageList: _chatMessages);
      } else {
        yield const ChatFailure(
          message: '메세지 불러오기 실패',
        );
      }
    } catch (e) {
      print('===| _mapChatMessagesFetchMoreTriedToState |=======[ ${e.toString}');
      yield const ChatFailure(
        message: '메세지 불러오기 실패',
      );
    }
  }

  Stream<ChatState> _mapChatMessageSendTriedToState(ChatMessageSendTried event) async* {
    yield ChatInProgress();
    try {
      final bool _isSent = await chatRepository.sendMessage(userName: event.userName, message: event.chatMessage.text);
      if (_isSent) {
        yield ChatMessageSendTrySuccess(chatMessage: event.chatMessage);
      } else {
        yield const ChatFailure(
          message: '메세지 전송 실패',
        );
      }
    } catch (e) {
      log('===| _mapChatMessageSendTriedToState |=======[ ${e.toString}');
      yield const ChatFailure(
        message: '메세지 전송 실패',
      );
    }
  }
}
