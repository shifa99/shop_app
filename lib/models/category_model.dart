import 'package:flutter/cupertino.dart';

import 'home_model.dart';

class CategoryModel {
  @required
  bool state;
  @required
  String message;
  @required
  CategoriesData data;
  CategoryModel({this.state, this.message});
  CategoryModel.fromJson(
    Map categoriesData,
  ) {
    state = categoriesData['status'];
    message = categoriesData['message'];
    data = CategoriesData.fromJson(categoriesData['data']);
  }
}

class CategoriesData {
  int currentPage;
  List<Category> categories = [];
  String firstPageUrl;
  int from;
  int lastPage;
  int to;
  int total;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  CategoriesData.fromJson(Map data) {
    currentPage = data['current_page'];
    firstPageUrl = data['first_page_url'];
    from = data['from'];
    to = data['to'];
    total = data['total'];
    lastPage = data['last_page'];
    lastPageUrl = data['last_page_url'];
    nextPageUrl = data['next_page_url'];
    perPage = data['per_page'];
    prevPageUrl = data['prev_page_url'];
    data['data'].forEach((category) {
      categories.add(Category.fromJson(category));
    });
  }
}
