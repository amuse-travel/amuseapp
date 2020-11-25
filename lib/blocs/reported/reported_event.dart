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

class ReportedMessageTried extends ReportedEvent {
  const ReportedMessageTried({
    @required this.userName,
    @required this.message,
  })  : assert(userName != null),
        assert(message != null);

  final String userName;
  final String message;
}
