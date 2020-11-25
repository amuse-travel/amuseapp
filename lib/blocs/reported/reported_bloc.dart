import 'dart:async';
import 'dart:developer';

import 'package:amusetravel/repositories/reported_repository/reported_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reported_event.dart';

part 'reported_state.dart';

class ReportedBloc extends Bloc<ReportedEvent, ReportedState> {
  ReportedBloc({
    @required ReportedRepository reportRepository,
  })  : assert(reportRepository != null),
        _reportRepository = reportRepository,
        super(ReportedInitial());

  final ReportedRepository _reportRepository;

  @override
  Stream<ReportedState> mapEventToState(ReportedEvent event) async* {
    if (event is ReportedUserTried) {
      yield* _mapReportedUserTriedToState(event);
    }
    if(event is ReportedMessageTried){
      yield* _mapReportedMessageTriedToState(event);
    }
  }

  Stream<ReportedState> _mapReportedUserTriedToState(ReportedUserTried event) async* {
    yield ReportedInProgress();
    try {
      final bool _isSuccess = await _reportRepository.reportUser(userName: event.userName);
      if (_isSuccess) {
        yield const ReportedSuccess(message: '사용자 신고가 접수되었습니다.');
      } else {
        yield ReportedFailure();
      }
    } catch (e) {
      log('=====| _mapReportedUserTriedToState |=====[ ${e.toString()}');
      yield ReportedFailure();
    }
  }

  Stream<ReportedState> _mapReportedMessageTriedToState(ReportedMessageTried event) async* {
    yield ReportedInProgress();
    try{
      final bool _isSuccess = await _reportRepository.reportMessage(userName: event.userName, message: event.message);
      if(_isSuccess){
        yield const ReportedSuccess(message: '메시지 신고가 접수되었습니다.');
      } else {
        yield ReportedFailure();
      }
    } catch(e) {
      log('=====| _mapReportedMessageTriedToState |=====[ ${e.toString()}');
      yield ReportedFailure();
    }
  }
}
