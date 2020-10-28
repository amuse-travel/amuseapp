import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  void _logout(BuildContext context) {
    context.bloc<AuthenticationBloc>().add(AuthenticationOut());
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _sizeWidth,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Container(
            width: _sizeWidth,
            height: 56,
            color: Colors.white,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              elevation: 1,
              child: Row(
                children: <Widget>[
                  const Text(
                    '공지사항',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 56,
          ),
          Container(
            width: _sizeWidth,
            height: 56,
            color: Colors.white,
            child: RaisedButton(
              onPressed: () => _logout(context),
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              elevation: 1,
              child: Row(
                children: <Widget>[
                  const Text(
                    '로그아웃',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
