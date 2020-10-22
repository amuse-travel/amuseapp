import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  void _logout(BuildContext context) {
    context.bloc<AuthenticationBloc>().add(AuthenticationOut());
    // Navigator.popUntil(
    //   context,
    //   ModalRoute.withName('/'),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () => _logout(context),
              child: Text('로그아웃'),
            ),
          ),
        ],
      ),
    );
  }
}
