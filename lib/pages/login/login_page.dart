import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/pages/login/login_form.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return LoginForm();
  }
}
