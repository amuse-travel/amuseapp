import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/bottom_tab/bottom_tab_cubit.dart';
import 'main_form.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BottomTabCubit>(
      create: (BuildContext buildContext) => BottomTabCubit(),
      child: MainForm(),
    );
  }
}
