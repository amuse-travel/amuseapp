import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppScreens extends StatefulWidget {
  @override
  _AppScreensState createState() => _AppScreensState();
}

class _AppScreensState extends State<AppScreens> {
  void _logout() {
    context.bloc<AuthenticationBloc>().add(AuthenticationOut());
    Navigator.popUntil(
      context,
      ModalRoute.withName('/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: _logout,
              child: Text('logout'),
            ),
          ),
        ],
      ),
    );
  }
}
