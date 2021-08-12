import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/global_widgets.dart';
import 'package:shop_app/models/cached_helper.dart';
import 'package:shop_app/shared/componeents/constants.dart';

import 'app_cubit_states.dart';

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(IdleModeApp());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark = true;
  int indexPageView = 0;
  bool lastPage = false;
  Future<void> changeMode({bool fromShared}) async {
    //first time
    if (fromShared != null)
      isDark = fromShared;
    else {
      print('Enter to change');
      isDark = !isDark;
      //await CachedHelper.setData('mode', isDark);
      emit(ChangeModeApp());
    }
  }

  void changeIndexPageView(
    bool isLast,
  ) {
    lastPage = isLast;
  }

  void changeIndexPage(bool isLast, int index) {
    lastPage = isLast;
    indexPageView = index;
  }

  int currentIndex = 0;
  Widget selectedScreen(BuildContext context) {
    List<Widget> screens = [
      homeScreen(),
      categoriesScreen(context: context),
      favoriteScree(context: context),
      settingsScreen(context: context)
    ];
    return screens[currentIndex];
  }

  void changeBottomNavigation(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigation());
  }

  void toggleAppMode({bool fromPrf}) {
    if (fromPrf != null) {
      isDark = fromPrf;
      isDark = !isDark;
      CacheHelper.setData(key: 'mode', value: isDark);
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: 'mode', value: isDark);
    }
    darkMode = isDark;
    print(isDark);
    emit(ChangeAppModeState());
  }
}
