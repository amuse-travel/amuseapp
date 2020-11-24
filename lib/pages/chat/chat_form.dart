import 'dart:developer';

import 'package:amusetravel/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:amusetravel/pages/setting/update_user_name/update_user_name_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../main.dart';
import '../../model/custom_chat_message.dart';
import '../../model/singleton_user.dart';
import '../../services/socket_io.dart';
import '../setting/update_user_name/update_user_name_page.dart';
import 'chat_room/chat_room_page.dart';

class ChatForm extends StatefulWidget {
  @override
  _ChatFormState createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final SingletonUser _singletonUser = SingletonUser();

  final SocketIo _socketIo = SocketIo();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String _uid;

  @override
  void initState() {
    super.initState();

    _readUid();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _listenMessages();
  }

  Future<void> _readUid() async {
    _uid = await _secureStorage.read(key: 'uid');
  }

  void _listenMessages() {
    CustomChatMessage _customChatMessage;

    if (_socketIo.socketConnection() != null) {
      _socketIo.socketConnection().on(
        'incomingMessage',
        (dynamic data) {
          log(data.toString());
          final Map<String, dynamic> jsonResponse = data as Map<String, dynamic>;
          if (jsonResponse != null) {
            _customChatMessage = CustomChatMessage.fromJson(jsonResponse);
            context.bloc<ChatBloc>().add(ChatIncomingMessageFetched(customChatMessage: _customChatMessage));
          }
        },
      );
    } else {
      log('=====| _listenMessages |==========[ socket connection is failure.');
    }
  }

  void _onEnterChatRoom({String category, String room}) {
    if (_uid != null) {
      if (_singletonUser.userName != null) {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext buildContext) => BlocProvider<ChatBloc>.value(
              value: context.bloc<ChatBloc>(),
              child: ChatRoomPage(
                category: category,
                room: room,
              ),
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext buildContext) => BlocProvider<ChatBloc>.value(
              value: context.bloc<ChatBloc>(),
              child: UpdateUserNamePage(),
            ),
          ),
        );
      }
    } else {
      CustomToast(
        message: '채팅을 하시려면 소셜로그인이 필요합니다!',
      ).show();
    }
  }

  Widget _chatRoom({String title, String image, VoidCallback onPressed}) {
    return Container(
      width: 335,
      height: 158,
      child: RaisedButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: <Widget>[
              Image.asset(
                image,
                fit: BoxFit.fitWidth,
              ),
              Container(
                margin: const EdgeInsets.all(12),
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: BOLD,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return BlocListener<ChatBloc, ChatState>(
      listener: (BuildContext buildContext, ChatState state) {
        if (state is ChatReadyToIncomingMessageSuccess) {
          _listenMessages();
        }
      },
      child: Container(
        width: _sizeWidth,
        height: _sizeHeight,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 22,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '채팅을 통한 매칭🎶💬',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: MEDIUM,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              _chatRoom(
                title: '휠체어 사용자와\n함께하기',
                image: 'assets/icons/wheel.png',
                onPressed: () => _onEnterChatRoom(
                  category: '휠체어 사용자와 함께하기',
                  // room: 'wheel',
                  room: 'korea',
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              _chatRoom(
                title: '청각 장애인과\n함께하기',
                image: 'assets/icons/deaf.png',
                onPressed: () => _onEnterChatRoom(
                  category: '청각 장애인과 함께하기',
                  room: 'china',
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              _chatRoom(
                title: '시니어와\n함께하기',
                image: 'assets/icons/senior.png',
                onPressed: () => _onEnterChatRoom(
                  category: '시니어와 함께하기',
                  room: 'japan',
                ),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
