import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:  MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).primaryColor,
        child: const Center(
          child: Text(
            'Welcome To Amuse',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
