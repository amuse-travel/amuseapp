import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/pages/setting/update_nickname/update_nickname_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  void _updateNickname(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext buildContext) => UpdateNicknamePage(),
      ),
    );
  }

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
              onPressed: () => _updateNickname(context),
              color: Colors.white,
              child: const Text('닉네임 변경'),
            ),
          ),
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
