import 'package:amuse_app/cubits/bottom_tab/bottom_tab_cubit.dart';
import 'package:amuse_app/pages/main/main_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomTabCubit>(
      create: (BuildContext buildContext) => BottomTabCubit(),
      child: MainForm(),
    );
  }
}