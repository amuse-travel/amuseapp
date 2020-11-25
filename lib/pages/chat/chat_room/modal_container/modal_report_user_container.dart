import 'package:amusetravel/blocs/reported/reported_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';

class ModalReportUserContainer extends StatelessWidget {
  const ModalReportUserContainer({
    @required this.userName,
  }) : assert(userName != null);

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Icons.error_outline,
            color: Colors.red,
            size: 38,
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            '해당 사용자를 신고하시겠어요?',
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
            '신고가 누적되면 해당 사용자는 정지됩니다.',
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
                    onPressed: () => Navigator.pop(context),
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
                        context.read<ReportedBloc>().add(ReportedUserTried(userName: userName));
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).secondaryHeaderColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      child: const Text(
                        '신고하기',
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
    );
  }
}
