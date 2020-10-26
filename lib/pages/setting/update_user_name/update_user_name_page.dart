import 'package:amuse_app/cubits/update_profile/update_profile_cubit.dart';
import 'package:amuse_app/pages/setting/update_user_name/update_user_name_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateProfileCubit>(
      create: (BuildContext buildContext) => UpdateProfileCubit(),
      child: UpdateUserNameForm(),
    );
  }
}
