import 'package:amuse_app/pages/common/dismiss_keyboard_listener/dismiss_keyboard_listener.dart';
import 'package:flutter/material.dart';

import '../chat/chat_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  void _onLoginButtonPressed() {
    if (_textEditingController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (BuildContext context) => ChatPage(
            userName: _textEditingController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    return DismissKeyboardListener(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _textEditingController,
                    autocorrect: false,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: RaisedButton(
                    onPressed: _onLoginButtonPressed,
                    child: const Text(
                      'Login',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
