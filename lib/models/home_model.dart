import 'package:flutter/cupertino.dart';

class HomeModel {
  @required
  final bool status;
  @required
  final String message;
  @required
  final HomeData homeData;
  HomeModel({this.status, this.message, this.homeData});
  factory HomeModel.fromJson(Map home) {
    return HomeModel(
        status: home['status'],
        message: home['message'],
        homeData: HomeData.fromJson(home['data']));
  }
}

class HomeData {
  List<Banner> banners=[];
  List<Product> products=[];
  HomeData.fromJson(Map data) {
    data['banners'].forEach((element) {
      banners.add(Banner.fromJson(element));
    });
    data['products'].forEach((element) {
      products.add(Product.fromJson(element));
    });
  }
}

class Banner {
  final int id;
  final String image;
  final Category category;
  final String products;
  Banner({this.id, this.image, this.category, this.products});
  factory Banner.fromJson(Map banner) {
    return Banner(
        id: banner['id'],
        image: banner['image'],
        category: Category.fromJson(banner['category']),
        products: banner['product']);
  }
}

class Category 
{
  @required
  final int id;
  @required
  final String image;
  @required
  final String name;
  Category({this.id, this.image, this.name});
  factory Category.fromJson(Map category) {
    return Category(
        id: category['id'], image: category['image'], name: category['name']);
  }
}

class Product {
  @required
  final int id;
  @required
  final dynamic price;
  @required
  final dynamic oldPrice;
  @required
  final dynamic discount;
  @required
  final String image;
  @required
  final List<dynamic> images;
  @required
  final String name;
  @required
  final String description;
  @required
  final bool favorite;
  @required
  final bool inCart;
  Product(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.images,
      this.name,
      this.description,
      this.favorite,
      this.inCart});
  factory Product.fromJson(Map product) 
  {
    return Product(
        id: product['id'],
        price: product['price'],
        image: product['image'],
        oldPrice: product['old_price'],
        images: product['images'],
        description: product['description'],
        discount: product['discount'],
        favorite: product['in_favorites'],
        inCart: product['in_cart'],
        name: product['name']);
  }
}
