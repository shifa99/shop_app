import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/models/cached_helper.dart';
import 'package:shop_app/modules/auth_screens/login_screen/login_screen.dart';
import 'package:shop_app/shared/bloc/auth_cubit/register_cubit/register_cubit-states.dart';
import 'package:shop_app/shared/bloc/auth_cubit/register_cubit/register_cubit.dart';
import 'package:shop_app/shared/componeents/components.dart';
import 'package:shop_app/shared/componeents/constants.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = 'register_screen';
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Register',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Register And Enjoy :) '),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormFieled(
                          controller: nameController,
                          textInputType: TextInputType.name,
                          iconPrefix: Icons.person,
                          text: 'Name',
                          validator: (name) {
                            if (name.isEmpty) return 'Please Enter Name';
                            return null;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormFieled(
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          iconPrefix: Icons.phone,
                          text: 'Phone',
                          validator: (phone) {
                            if (phone.isEmpty) return 'Please Enter Phone';
                            return null;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormFieled(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          iconPrefix: Icons.email_rounded,
                          text: 'Email Addres',
                          validator: (email) {
                            if (email.isEmpty) return 'Please Enter Email';
                            return null;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormFieled(
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          iconPrefix: Icons.lock,
                          text: 'Password',
                          obscure: true,
                          iconSuffix: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: Icon(Icons.visibility)),
                          validator: (password) {
                            if (password.isEmpty)
                              return 'Please Enter Password';
                            return null;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      defaultTextFormFieled(
                          controller: confirmController,
                          textInputType: TextInputType.visiblePassword,
                          iconPrefix: Icons.lock,
                          text: 'Confirm Password',
                          obscure: true,
                          iconSuffix: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {},
                              icon: Icon(Icons.visibility)),
                          validator: (confirmPassword) {
                            if (confirmPassword.isEmpty)
                              return 'Please Enter confirm Password';
                            return null;
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      BlocConsumer<RegisterCubit, RegisterStates>(
                        listener: (context, state) {
                          if (state is ErrorStateRegisterState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('حدث خطأ')));
                          }
                        },
                        builder: (context, state) {
                          if (state is LoadingRegisterState)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          return TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.cyan,
                            ),
                            onPressed: () async {
                              print(formKey.currentState.validate());
                              if (formKey.currentState.validate()) {
                                if (passwordController.text ==
                                    confirmController.text) {
                                  RegisterCubit.get(context).register(context,
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text);
                                  token = RegisterCubit.get(context)
                                      .userModel
                                      .data
                                      .token;
                                  await CacheHelper.setData(
                                      key: 'token', value: token);
                                  Navigator.pushNamed(
                                      context, HomeScreen.routeName);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content:
                                              Text('كلمة السر غير صحيحة')));
                                }
                              }
                            },
                            child: Container(
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text('Do You Have Account Already ? '),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Text('LOGIN'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
