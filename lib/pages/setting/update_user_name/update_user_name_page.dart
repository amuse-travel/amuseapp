import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/pages/common/common_decorations/underline_text_field_decoration.dart';
import 'package:flutter/material.dart';

class UpdateUserNamePage extends StatefulWidget {
  @override
  _UpdateUserNamePageState createState() => _UpdateUserNamePageState();
}

class _UpdateUserNamePageState extends State<UpdateUserNamePage> {
  SingletonUser _singletonUser;

  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _singletonUser = SingletonUser();

    _textEditingController = TextEditingController();
  }

  void _onBackButtonPressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onUpdateUserName() {
    if (_textEditingController.text.isNotEmpty) {
      print('changed');
      _singletonUser.userName = _textEditingController.text;
    }
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: _textEditingController,
                decoration: underlineTextFieldDecoration(
                  hintText: '닉네임을 입력해주세요.',
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 100,
              height: 30,
              child: RaisedButton(
                onPressed: _onUpdateUserName,
                child: Text('변경'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
