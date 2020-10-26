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

  @override
  Future<User> authenticate() async {
    UserCredential _userCredential;
    try {
      final String _idToken = await _secureStorage.read(key: 'idToken');
      final String _accessToken = await _secureStorage.read(key: 'accessToken');

      if (_idToken != null && _accessToken != null) {
        final AuthCredential _authCredential = GoogleAuthProvider.credential(
          idToken: _idToken,
          accessToken: _accessToken,
        );

        _userCredential = await _auth.signInWithCredential(_authCredential);
      }

      if (_userCredential != null) {
        final User _user = _userCredential.user;

        // final Socket _socket = _socketIo.socketConnection();
        // await Future<dynamic>.delayed(const Duration(milliseconds: 500));

        // if (_socket.connected) {
        //   return _user;
        // } else {
        //   print('=====| authenticate |==========[ SocketIO connection is failed.');
        //   return null;

        return _user;
        // }
      } else {
        return null;
      }
    } catch (e) {
      print('=====| authenticate |==========[ ${e.toString()}');
      return null;
    }
  }

  @override
  void disprove() {
    _secureStorage.deleteAll();
    print('=====| disprove |==========[');
  }

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

      _secureStorage.write(key: 'idToken', value: _googleSignInAuthentication.idToken);
      _secureStorage.write(key: 'accessToken', value: _googleSignInAuthentication.accessToken);

      return _authCredential;
    } catch (e) {
      print('=====| googleSignIn |==========[ ${e.toString()}');
      return null;
    }
  }
}
