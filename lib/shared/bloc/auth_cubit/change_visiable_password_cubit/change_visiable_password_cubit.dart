import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc/auth_cubit/change_visiable_password_cubit/change_visiable_password_cubit_state.dart';

class ChangeVisiblePasswordCubit extends Cubit<ChangeVisiblePasswordStates> {
  ChangeVisiblePasswordCubit() : super(IdleStatePasswordVisibleState());
  static ChangeVisiblePasswordCubit get(context) => BlocProvider.of(context);
  bool isObsecure = true;
  IconData iconData = Icons.visibility;
  void changePasswordObsecure() {
    isObsecure = !isObsecure;
    iconData = isObsecure ? Icons.visibility : Icons.visibility_off;
    emit(ChangeVisiblePasswordState());
  }
}
