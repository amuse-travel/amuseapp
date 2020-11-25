part of 'reported_bloc.dart';

abstract class ReportedState extends Equatable {
  const ReportedState();

  @override
  List<Object> get props => <Object>[];
}

class ReportedInitial extends ReportedState {}

class ReportedInProgress extends ReportedState {}

class ReportedFailure extends ReportedState {}

class ReportedUserTrySuccess extends ReportedState {}
