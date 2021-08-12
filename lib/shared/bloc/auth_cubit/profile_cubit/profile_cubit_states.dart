import 'package:shop_app/models/user_model.dart';

abstract class ProfileCubitStates {}

class IdleProfileState extends ProfileCubitStates {}

class LoadingProfileState extends ProfileCubitStates {}

class SuccessProfileState extends ProfileCubitStates {
  final UserModel userModel;
  SuccessProfileState(this.userModel);
}
class UpdateProfileState extends ProfileCubitStates{
  final UserModel userModel;
  UpdateProfileState(this.userModel);
}
class LoadingUpdateeProfileState extends ProfileCubitStates{}


class ErrorProfileState extends ProfileCubitStates {}
