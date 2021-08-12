import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cached_helper.dart';
import 'package:shop_app/models/onboarding.dart';
import 'package:shop_app/modules/auth_screens/login_screen/login_screen.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/bloc/app_cubit/app_cubit_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageViewBuilder(pageController: pageController),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                  ),
                  Spacer(),
                  BlocConsumer<AppCubit, AppCubitStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      print('rebuild');
                      return FloatingActionButton(
                          backgroundColor: Colors.deepOrange,
                          child: Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            if (!AppCubit.get(context).lastPage) {
                              pageController
                                  .nextPage(
                                      duration: Duration(
                                        milliseconds: 500,
                                      ),
                                      curve: Curves.bounceIn)
                                  .then((value) {
                                AppCubit.get(context).changeIndexPageView(
                                  pageController.page.toInt() ==
                                      onboardingModels.length - 1,
                                );
                              });
                            } else {
                              CacheHelper.setData(
                                  key: 'onBoarding', value: true);
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            }
                          });
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: BouncingScrollPhysics(),
      controller: pageController,
      onPageChanged: (index) {
        if (index == onboardingModels.length - 1) {
          AppCubit.get(context).changeIndexPage(true, index);
        } else
          AppCubit.get(context).changeIndexPage(false, index);
      },
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(onboardingModels[index].imageName)),
          Text(
            onboardingModels[index].title,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 15,
          ),
          Text(onboardingModels[index].description),
        ],
      ),
      itemCount: onboardingModels.length,
    );
  }
}
