import 'package:amuse_app/model/singleton_user.dart';
import 'package:amuse_app/services/socket_io.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final SingletonUser _singletonUser = SingletonUser();

  Future<void> updateUserName({String userName}) async {
    emit(UpdateProfileInProgress());
    _singletonUser.userName = userName;
    await _secureStorage.delete(key: 'user_name');
    await _secureStorage.write(key: 'user_name', value: userName);
    emit(UpdateProfileUserName());
  }
}
