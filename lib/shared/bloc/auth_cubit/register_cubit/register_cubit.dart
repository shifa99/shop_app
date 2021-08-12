import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/bloc/auth_cubit/register_cubit/register_cubit-states.dart';
import 'package:shop_app/shared/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/componeents/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(IdleRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel userModel;
  void register(BuildContext context,
      {String name, String phone, String email, String password}) {
    //try
    DioHelper.dio.options.headers = {
      'lang': 'ar',
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    emit(LoadingRegisterState());
    DioHelper.setData(methodUrl: registerUrl, body: {
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);

      emit(SuccessRegisterState());
      HomeCubit.get(context).loadHome();
      HomeCubit.get(context).loadCategories();
      AppCubit.get(context).currentIndex = 0;
    }).catchError((error) {
      emit(ErrorStateRegisterState());
    });
  }
}
