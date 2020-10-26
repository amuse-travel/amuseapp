import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    final double _sizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      width: _sizeWidth,
      height: _sizeHeight,
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: _sizeWidth,
            height: 100,
            child: RaisedButton(
              onPressed: () {},
              color: Colors.grey,
              child: Text('입장'),
            ),
          ),
        ],
      ),
    );
  }
}
