part of 'reported_bloc.dart';

abstract class ReportedEvent extends Equatable {
  const ReportedEvent();

  @override
  List<Object> get props => <Object>[];
}

class ReportedUserTried extends ReportedEvent {
  const ReportedUserTried({
    @required this.userName,
  }) : assert(userName != null);

  final String userName;
}
