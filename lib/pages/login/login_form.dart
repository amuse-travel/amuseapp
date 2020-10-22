import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/blocs/login/login_bloc.dart';
import 'package:amuse_app/pages/app_screens.dart';
import 'package:amuse_app/pages/chat/chat_page.dart';
import 'package:amuse_app/pages/common/decoration/underline_text_field_decoration.dart';
import 'package:amuse_app/pages/common/dismiss_keyboard_listener/dismiss_keyboard_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget{

  void _onGoogleLoginButtonPressed(BuildContext context) {
    context.bloc<LoginBloc>().add(LoginWithGoogleTried());
  }
  

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is LoginWithGoogleTrySuccess) {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => AppScreens(),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    child: InkWell(
                      onTap: () => _onGoogleLoginButtonPressed(context),
                      child: Image.asset('assets/icons/google-logo.png'),
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
