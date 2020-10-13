import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/pages/chat/chat_page.dart';
import 'package:amuse_app/pages/common/decoration/underline_text_field_decoration.dart';
import 'package:amuse_app/pages/common/dismiss_keyboard_listener/dismiss_keyboard_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailTextController;

  TextEditingController _passwordTextController;

  FocusNode _passwordFocusNode;

  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();

    _emailTextController = TextEditingController();

    _passwordFocusNode = FocusNode();

    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  void _onLoginButtonPressed() {
    if (_emailTextController.text.isNotEmpty) {
      _authenticationBloc.add(
        AuthenticationTried(
          userName: _emailTextController.text,
          avatar: 'https://api.adorable.io/avatars/285/abott@adorable.png',
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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationTrySuccess) {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => ChatPage(
                userName: _emailTextController.text,
              ),
            ),
          );
        }
      },
      child: DismissKeyboardListener(
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
      ),
    );
  }
}
