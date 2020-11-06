import 'dart:developer';

import 'package:amuse_app/cubits/bottom_tab/bottom_tab_cubit.dart';
import 'package:amuse_app/enums/tab_enum.dart';
import 'package:amuse_app/pages/amuse/amuse_page.dart';
import 'package:amuse_app/pages/chat/chat_form.dart';
import 'package:amuse_app/pages/chat/chat_page.dart';
import 'package:amuse_app/pages/common/common_widgets/custom_toast/custom_toast.dart';
import 'package:amuse_app/pages/setting/setting_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainForm extends StatefulWidget {
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  int _tabIndex;

  DateTime _currentTimePressedBack;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _tabIndex = 0;

    _firebaseMessaging.getToken().then((String value) => log(']-----] FCM Token [-----[ $value'));

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true),
    );

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        // print(message);
        // final FcmMessage _fcmMessage = FcmMessage.fromJson(message);
        // DefaultDialog(title: _fcmMessage.title, message: _fcmMessage.body).show();
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
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
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Container(
                alignment: Alignment.centerLeft,
                height: 16,
                child: Image.asset(
                  'assets/icons/amuse-logo.png',
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 1,
            ),
            body: SafeArea(
              top: false,
              bottom: false,
              child: IndexedStack(
                index: _tabIndex,
                children: <Widget>[
                  AmusePage(),
                  ChatPage(),
                  SettingPage(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _tabIndex,
              onTap: (int index) => _onSelectTab(tabEnum: TabEnum.values[index]),
              showSelectedLabels: true,
              selectedItemColor: Theme.of(context).accentColor,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              elevation: 1,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                    color: Theme.of(context).accentColor,
                  ),
                  label: '홈',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  activeIcon: Icon(
                    Icons.chat_bubble,
                    color: Theme.of(context).accentColor,
                  ),
                  label: '채팅',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  activeIcon: Icon(
                    Icons.settings,
                    color: Theme.of(context).accentColor,
                  ),
                  label: '설정',
                ),
              ],
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
