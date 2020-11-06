import 'package:flutter/material.dart';

import '../../../main.dart';

class TermsOfServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '이용 약관',
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
