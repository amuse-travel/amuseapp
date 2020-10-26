import 'package:amuse_app/blocs/chat/chat_bloc.dart';
import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/chat/chat_room/chat_room_form.dart';
import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:amuse_app/repositories/chat_repository/chat_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomPage extends StatefulWidget {
  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  SingletonUser _singletonUser;

  String _userName;

  @override
  void initState() {
    super.initState();

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
    return RepositoryProvider<ChatRepository>(
      create: (BuildContext context) {
        final ChatRepository _chatRepository = ChatRepositoryImpl();
        return _chatRepository;
      },
      child: BlocProvider<ChatBloc>(
        create: (BuildContext context) {
          final ChatRepository _chatRepository = RepositoryProvider.of<ChatRepository>(context);
          return ChatBloc(chatRepository: _chatRepository);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _userName,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: _onBackButtonPressed,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          body: SafeArea(
            child: ChatRoomForm(),
          ),
        ),
      ),
    );
  }
}
