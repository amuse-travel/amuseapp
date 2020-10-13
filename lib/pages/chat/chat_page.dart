import 'package:amuse_app/blocs/chat/chat_bloc.dart';
import 'package:amuse_app/pages/chat/chat_form.dart';
import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:amuse_app/repositories/chat_repository/chat_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    @required this.userName,
  }) : assert(userName != null);

  final String userName;

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
        child: ChatForm(
          userName: userName,
        ),
      ),
    );
  }
}
