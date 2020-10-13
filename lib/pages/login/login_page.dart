import 'package:amuse_app/pages/common/decoration/underline_text_field_decoration.dart';
import 'package:amuse_app/pages/common/dismiss_keyboard_listener/dismiss_keyboard_listener.dart';
import 'package:flutter/material.dart';

import '../chat/chat_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailTextController;

  TextEditingController _passwordTextController;

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();

    _emailTextController = TextEditingController();

    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  void _onLoginButtonPressed() {
    if (_emailTextController.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute<Widget>(
          builder: (BuildContext context) => ChatPage(
            userName: _emailTextController.text,
          ),
        ),
      );
    }
  }

  void _onFieldSubmitted(String text) {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
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
                    controller: _emailTextController,
                    autocorrect: false,
                    decoration: underlineTextFieldDecoration(
                      hintText: 'Email',
                    ),
                    onFieldSubmitted: _onFieldSubmitted,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 40),
                //   child: TextFormField(
                //     controller: _passwordTextController,
                //     focusNode: _passwordFocusNode,
                //     autocorrect: false,
                //     decoration: underlineTextFieldDecoration(
                //       hintText: 'password',
                //     ),
                //   ),
                // ),
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
