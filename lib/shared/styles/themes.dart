import 'package:flutter/material.dart';

ThemeData whiteTheme = ThemeData(
  textTheme: TextTheme(
    headline6: TextStyle(color: Colors.black),
    bodyText2: TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w800,
    ),
    bodyText1: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff9DDAC6),
    centerTitle: true,
    titleTextStyle: TextStyle(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: Colors.blue,
);
ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xff082032),
  textTheme: TextTheme(
      headline6: TextStyle(color: Colors.white),
      bodyText1: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w800,
      )),
  appBarTheme:
      AppBarTheme(backgroundColor: Color(0xff082032), centerTitle: true),
);
