import 'package:amuse_app/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amuse App',
      theme: ThemeData(primaryColor: Colors.white),
      home: LoginPage(),
    );
  }
}
