import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/chat/chat_bloc.dart';
import '../../repositories/chat_repository/chat_repository.dart';
import '../../repositories/chat_repository/chat_repository_impl.dart';
import 'chat_form.dart';

class ChatPage extends StatelessWidget {
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
        child: ChatForm(),
      ),
    );
  }
}
