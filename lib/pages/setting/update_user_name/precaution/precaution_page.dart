import 'package:amusetravel/cubits/update_profile/update_profile_cubit.dart';
import 'package:amusetravel/pages/setting/update_user_name/precaution/precaution_form.dart';
import 'package:amusetravel/repositories/chat_repository/chat_repository.dart';
import 'package:amusetravel/repositories/chat_repository/chat_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrecautionPage extends StatelessWidget {
  const PrecautionPage({
    @required this.userName,
  }) : assert(userName != null);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ChatRepository>(
      create: (BuildContext buildContext) => ChatRepositoryImpl(),
      child: BlocProvider<UpdateProfileCubit>(
        create: (BuildContext buildContext) {
          final ChatRepository _chatRepository = RepositoryProvider.of<ChatRepository>(buildContext);
          return UpdateProfileCubit(chatRepository: _chatRepository);
        },
        child: PrecautionForm(
          userName: userName,
        ),
      ),
    );
  }
}
