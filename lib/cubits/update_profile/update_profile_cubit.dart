import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../model/singleton_user.dart';
import '../../repositories/chat_repository/chat_repository.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit({
    @required this.chatRepository,
  })  : assert(chatRepository != null),
        super(UpdateProfileInitial());

  final ChatRepository chatRepository;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  final SingletonUser _singletonUser = SingletonUser();

  Future<void> updateUserName({String userName, String uid}) async {
    emit(UpdateProfileInProgress());
    _singletonUser.userName = userName;
    await _secureStorage.delete(key: 'user_name');
    await _secureStorage.write(key: 'user_name', value: userName);
    final bool _isEnrolled = await chatRepository.enrollChatUser(userName: userName, uid: uid);
    if (_isEnrolled) {
      emit(UpdateProfileUserName());
    } else {
      emit(UpdateProfileFailure());
    }
  }
}
