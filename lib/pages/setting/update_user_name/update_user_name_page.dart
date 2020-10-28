import 'package:amuse_app/cubits/update_profile/update_profile_cubit.dart';
import 'package:amuse_app/pages/setting/update_user_name/update_user_name_form.dart';
import 'package:amuse_app/repositories/chat_repository/chat_repository.dart';
import 'package:amuse_app/repositories/chat_repository/chat_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
