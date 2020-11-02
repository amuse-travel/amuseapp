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
  Future<User> authenticate() async {
    UserCredential _userCredential;
    try {
      final String _idToken = await _secureStorage.read(key: 'id_token');
      final String _accessToken = await _secureStorage.read(key: 'access_token');
      final String _userName = await _secureStorage.read(key: 'user_name');

      print('userName : $_userName');

      if (_idToken != null && _accessToken != null) {
        final AuthCredential _authCredential = GoogleAuthProvider.credential(
          idToken: _idToken,
          accessToken: _accessToken,
        );

        _userCredential = await _auth.signInWithCredential(_authCredential);
      }
      log(_userCredential.toString());



      // log(await _userCredential.user.getIdToken());

      if (_userCredential.user != null) {
        final User _user = _userCredential.user;

        if (_userName != null) {
          _singletonUser.userName = _userName;

          final Socket _socket = _socketIo.socketConnection();
          await Future<dynamic>.delayed(const Duration(milliseconds: 500));

          if (_socket.connected) {
            print('=====| authenticate |==========[ SocketIO connection complete.');
          } else {
            print('=====| authenticate |==========[ SocketIO connection failure.');
          }
        } else {
          print('=====| authenticate |==========[ SocketIO connection failure.');
        }

        return _user;
      } else {
        return null;
      }
    } catch (e) {
      print('=====| authenticate |==========[ ${e.toString()}');
      return null;
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


  // TODO(Red): user credential write!
  @override
  Future<AuthCredential> googleSignIn() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount.authentication;

      final AuthCredential _authCredential = GoogleAuthProvider.credential(
        idToken: _googleSignInAuthentication.idToken,
        accessToken: _googleSignInAuthentication.accessToken,
      );

      await _secureStorage.write(key: 'id_token', value: _googleSignInAuthentication.idToken.toString());
      await _secureStorage.write(key: 'access_token', value: _googleSignInAuthentication.accessToken.toString());

      return _authCredential;
    } catch (e) {
      print('=====| googleSignIn |==========[ ${e.toString()}');
      return null;
    }
  }
}
