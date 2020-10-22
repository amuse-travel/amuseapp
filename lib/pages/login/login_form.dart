import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/blocs/login/login_bloc.dart';
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
      listener: (BuildContext buildContext, LoginState state) {
        if (state is LoginWithGoogleTrySuccess) {
          context.bloc<AuthenticationBloc>().add(AuthenticationTried());
        }
      },
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
    );
  }
}
