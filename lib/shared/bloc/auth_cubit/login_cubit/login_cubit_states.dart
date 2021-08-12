import 'package:shop_app/models/user_model.dart';

abstract class LoginScreenStates {}

class IdleLoginScreenState extends LoginScreenStates {}

class LoadingLoginScreenState extends LoginScreenStates {}

class SuccessLoginScreenState extends LoginScreenStates {
  final UserModel userModel;
  SuccessLoginScreenState(this.userModel);
}

class ErrorLoginScreenState extends LoginScreenStates {
  final String error;
  ErrorLoginScreenState(this.error);
}
class ChangePasswordState extends LoginScreenStates{}
