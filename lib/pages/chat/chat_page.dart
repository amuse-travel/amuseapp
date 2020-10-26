import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/setting/update_user_name/update_user_name_page.dart';
import 'package:flutter/material.dart';

import 'chat_room/chat_room_page.dart';

class ChatPage extends StatelessWidget {
  final SingletonUser _singletonUser = SingletonUser();

  void _onEnterChatRoom(BuildContext context) {
    if (_singletonUser.userName != null) {
      Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (BuildContext buildContext) => ChatRoomPage(),
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

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      width: _sizeWidth,
      height: _sizeHeight,
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: _sizeWidth,
            height: 100,
            child: RaisedButton(
              onPressed: () => _onEnterChatRoom(context),
              color: Colors.grey,
              child: Text('입장'),
            ),
          ),
        ],
      ),
    );
  }
}
