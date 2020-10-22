import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  void _logout(BuildContext context) {
    context.bloc<AuthenticationBloc>().add(AuthenticationOut());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 100,
            child: RaisedButton(
              onPressed: () => _logout(context),
              color: Colors.white,
              child: const Text('로그아웃'),
            ),
          ),
        ],
      ),
    );
  }
}
