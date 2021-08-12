import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/models/cached_helper.dart';
import 'package:shop_app/modules/auth_screens/login_screen/login_screen.dart';
import 'package:shop_app/modules/auth_screens/profile_screen/profile_screen.dart';
import 'package:shop_app/modules/auth_screens/register_screen.dart/register_screen.dart';
import 'package:shop_app/modules/onboarding_screen/onboarding_screen.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit_states.dart';
import 'package:shop_app/shared/bloc/bloc_observer.dart';
import 'package:shop_app/shared/bloc/home_cubit/favorite_cubit.dart';
import 'package:shop_app/shared/bloc/home_cubit/home_cubit.dart';
import 'package:shop_app/shared/componeents/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding();
  Bloc.observer = SimpleBlocObserver();
  HttpOverrides.global = new MyHttpOverrides();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData('onBoarding');

  token = CacheHelper.getData('token');
   darkMode = CacheHelper.getData('mode');
  print(token);
  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final bool onBoarding;
  final String token;
  MyApp({this.onBoarding, this.token});
  Widget startScreen() {
    if (onBoarding != null) {
      if (token != null)
        return HomeScreen();
      else
        return LoginScreen();
    }
    return OnboardingScreen();
  }

 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()..toggleAppMode(fromPrf: darkMode)),
        BlocProvider(
            create: (context) => HomeCubit()
              ..loadHome()
              ..loadCategories()),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
      ],
      child:
      
      BlocBuilder<AppCubit,AppCubitStates>(
builder: (context,states){
  return 
  MaterialApp(
        routes: {
          LoginScreen.routeName: (_) => LoginScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          ProfileScreen.routeName: (_) => ProfileScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: whiteTheme,
        darkTheme: darkTheme,
        home: startScreen(),
        themeMode:darkMode?ThemeMode.dark:ThemeMode.light,
      );

},
      )
      
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
