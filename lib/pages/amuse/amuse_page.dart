import 'package:flutter/material.dart';

class AmusePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'home ${MediaQuery.of(context).size}',
        ),
      ),
    );
  }
}
