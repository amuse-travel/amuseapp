import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              const Text(
                'chat',
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
