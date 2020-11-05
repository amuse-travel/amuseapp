import 'package:amuse_app/main.dart';
import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/chat/chat_room/chat_room_form.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({
    @required String category,
    @required String room,
  })  : assert(category != null),
        assert(room != null),
        _category = category,
        _room = room;

  final String _category;
  final String _room;

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  String _category;

  String _room;

  SingletonUser _singletonUser;

  String _userName;

  @override
  void initState() {
    super.initState();

    _category = widget._category;

    _room = widget._room;

    _singletonUser = SingletonUser();

    if (_singletonUser.userName != null) {
      _userName = _singletonUser.userName;
    } else {
      _userName = 'tester';
    }
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _userName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: MEDIUM,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size(_sizeWidth, 38),
          child: Container(
            alignment: Alignment.center,
            width: _sizeWidth,
            height: 38,
            color: Theme.of(context).primaryColor,
            child: Text(
              _category,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: MEDIUM,
                color: Colors.white,
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: _onBackButtonPressed,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: ChatRoomForm(
          room: _room,
        ),
      ),
    );
  }
}
