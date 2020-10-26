import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  Future<User> authenticate();

  Future<void> disprove();

  Future<AuthCredential> googleSignIn();
}
