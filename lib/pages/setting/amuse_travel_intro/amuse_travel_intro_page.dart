import 'package:flutter/material.dart';

import '../../../main.dart';

class AmuseTravelIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '어뮤즈트래블 소개',
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
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Text(
                      '어뮤즈트래블',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: MEDIUM,
                        color: Theme.of(context).textSelectionColor,
                      ),
                    ),
                  ),
                  const WidgetSpan(
                    child: Text(
                      '은',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: MEDIUM,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: const Text(
              '*풀컨시어지(Full Concierge) 서비스를\n제공하는 여행사입니다.',
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
            alignment: Alignment.centerLeft,
            child: Text(
              '웰니스 여행, 실버 여행 및\n장애인 여행에 특화된 여행상품들을\n제공하여 신체장애 유무와 나이에\n상관없이 모두가 즐거운 여행을\n만들 수 있는 관광약자를 위한\n여행 스타트업 입니다.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: REGULAR,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              '*풀컨시어지(Full concierge) 서비스란?\n단체 관광 서비스를 이용하기 어려운 여행객이나 버스 이용이 불편한 여행객을 위해 한 가족에서 세 가족 정도의 소규모 단위로 진행하는 특화 서비스로, 밴을 이용해 이동합니다. ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: REGULAR,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            width: 90,
            height: 90,
            child: Image.asset(
              'assets/icons/amuse-mark-red.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            alignment: Alignment.center,
            height: 25,
            child: Image.asset(
              'assets/icons/amuse-logo.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
