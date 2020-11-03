import 'dart:developer';

import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/repositories/authentication_repository/authentication_repository.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socket_io_client/socket_io_client.dart';

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

      print('userName : $_userName');

      if (_uid != null) {
        if (_userName != null) {
          _singletonUser.userName = _userName;

          final Socket _socket = _socketIo.socketConnection();
          await Future<dynamic>.delayed(const Duration(milliseconds: 500));

          if (_socket.connected) {
            print('=====| authenticate |==========[ SocketIO connection complete.');
          } else {
            print('=====| authenticate |==========[ SocketIO connection failure.');
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('=====| authenticate |==========[ ${e.toString()}');
      return false;
    }
  }

  @override
  Future<void> disprove() async {
    _singletonUser.userName = null;
    await _secureStorage.deleteAll();
    _socketIo.socketConnection().close();
    await Future<dynamic>.delayed(const Duration(milliseconds: 500));
    print('=====| disprove |==========[');
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
      print('=====| deleteUser |==========[${e.toString()}');
    }
  }

  @override
  Future<bool> googleSignIn() async {
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

      return true;
    } catch (e) {
      print('=====| googleSignIn |==========[ ${e.toString()}');
      return false;
    }
  }
}
