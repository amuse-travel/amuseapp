import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).secondaryHeaderColor,
        child: Center(
          child: Container(
            width: 150,
            height: 150,
            child: Image.asset(
              'assets/icons/amuse-mark-blue.png',
            ),
          ),
        ),
      ),
    );
  }
}
