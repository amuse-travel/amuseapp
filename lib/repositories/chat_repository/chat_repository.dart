abstract class ChatRepository {
  Future<void> fetchMessages({String userName});

  Future<bool> sendMessage({String userName, String message});
}
