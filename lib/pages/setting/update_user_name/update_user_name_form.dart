import 'package:amuse_app/cubits/update_profile/update_profile_cubit.dart';
import 'package:amuse_app/pages/common/common_decorations/underline_text_field_decoration.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserNameForm extends StatefulWidget {
  @override
  _UpdateUserNameFormState createState() => _UpdateUserNameFormState();
}

class _UpdateUserNameFormState extends State<UpdateUserNameForm> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController();
  }

  void _onBackButtonPressed() {
    Navigator.pop(context);
  }

  void _onUpdateUserName() {
    if (_textEditingController.text.isNotEmpty) {
      context.bloc<UpdateProfileCubit>().updateUserName(userName: _textEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileState>(
      listener: (BuildContext buildContext, UpdateProfileState state) {
        if (state is UpdateProfileUserName) {
          CustomToast(message: '닉네임 변경 성공').show();
        }
      },
      child: Scaffold(
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
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: '닉네임을 입력해주세요.',
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.8,
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.8,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
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
      ),
    );
  }
}
