import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/update_profile/update_profile_cubit.dart';
import '../../../repositories/chat_repository/chat_repository.dart';
import '../../../repositories/chat_repository/chat_repository_impl.dart';
import 'update_user_name_form.dart';

class UpdateUserNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ChatRepository>(
      create: (BuildContext buildContext) => ChatRepositoryImpl(),
      child: BlocProvider<UpdateProfileCubit>(
        create: (BuildContext buildContext) {
          final ChatRepository _chatRepository = RepositoryProvider.of<ChatRepository>(buildContext);
          return UpdateProfileCubit(chatRepository: _chatRepository);
        },
        child: UpdateUserNameForm(),
      ),
    );
  }
}
