import 'package:amuse_app/model/singleton_user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final SingletonUser _singletonUser = SingletonUser();

  void updateUserName({String userName}) {
    emit(UpdateProfileInProgress());
    _singletonUser.userName = userName;
    _secureStorage.write(key: 'userName', value: _singletonUser.userName);
    emit(UpdateProfileUserName());
  }
}
