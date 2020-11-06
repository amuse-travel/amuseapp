import 'package:flutter/material.dart';

import '../../../main.dart';

class AmuseTravelIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '어뮤즈트래블 소개',
          style: TextStyle(
            fontSize: 16,
            fontWeight: MEDIUM,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
    );
  }
}
