import 'package:amuse_app/blocs/authentication/authentication_bloc.dart';
import 'package:amuse_app/main.dart';
import 'package:amuse_app/pages/setting/amuse_travel_intro/amuse_travel_intro_page.dart';
import 'package:amuse_app/pages/setting/terms_of_service/terms_of_service_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  void _logout(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      isScrollControlled: true,
      builder: (BuildContext buildContext) => Container(
        width: MediaQuery.of(context).size.width,
        height: 255,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(17),
            topLeft: Radius.circular(17),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            const Icon(
              Icons.exit_to_app,
              size: 38,
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              '로그아웃 하시겠어요?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: MEDIUM,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '언제든 다시 와주세요!',
              style: TextStyle(
                fontSize: 14,
                fontWeight: REGULAR,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            const Spacer(),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 106,
                    height: 75,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(buildContext);
                      },
                      color: Theme.of(context).textSelectionHandleColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(fontSize: 18, fontWeight: MEDIUM, color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 75,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(buildContext);
                          context.bloc<AuthenticationBloc>().add(AuthenticationOut());
                        },
                        color: Theme.of(context).accentColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: const Text(
                          '로그아웃',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: MEDIUM,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteAccount(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
      isScrollControlled: true,
      builder: (BuildContext buildContext) => Container(
        width: MediaQuery.of(context).size.width,
        height: 255,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(17),
            topLeft: Radius.circular(17),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 35,
            ),
            const Text(
              '🤦🏻‍♀️🤦🏻‍♂️💦',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              '계정을 삭제하시겠어요?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: MEDIUM,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '여행이 그리우실 때 다시 오시길 바랄게요:)',
              style: TextStyle(
                fontSize: 14,
                fontWeight: REGULAR,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            const Spacer(),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 106,
                    height: 75,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(buildContext);
                      },
                      color: Theme.of(context).textSelectionHandleColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Text(
                        '취소',
                        style: TextStyle(fontSize: 18, fontWeight: MEDIUM, color: Colors.black),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 75,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(buildContext);
                          context.bloc<AuthenticationBloc>().add(AuthenticationUserDelete());
                        },
                        color: Theme.of(context).accentColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        child: const Text(
                          '계정 삭제',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: MEDIUM,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _sizeWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _sizeWidth,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 40,
          ),
          Container(
            width: _sizeWidth,
            height: 112,
            color: const Color(0xFFEEEEEE),
            child: Column(
              children: <Widget>[
                Container(
                  width: _sizeWidth,
                  height: 56,
                  child: RaisedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext buildContext) => AmuseTravelIntroPage(),
                      ),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide.none,
                    ),
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 40, right: 20),
                    elevation: 0,
                    child: Row(
                      children: <Widget>[
                        const Text(
                          '어뮤즈트래블 소개',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: MEDIUM,
                            color: Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          child: const Icon(
                            Icons.arrow_forward_ios,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 56,
                ),
              ],
            ),
          ),
          Container(
            width: _sizeWidth,
            height: 56,
            color: Colors.white,
            child: RaisedButton(
              onPressed: () => _logout(context),
              color: Colors.white,
              padding: const EdgeInsets.only(left: 40, right: 20),
              elevation: 1,
              child: Row(
                children: <Widget>[
                  const Text(
                    '로그아웃',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
            width: _sizeWidth,
            height: 56,
            color: Colors.white,
            child: RaisedButton(
              onPressed: () => _deleteAccount(context),
              color: Colors.white,
              padding: const EdgeInsets.only(left: 40, right: 20),
              elevation: 1,
              child: Row(
                children: <Widget>[
                  const Text(
                    '계정 삭제',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: MEDIUM,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Widget>(
                        builder: (BuildContext buildContext) => const LicensePage(
                          applicationName: '어뮤즈앱',
                          applicationVersion: '1.0.0',
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '라이센스',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: REGULAR,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              Text(
                '  및  ',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: REGULAR,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
              Container(
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(
                      builder: (BuildContext buildContext) => TermsOfServicePage(),
                    ),
                  ),
                  child: Text(
                    '이용 약관',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: REGULAR,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Copyright © 2020 Amuse Co., Ltd.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: REGULAR,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
