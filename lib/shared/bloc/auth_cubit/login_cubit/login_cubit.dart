import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/bloc/auth_cubit/login_cubit/login_cubit_states.dart';
import 'package:shop_app/shared/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/componeents/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginScreenStates> {
  LoginCubit() : super(IdleLoginScreenState());

  static LoginCubit get(context) => BlocProvider.of(context);
  UserModel loginMdoel;
  void login(BuildContext context,
      {@required String email, @required String password}) {
    emit(LoadingLoginScreenState());
    DioHelper.setData(methodUrl: loginUrl, body: {
      'email': email,
      'password': password,
    }).then((value) {
      loginMdoel = UserModel.fromJson(value.data);
      token = loginMdoel.data.token;
      print('Inside login Screen');
      print(token);
      emit(SuccessLoginScreenState(loginMdoel));
      HomeCubit.get(context).loadHome();
      HomeCubit.get(context).loadCategories();
      AppCubit.get(context).currentIndex = 0;
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLoginScreenState(error.toString()));
    });
  }

  bool isObsecure = true;
  IconData iconData = Icons.visibility;
  void changePasswordObsecure() {
    isObsecure = !isObsecure;
    iconData = isObsecure ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordState());
  }
}
