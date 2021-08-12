import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit_states.dart';


class HomeScreen extends StatelessWidget {
  static String routeName = 'homeScreen';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppCubitStates>(
      builder: (context, states) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Shopping'),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){}, icon: Icon(Icons.search)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.green,
            elevation: 0,
        
            currentIndex: AppCubit.get(context).currentIndex,
          
            onTap: (index) {
              AppCubit.get(context).changeBottomNavigation(index);
            },
            backgroundColor: Colors.grey.shade300,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.category,
                  ),
                  label: 'Categories'),
                  BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_sharp,
                  ),
                  label: 'Favorites'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings'),
                 
            ],
          ),
         
          body: SafeArea(child: AppCubit.get(context).selectedScreen(context)),
        );
      },
    );
  }
}
