import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../model/singleton_user.dart';
import '../../services/socket_io.dart';
import 'authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final SocketIo _socketIo = SocketIo();

  final SingletonUser _singletonUser = SingletonUser();

  @override
  Future<bool> authenticate() async {
    try {
      final String _uid = await _secureStorage.read(key: 'uid');
      final String _userName = await _secureStorage.read(key: 'user_name');

      if (_uid != null) {
        if (_userName != null) {
          _singletonUser.userName = _userName;

          final Socket _socket = _socketIo.socketConnection().connect();
          await Future<dynamic>.delayed(const Duration(milliseconds: 500));

          if (_socket.connected) {
            log('=====| authenticate |==========[ SocketIO connection complete.');
          } else {
            log('=====| authenticate |==========[ SocketIO connection failure.');
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('=====| authenticate |==========[ ${e.toString()}');
      return false;
    }
  }

  @override
  Future<void> disprove() async {
    _singletonUser.userName = null;
    await _secureStorage.deleteAll();
    _socketIo.socketConnection().close();
    await Future<dynamic>.delayed(const Duration(milliseconds: 500));
    log('=====| disprove |==========[');
  }

  @override
  Future<void> deleteUser() async {
    try {
      final String _idToken = await _secureStorage.read(key: 'id_token');
      final String _accessToken = await _secureStorage.read(key: 'access_token');
      if (_idToken != null && _accessToken != null) {
        final AuthCredential _authCredential = GoogleAuthProvider.credential(
          idToken: _idToken,
          accessToken: _accessToken,
        );

        await _auth.currentUser.reauthenticateWithCredential(_authCredential);
      }

      _singletonUser.userName = null;
      await _secureStorage.deleteAll();
      await _auth.currentUser.delete();

      _socketIo.socketConnection().close();
      await Future<dynamic>.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      log('=====| deleteUser |==========[${e.toString()}');
    }
  }

  @override
  Future<String> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount.authentication;

      final AuthCredential _authCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      final UserCredential _userCredential = await _auth.signInWithCredential(_authCredential);
      await _secureStorage.write(key: 'uid', value: _userCredential.user.uid);

      return _userCredential.user.uid;
    } catch (e) {
      log('=====| googleSignIn |==========[ ${e.toString()}');
      return null;
    }
  }

  @override
  Future<String> appleSignIn() async {
    /// Generates a cryptographically secure random nonce, to be included in a
    /// credential request.
    String generateNonce([int length = 32]) {
      const String charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
      final random = math.Random.secure();
      return List<String>.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
    }

    /// Returns the sha256 hash of [input] in hex notation.
    String sha256ofString(String input) {
      final bytes = utf8.encode(input);
      final digest = sha256.convert(bytes);
      return digest.toString();
    }

    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final UserCredential _userCredential = await _auth.signInWithCredential(oauthCredential);
      await _secureStorage.write(key: 'uid', value: _userCredential.user.uid);

      return _userCredential.user.uid;
    } catch (e) {
      log('=====| appleSignIn |==========[ ${e.toString()}');
      return null;
    }
  }
}
