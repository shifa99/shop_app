import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/cached_helper.dart';
import 'package:shop_app/modules/auth_screens/login_screen/login_screen.dart';
import 'package:shop_app/shared/bloc/auth_cubit/profile_cubit/profile_cubit.dart';
import 'package:shop_app/shared/bloc/auth_cubit/profile_cubit/profile_cubit_states.dart';
import 'package:shop_app/shared/componeents/components.dart';
import 'package:shop_app/shared/componeents/constants.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = 'profileScreen';
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),
        body: SafeArea(
      child: BlocProvider(
        create: (context) => ProfileCubit()..loadProfile(),
        child: BlocConsumer<ProfileCubit, ProfileCubitStates>(
            listener: (context, state) {
          if (state is UpdateProfileState)
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.userModel.message)));
        }, builder: (context, state) {
          if (state is LoadingProfileState)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if (state is LoadingUpdateeProfileState)
            return LinearProgressIndicator(
              backgroundColor: Colors.lightGreen,
            );
          else if (state is SuccessProfileState ||
              state is UpdateProfileState) {
          var userModel=  ProfileCubit.get(context).userModel;
            emailController.text = userModel.data.email;
            nameController.text = userModel.data.name;
            phoneController.text = userModel.data.phone;
            return Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // CircleAvatar(
                        //   radius: 50,
                        //   child: imageNetworkCached(
                        //       ProfileCubit.get(context).userModel.data.image),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        defaultTextFormFieled(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            iconPrefix: Icons.email_rounded,
                            text: 'Email Address',
                            validator: (email) {
                              if (email.isEmpty()) return 'Please Enter Email';
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormFieled(
                            controller: nameController,
                            textInputType: TextInputType.name,
                            iconPrefix: Icons.lock,
                            text: 'Name ',
                            validator: (name) {
                              if (name.isEmpty()) return 'Please Enter name';
                              return null;
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        defaultTextFormFieled(
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            iconPrefix: Icons.phone,
                            text: 'Phone',
                            validator: (phone) {
                              if (phone.isEmpty())
                                return 'Please Enter Phone Number';
                              return null;
                            }),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: double.infinity,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                elevation: 5,
                                backgroundColor: Colors.cyan,
                              ),
                              onPressed: () async {
                                ProfileCubit.get(context).updateProfileData(
                                    nameController.text,
                                    phoneController.text,
                                    emailController.text);
                              },
                              child: Text(
                                'UPDATE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          child: TextButton.icon(
                              icon: Icon(Icons.logout,color: Colors.white,),
                              style: TextButton.styleFrom(
                                elevation: 5,
                                backgroundColor: Colors.cyan,
                              ),
                              onPressed: () async 
                              {
                                await CacheHelper.removeData('token');
                                Navigator.pushReplacementNamed(
                                    context, LoginScreen.routeName);
                              },
                              label: Text(
                                'LOG OUT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else
            return Center(child: Text('Error'));
        }),
      ),
    ));
  }
}
