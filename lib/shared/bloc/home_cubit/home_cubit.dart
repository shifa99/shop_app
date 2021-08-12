import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/bloc/home_cubit/home_cubit_states.dart';
import 'package:shop_app/shared/componeents/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(IdleHomeState());
  HomeModel homeModel;
  CategoryModel categoryModel;
  Map<int, bool> favoriteProducts = {};
  static HomeCubit get(context) => BlocProvider.of(context);
  void loadHome() {
    emit(LoadingHomeeState());
    DioHelper.getData(
      method: homeUrl,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      favoriteProducts = {};
      homeModel.homeData.products.forEach((element) {
        favoriteProducts.addAll({element.id: element.favorite});
      });
      emit(SuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeState());
    });
  }

  void loadCategories() {
    emit(LoadingHomeeState());
    DioHelper.getData(
      method: categoriesUrl,
    ).then((value) {
      //   print(value.data);
      categoryModel = CategoryModel.fromJson(value.data);
     
      emit(SuccessHomeState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeState());
    });
  }

  
}
