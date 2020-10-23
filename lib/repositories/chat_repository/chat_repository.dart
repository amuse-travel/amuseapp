abstract class ChatRepository {
  Future<void> fetchMessages();

  Future<bool> sendMessage({String userName, String message});
}
