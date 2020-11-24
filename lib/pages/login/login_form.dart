import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/authentication/authentication_bloc.dart';
import '../../blocs/login/login_bloc.dart';
import '../../main.dart';
import '../common/common_widgets/custom_toast/custom_toast.dart';
import '../common/common_widgets/loading_indicator/loading_indicator.dart';

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

  void _onGoogleLoginButtonPressed() {
    context.bloc<LoginBloc>().add(LoginWithGoogleTried());
  }

  void _onAppleLoginButtonPressed() {
    context.bloc<LoginBloc>().add(LoginWithAppleTried());
  }

  void _onGuestLoginButtonPressed() {
    context.bloc<LoginBloc>().add(LoginWithGuestTried());
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (BuildContext buildContext, LoginState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Container(
              width: _sizeWidth,
              height: _sizeHeight,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: _sizeWidth,
                    height: _sizeHeight,
                    child: Image.asset(
                      'assets/icons/login-background.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  IgnorePointer(
                    ignoring: _shouldIgnore,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 120,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            '우리 모두가 떠나는 여행\n관광약자를 위한 여행',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: MEDIUM,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerLeft,
                          height: 18,
                          child: Image.asset(
                            'assets/icons/amuse-travel-logo.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: _sizeWidth,
                          height: 56,
                          child: RaisedButton(
                            onPressed: _onGoogleLoginButtonPressed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            elevation: 0,
                            color: Colors.white,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/icons/google-logo.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Google로 로그인',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: REGULAR,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: _sizeWidth,
                          height: 56,
                          child: RaisedButton(
                            onPressed: _onAppleLoginButtonPressed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            elevation: 0,
                            color: Colors.black,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.only(left: 15),
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset(
                                    'assets/icons/apple-logo.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Apple로 로그인',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: REGULAR,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: _sizeWidth,
                          height: 56,
                          child: RaisedButton(
                            onPressed: _onGuestLoginButtonPressed,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            elevation: 0,
                            color: Theme.of(context).toggleableActiveColor,
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Guest로 로그인',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: REGULAR,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
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
        if (state is LoginFailure) {
          _shouldIgnore = false;
          CustomToast(message: '로그인에 실패하였습니다.').show();
        }
        if (state is LoginTrySuccess) {
          if (state.uid != null) {
            context.bloc<AuthenticationBloc>().add(AuthenticationTried());
          } else {
            context.bloc<AuthenticationBloc>().add(AuthenticationTemporaryTried());
          }
        }
      },
    );
  }
}
