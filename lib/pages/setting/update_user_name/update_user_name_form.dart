import 'package:amusetravel/pages/setting/update_user_name/precaution/precaution_form.dart';
import 'package:amusetravel/pages/setting/update_user_name/precaution/precaution_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/chat/chat_bloc.dart';
import '../../../cubits/update_profile/update_profile_cubit.dart';
import '../../../main.dart';
import '../../common/common_widgets/custom_toast/custom_toast.dart';
import '../../common/common_widgets/dismiss_keyboard_listener/dismiss_keyboard_listener.dart';

class UpdateUserNameForm extends StatefulWidget {
  @override
  _UpdateUserNameFormState createState() => _UpdateUserNameFormState();
}

class _UpdateUserNameFormState extends State<UpdateUserNameForm> {
  TextEditingController _textEditingController;

  bool _buttonActive;

  @override
  void initState() {
    super.initState();

    _buttonActive = false;

    _textEditingController = TextEditingController();
  }

  void _onChangeText(dynamic text) {
    if (text.toString().isNotEmpty) {
      setState(() {
        _buttonActive = true;
      });
    } else {
      setState(() {
        _buttonActive = false;
      });
    }
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onUpdateUserName() {
    if (_textEditingController.text.isNotEmpty) {
      if (_textEditingController.text.length < 11) {
        Navigator.push(
          context,
          MaterialPageRoute<Widget>(
            builder: (BuildContext buildContext) => BlocProvider<ChatBloc>.value(
              value: context.bloc<ChatBloc>(),
              child: PrecautionPage(
                userName: _textEditingController.text,
              ),
            ),
          ),
        );
      } else {
        CustomToast(message: '닉네임을 10자 이내로 정해주세요.').show();
      }
    } else {
      CustomToast(message: '닉네임을 입력해주세요').show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboardListener(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            '닉네임 설정',
            style: TextStyle(
              fontSize: 16,
              fontWeight: MEDIUM,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            onPressed: _onBackButtonPressed,
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '채팅시 필요한\n닉네임을 설정해주세요.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: MEDIUM,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _textEditingController,
                  autofocus: true,
                  onChanged: _onChangeText,
                  autocorrect: false,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: MEDIUM,
                    color: Colors.black,
                  ),
                  maxLength: 10,
                  cursorColor: Theme.of(context).accentColor,
                  decoration: InputDecoration(
                    hintText: '닉네임을 입력해주세요.',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: REGULAR,
                      color: Theme.of(context).textSelectionHandleColor,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.8,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.8,
                        color: Theme.of(context).textSelectionHandleColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Text(
                  '채팅을 시작하기 위해선 반드시 개인정보 처리방침 및 이용약관에 대한 동의가 필요합니다.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: REGULAR,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                height: 55,
                child: RaisedButton(
                  onPressed: _onUpdateUserName,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(
                      color: _buttonActive ? Theme.of(context).secondaryHeaderColor : Theme.of(context).textSelectionHandleColor,
                    ),
                  ),
                  elevation: 0,
                  color: _buttonActive ? Theme.of(context).secondaryHeaderColor : Colors.white,
                  child: Text(
                    '채팅 시작하기',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: _buttonActive ? Colors.black : Theme.of(context).textSelectionHandleColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
