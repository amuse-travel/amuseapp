import 'dart:developer';

import 'package:amuse_app/blocs/chat/chat_bloc.dart';
import 'package:amuse_app/main.dart';
import 'package:amuse_app/model/custom_chat_message.dart';
import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/setting/update_user_name/update_user_name_page.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_room/chat_room_page.dart';

class ChatForm extends StatefulWidget {
  @override
  _ChatFormState createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final SingletonUser _singletonUser = SingletonUser();

  final SocketIo _socketIo = SocketIo();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _listenMessages();
  }

  void _listenMessages() {
    CustomChatMessage _customChatMessage;

    if (_socketIo.socketConnection().connected) {
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
          builder: (BuildContext buildContext) => UpdateUserNamePage(),
        ),
      );
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
    return Container(
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
            // _chatRoom(
            //   title: '청각 장애인과\n함께하기',
            //   image: 'assets/icons/deaf.png',
            //   onPressed: () => _onEnterChatRoom(
            //     category: '청각 장애인과 함께하기',
            //     room: 'deaf',
            //   ),
            // ),
            // const SizedBox(
            //   height: 32,
            // ),
            // _chatRoom(
            //   title: '시니어와\n함께하기',
            //   image: 'assets/icons/senior.png',
            //   onPressed: () => _onEnterChatRoom(
            //     category: '시니어와 함께하기',
            //     room: 'senior',
            //   ),
            // ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
