import 'package:amuse_app/main.dart';
import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/setting/update_user_name/update_user_name_page.dart';
import 'package:flutter/material.dart';

import 'chat_room/chat_room_page.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final SingletonUser _singletonUser = SingletonUser();

  void _onEnterChatRoom({String category, String room}) {
    if (_singletonUser.userName != null) {
      Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (BuildContext buildContext) => ChatRoomPage(
            category: category,
            room: room,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '참여인원 : ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: BOLD,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: BOLD,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
              title: '발달 장애인과\n함께하기',
              image: 'assets/icons/pdd.png',
              onPressed: () => _onEnterChatRoom(
                category: '발달 장애인과 함께하기',
                // room: 'pdd',
                room: 'japan',
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            _chatRoom(
              title: '시각 장애인과\n함께하기',
              image: 'assets/icons/blind.png',
              onPressed: () => _onEnterChatRoom(
                category: '시각 장애인과 함께하기',
                // room: 'blind',
                room: 'china',
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
