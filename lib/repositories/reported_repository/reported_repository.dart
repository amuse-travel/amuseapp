abstract class ReportedRepository {
  Future<bool> reportUser({String userName});

  Future<bool> reportMessage({String userName, String message});
}