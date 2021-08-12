import 'package:shop_app/models/home_model.dart';

abstract class HomeStates {}

class IdleHomeState extends HomeStates {}

class LoadingHomeeState extends HomeStates {}

class SuccessHomeState extends HomeStates {
}

class ErrorHomeState extends HomeStates {}
class LoadingCategoriesState extends HomeStates{}
class SuccessCategoriesState extends HomeStates{}
class ErrorCategoriesState extends HomeStates{}
