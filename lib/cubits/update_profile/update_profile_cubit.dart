import 'package:amuse_app/model/singleton_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

    print('write done');
    emit(UpdateProfileUserName());
  }
}
