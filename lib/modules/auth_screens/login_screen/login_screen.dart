import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/models/cached_helper.dart';
import 'package:shop_app/modules/auth_screens/register_screen.dart/register_screen.dart';
import 'package:shop_app/shared/bloc/auth_cubit/change_visiable_password_cubit/change_visiable_password_cubit.dart';
import 'package:shop_app/shared/bloc/auth_cubit/change_visiable_password_cubit/change_visiable_password_cubit_state.dart';
import 'package:shop_app/shared/bloc/auth_cubit/login_cubit/login_cubit.dart';
import 'package:shop_app/shared/bloc/auth_cubit/login_cubit/login_cubit_states.dart';
import 'package:shop_app/shared/componeents/components.dart';
import 'package:shop_app/shared/componeents/constants.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'loginScreen';
  var formKey = GlobalKey<FormState>();
  TextEditingController emialController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      'Shopping time is now buy and enjoy',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultTextFormFieled(
                        controller: emialController,
                        textInputType: TextInputType.emailAddress,
                        iconPrefix: Icons.email,
                        text: 'Email Address',
                        validator: (String emial) {
                          if (emial.isEmpty)
                            return 'Please Enter Email Address';
                          return null;
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    BlocProvider(
                      create: (context) => ChangeVisiblePasswordCubit(),
                      child: BlocConsumer<ChangeVisiblePasswordCubit,
                              ChangeVisiblePasswordStates>(
                          builder: (context, state) {
                            print('rebuild 2');
                            return defaultTextFormFieled(
                              controller: passwordController,
                              textInputType: TextInputType.text,
                              iconPrefix: Icons.lock,
                              text: 'Password',
                              validator: (password) {
                                if (password.isEmpty)
                                  return 'Please Enter Password';
                                return null;
                              },
                              iconSuffix: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                      ChangeVisiblePasswordCubit.get(context)
                                          .iconData),
                                  onPressed: () {
                                    ChangeVisiblePasswordCubit.get(context)
                                        .changePasswordObsecure();
                                  }),
                              obscure: ChangeVisiblePasswordCubit.get(context)
                                  .isObsecure,
                            );
                          },
                          listener: (context, state) {}),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    BlocConsumer<LoginCubit, LoginScreenStates>(
                        builder: (context, state) {
                      if (state is! LoadingLoginScreenState)
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState.validate()) {
                              LoginCubit.get(context).login(context,
                                  email: emialController.text,
                                  password: passwordController.text);
                             
                            }
                          },
                          child: Text('Login'),
                        );
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }, listener: (context, state) {
                      if (state is SuccessLoginScreenState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.userModel.message),
                          backgroundColor: state.userModel.status
                              ? Colors.greenAccent
                              : Colors.red,
                        ));
                        if (state.userModel.status) {
                          print(state.userModel.data.token);
                          CacheHelper.setData(
                                  key: 'token',
                                  value: state.userModel.data.token)
                              .then((value) {
                            token = state.userModel.data.token;
                          });
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.routeName);
                        }
                      }
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text('Are You Registered? '),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: Text('Register')),
                      ],
                    ),
                  ],
                )),
          ),
        ))),
      ),
    );
  }
}
