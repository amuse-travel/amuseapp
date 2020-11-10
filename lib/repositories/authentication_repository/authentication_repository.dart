abstract class AuthenticationRepository {
  Future<bool> authenticate();

  Future<void> disprove();

  Future<void> deleteUser();

  Future<bool> googleSignIn();
}
