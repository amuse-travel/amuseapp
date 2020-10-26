import 'package:flutter/material.dart';

class UpdateNicknamePage extends StatelessWidget {
  void _onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '닉네임 변경',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () => _onBackButtonPressed(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(),
    );
  }
}
