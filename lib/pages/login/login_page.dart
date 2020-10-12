import 'package:amuse_app/pages/chat/chat_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  void _onLoginButtonPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (BuildContext context) => ChatPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: _sizeWidth,
          height: _sizeHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: const Text('Amuse App'),
              ),
              Container(
                child: RaisedButton(
                  onPressed: () => _onLoginButtonPressed(context),
                  child: const Text(
                    'Login',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
