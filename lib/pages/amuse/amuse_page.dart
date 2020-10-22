import 'package:flutter/material.dart';

class AmusePage extends StatefulWidget {
  @override
  _AmusePageState createState() => _AmusePageState();
}

class _AmusePageState extends State<AmusePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.blue,
    );
  }
}
