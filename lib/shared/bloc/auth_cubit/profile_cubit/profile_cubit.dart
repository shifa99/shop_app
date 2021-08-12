import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/shared/bloc/auth_cubit/profile_cubit/profile_cubit_states.dart';
import 'package:shop_app/shared/componeents/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ProfileCubit extends Cubit<ProfileCubitStates> {
  ProfileCubit() : super(IdleProfileState());
  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel userModel;
  void loadProfile() {
    emit(LoadingProfileState());
    DioHelper.getData(method: profileUrl).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(SuccessProfileState(userModel));
    }).catchError((error) {
      emit(ErrorProfileState());
    });
  }

  void updateProfileData(String name, String phone, String email) {
    emit(LoadingUpdateeProfileState());
    DioHelper.putData(methodUrl: updateProfileUrl, body: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
            emit(UpdateProfileState(userModel));

    }).catchError((error) {
      emit(ErrorProfileState());
    });
  }
}
