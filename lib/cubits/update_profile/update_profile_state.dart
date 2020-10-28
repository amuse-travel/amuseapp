part of 'update_profile_cubit.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object> get props => <Object>[];
}

class UpdateProfileInitial extends UpdateProfileState {}

class UpdateProfileInProgress extends UpdateProfileState {}

class UpdateProfileFailure extends UpdateProfileState {}

class UpdateProfileUserName extends UpdateProfileState {}
