import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../enums/api_url_enum.dart';
import '../../model/chat_message_list.dart';
import '../../services/dio.dart';
import '../../services/socket_io.dart';
import 'chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  final HttpDio _httpDio = HttpDio(apiUrlEnum: ApiUrlEnum.chat);

  final SocketIo _socketIo = SocketIo();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> enrollChatUser({String userName, String uid}) async {
    try {
      final Response<dynamic> response = await _httpDio.dio().post<dynamic>(
        '/users',
        data: <String, dynamic>{
          'name': userName,
          'rooms': <String>[
            'korea',
            'japan',
            'china',
          ],
        },
      );

      if (response.statusCode == 200) {
        final CollectionReference _reported = _firestore.collection('authenticated');
        _reported.doc('users').update(
          <String, dynamic>{
            userName: uid,
          },
        );

        final Socket _socket = _socketIo.socketConnection().connect();
        log(_socket.opts.toString());
        await Future<dynamic>.delayed(const Duration(milliseconds: 500));

        if (_socket.connected) {
          log('=====| enrollChatUser |==========[ SocketIO connection complete.');
          return true;
        } else {
          log('=====| enrollChatUser |==========[ SocketIO connection failure.');
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      log('===| enrollChatUser |=======[ ${e.toString()}');
      return false;
    }
  }

  @override
  Future<ChatMessageList> fetchMessages({String userName, String room}) async {
    try {
      ChatMessageList _chatMessages;

      _socketIo.socketConnection().emitWithAck(
        'messages',
        <String, dynamic>{
          'room': room,
        },
        ack: (dynamic data) {
          if (data != null) {
            final List<dynamic> jsonResponse = data as List<dynamic>;
            _chatMessages = ChatMessageList.fromJson(jsonResponse[1] as Map<String, dynamic>);
          }
        },
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      if (_chatMessages != null) {
        return _chatMessages;
      } else {
        return null;
      }
    } catch (e) {
      log('===| fetchMessages |=======[ ${e.toString()}');
      return null;
    }
  }

  @override
  Future<ChatMessageList> fetchMoreMessages({String userName, String room, String lastMsId}) async {
    try {
      ChatMessageList _chatMessages;

      _socketIo.socketConnection().emitWithAck(
        'messages',
        <String, dynamic>{
          'room': room,
          'msid': lastMsId,
        },
        ack: (dynamic data) {
          final List<dynamic> jsonResponse = data as List<dynamic>;
          _chatMessages = ChatMessageList.fromJson(jsonResponse[1] as Map<String, dynamic>);
        },
      );

      await Future<dynamic>.delayed(const Duration(milliseconds: 500));

      if (_chatMessages != null) {
        return _chatMessages;
      } else {
        return null;
      }
    } catch (e) {
      log('===| fetchMoreMessages |=======[ ${e.toString()}');
      return null;
    }
  }

  @override
  Future<bool> sendMessage({String userName, String room, String message}) async {
    try {
      _socketIo.socketConnection().emitWithAck(
        'input',
        <String, String>{
          'room': room,
          'message': message,
        },
        ack: (dynamic data) {
          log(data.toString());
        },
      );
      return true;
    } catch (e) {
      log('===| sendMessage |=======[ ${e.toString()}');
      return false;
    }
  }
}
