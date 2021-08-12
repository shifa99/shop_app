import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/shared/bloc/home_cubit/favorite_states.dart';
import 'package:shop_app/shared/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/componeents/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class FavoriteCubit extends Cubit<FavoriteStates> {
  FavoriteCubit() : super(IdleFavoriteState());
  static FavoriteCubit get(context) => BlocProvider.of(context);
  FavoriteModel favoriteModel;
  void toggleFavoriteProduct(int productId, BuildContext context,
      {bool isFavScreen = false}) {
    HomeCubit.get(context).favoriteProducts[productId] =
        !HomeCubit.get(context).favoriteProducts[productId];
    emit(ChnageFavoriteState());

    //toggle here
    DioHelper.setData(methodUrl: favoirteUrl, body: {
      'product_id': productId,
    }).then((value) {
      emit(SuccessFavoriteState(
          message: value.data['message'], status: value.data['status']));
          if(isFavScreen)
      FavoriteCubit.get(context).getFavoriteProducts();
    }).catchError((error) {
      HomeCubit.get(context).favoriteProducts[productId] =
          !HomeCubit.get(context).favoriteProducts[productId];
      emit(ErrorFavoriteState(error.toString()));
      //toggle Here,
    });
  }

  void getFavoriteProducts() {
    emit(LoadingFavoriteProductsState());
    DioHelper.getData(method: favoirteUrl).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(SuccessFavoriteProductsState());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorFavoriteState(error.toString()));
    });
  }
}
