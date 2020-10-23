import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/blocs/login/login_bloc.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:amuse_app/pages/common/common_widgets/loading_indicator/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _shouldIgnore;

  @override
  void initState() {
    super.initState();

    _shouldIgnore = false;
  }

  void _onGoogleLoginButtonPressed(BuildContext context) {
    print('touched');
    context.bloc<LoginBloc>().add(LoginWithGoogleTried());
  }

  void _onAppleLoginButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (BuildContext buildContext, LoginState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Container(
              width: _sizeWidth,
              height: _sizeHeight,
              child: Stack(
                children: <Widget>[
                  IgnorePointer(
                    ignoring: _shouldIgnore,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: const Text(
                            '어뮤즈',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () => _onGoogleLoginButtonPressed(context),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(0),
                                elevation: 0,
                                color: Colors.white,
                                child: Image.asset(
                                  'assets/icons/google-logo.png',
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              child: RaisedButton(
                                onPressed: () => _onAppleLoginButtonPressed(),
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(0),
                                elevation: 0,
                                color: Colors.white,
                                child: Image.asset(
                                  'assets/icons/apple-logo.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (state is LoginInProgress) LoadingIndicator(),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext buildContext, LoginState state) {
        if (state is LoginInProgress) {
          _shouldIgnore = true;
        }
        if (state is LoginFailure){
          _shouldIgnore = false;
          CustomToast(message: '로그인에 실패하였습니다.').show();
        }
        if (state is LoginWithGoogleTrySuccess) {
          context.bloc<AuthenticationBloc>().add(AuthenticationTried());
        }
      },
    );
  }
}
