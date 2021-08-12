import 'package:flutter/foundation.dart';

class UserModel {
  @required
  final bool status;
  @required
  final String message;
  @required
  final UserData data;
  UserModel({this.status, this.message, this.data});
  factory UserModel.fromJson(Map login) {
    return UserModel(
        data: login['data'] != null ? UserData.fromJson(login['data']) : null,
        message: login['message'],
        status: login['status']);
  }
}

class UserData {
  @required
  final int id;
  @required
  final String name;

  @required
  final String email;
  @required
  final String password;
  @required
  final String image;
  @required
  final String phone;
  @required
  final int points;
  @required
  final int credit;
  @required
  final String token;
  UserData(
      {this.name,
      this.id,
      this.email,
      this.password,
      this.image,
      this.phone,
      this.points,
      this.credit,
      this.token});
  factory UserData.fromJson(Map data) {
    return UserData(
        name: data['name'],
        id: data['id'],
        email: data['email'],
        password: data['password'],
        image: data['image'],
        token: data['token'],
        phone: data['phone'],
        points: data['points'],
        credit: data['credit']);
  }
}
