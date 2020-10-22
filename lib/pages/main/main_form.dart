import 'package:amuse_app/cubits/bottom_tab/bottom_tab_cubit.dart';
import 'package:amuse_app/enums/tab_enum.dart';
import 'package:amuse_app/pages/amuse/amuse_page.dart';
import 'package:amuse_app/pages/chat/chat_page.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:amuse_app/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainForm extends StatefulWidget {
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  int _tabIndex;

  DateTime _currentTimePressedBack;

  @override
  void initState() {
    super.initState();

    _tabIndex = 0;
  }

  void _onSelectTab({TabEnum tabEnum}) {
    context.bloc<BottomTabCubit>().updateTab(tabEnum: tabEnum);
  }

  Future<bool> _onAndroidWillPop() async {
    final DateTime _now = DateTime.now();
    if (_currentTimePressedBack == null || _now.difference(_currentTimePressedBack) > const Duration(seconds: 2)) {
      _currentTimePressedBack = _now;
      CustomToast(message: '뒤로가기를 한번 더 누르시면 종료됩니다.').show();
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomTabCubit, BottomTabState>(
      builder: (BuildContext buildContext, BottomTabState state) {
        return WillPopScope(
          onWillPop: _onAndroidWillPop,
          child: SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: IndexedStack(
                  index: _tabIndex,
                  children: const <Widget>[
                    Text(
                      '메인',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '채팅',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '설정',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                elevation: 1,
                centerTitle: true,
              ),
              body: IndexedStack(
                index: _tabIndex,
                children: <Widget>[
                  AmusePage(),
                  ChatPage(),
                  SettingPage(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: _tabIndex,
                onTap: (int index) => _onSelectTab(tabEnum: TabEnum.values[index]),
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                elevation: 1,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.chat,
                    ),
                    label: 'chat',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: 'setting',
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext buildContext, BottomTabState state) {
        if (state is BottomTabUpdated) {
          _tabIndex = state.tabEnum.index;
        }
      },
    );
  }
}
