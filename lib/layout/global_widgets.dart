import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cached_helper.dart';
import 'package:shop_app/models/favorite_model.dart';
import 'package:shop_app/modules/auth_screens/login_screen/login_screen.dart';
import 'package:shop_app/modules/auth_screens/profile_screen/profile_screen.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/bloc/home_cubit/favorite_cubit.dart';
import 'package:shop_app/shared/bloc/home_cubit/favorite_states.dart';
import 'package:shop_app/shared/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/bloc/home_cubit/home_cubit_states.dart';
import 'package:shop_app/shared/componeents/components.dart';

Widget homeScreen() {
  return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        if (state is LoadingHomeeState)
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          );
        else if (state is SuccessHomeState) {
          HomeCubit homeCubit = HomeCubit.get(context);
          if (homeCubit.homeModel != null && homeCubit.categoryModel != null)
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Banners
                  CarouselSlider.builder(
                      itemCount: homeCubit.homeModel.homeData.banners.length,
                      itemBuilder: (context, index, _) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          child: imageNetworkCached(homeCubit
                              .homeModel.homeData.banners[index].image),
                        );
                      },
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        reverse: false,
                        enableInfiniteScroll: true,
                        initialPage: 0,
                        viewportFraction: 1,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(seconds: 1),
                      )),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Categories',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Container(
                          height: 110,
                          child: ListView.separated(
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 5,
                                  ),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 110,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    children: [
                                      Container(
                                          height: double.infinity,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: imageNetworkCached(
                                                  homeCubit
                                                      .categoryModel
                                                      .data
                                                      .categories[index]
                                                      .image))),
                                      Container(
                                        width: double.infinity,
                                        color: Colors.black.withOpacity(0.7),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        child: Text(
                                          homeCubit.categoryModel.data
                                              .categories[index].name,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Top Products',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  //products
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.grey.shade300,
                    child: GridView.builder(
                      itemCount: homeCubit.homeModel.homeData.products.length,
                      shrinkWrap:
                          true, //هتخليها تاخد الهايت المتاح من غير منتا تحدد
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10, //y
                          mainAxisSpacing: 10, //x
                          childAspectRatio: 1 / 1.4),
                      itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: imageNetworkCached(homeCubit.homeModel
                                      .homeData.products[index].image),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: Text(
                                  homeCubit
                                      .homeModel.homeData.products[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${homeCubit.homeModel.homeData.products[index].price.toInt()}'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${homeCubit.homeModel.homeData.products[index].oldPrice.toInt()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor: Colors.red),
                                    ),
                                    Spacer(),
                                    BlocBuilder<FavoriteCubit, FavoriteStates>(
                                      builder: (context, state) => IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            FavoriteCubit.get(context)
                                                .toggleFavoriteProduct(
                                                    homeCubit.homeModel.homeData
                                                        .products[index].id,
                                                    context);
                                          },
                                          color: Colors.redAccent,
                                          icon: Icon(homeCubit.favoriteProducts[
                                                  homeCubit.homeModel.homeData
                                                      .products[index].id]
                                              ? Icons.favorite
                                              : Icons
                                                  .favorite_border_outlined)),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
          
        }
        return Center(child: Text('Error'));
      },
      listener: (context, state) {});
}

Widget categoriesScreen({BuildContext context}) {
  HomeCubit homeCubit = HomeCubit.get(context);
  return BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
    if (state is SuccessHomeState) {
      if (homeCubit.homeModel != null && homeCubit.categoryModel != null) {
        return Container(
          color: Colors.grey.shade300,
          child: GridView.builder(
              itemCount: homeCubit.categoryModel.data.categories.length,
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.4),
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.red,
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Expanded(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: imageNetworkCached(homeCubit
                                  .categoryModel.data.categories[index].image),
                            ),
                          ),
                        ),
                        Text(
                          homeCubit.categoryModel.data.categories[index].name,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      } else
        return Center(
          child: CircularProgressIndicator(),
        );
    } else if (state is LoadingHomeeState)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Text('Error');
  });
}

Widget settingsScreen({BuildContext context}) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          buildItemSettings(context, name: 'Profile', iconData: Icons.person,
              ontap: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          }),
          buildItemSettings(context,
              name: 'Dark Mode', iconData: Icons.brightness_4, ontap: () {
            AppCubit.get(context).toggleAppMode();
          }),
          buildItemSettings(context, name: 'LOG OUT', iconData: Icons.logout,
              ontap: () async {
            await CacheHelper.removeData('token');
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          })
        ],
      ),
    ),
  );
}

Widget favoriteScree({BuildContext context}) {
  FavoriteCubit.get(context).getFavoriteProducts();
  return BlocBuilder<FavoriteCubit, FavoriteStates>(builder: (context, state) {
    if (state is LoadingFavoriteProductsState)
      return Center(
        child: CircularProgressIndicator(),
      );
    else if (state is ErrorFavoriteState)
      return Text('Error');
    else {
      FavoriteCubit favoriteCubit = FavoriteCubit.get(context);
      List<FavoriteProductsData> favProducts =
          favoriteCubit.favoriteModel.favoriteData.favoriteProductsData;
      return GridView.builder(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemCount: favProducts.length,
          itemBuilder: (context, index) {
            return Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: imageNetworkCached(
                            favProducts[index].productData.image),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(
                        favProducts[index].productData.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${favProducts[index].productData.price.toInt()}'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${favProducts[index].productData.oldPrice.toInt()}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red),
                          ),
                          Spacer(),
                          BlocBuilder<FavoriteCubit, FavoriteStates>(
                            builder: (context, state) => IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  FavoriteCubit.get(context)
                                      .toggleFavoriteProduct(
                                          favProducts[index].productData.id,
                                          context,
                                          isFavScreen: true);
                                },
                                color: Colors.redAccent,
                                icon: Icon(
                                    HomeCubit.get(context).favoriteProducts[
                                            favProducts[index].productData.id]
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined)),
                          )
                        ],
                      ),
                    )
                  ],
                ));
          });
    }
  });
}
