class FavoriteModel {
  final bool status;
  final String message;
  final FavoriteData favoriteData;
  FavoriteModel({this.status, this.message, this.favoriteData});
  factory FavoriteModel.fromJson(Map data) {
    return FavoriteModel(status: data['status'],message: data['message'],favoriteData:
   FavoriteData.fromJson( data['data']) );
  }
}

class FavoriteData {
  int currentPage;
  List<FavoriteProductsData> favoriteProductsData = [];
  FavoriteData.fromJson(Map data) 
  {
    currentPage = data['current_page'];
    data['data'].forEach((product) 
    {
      favoriteProductsData.add(FavoriteProductsData.fromJson(product));
    });
  }
}

class FavoriteProductsData {
  final int id;
  final ProductData productData;
  FavoriteProductsData({this.id, this.productData});
  factory FavoriteProductsData.fromJson(Map fav) {
    return FavoriteProductsData(id: fav['id'], productData:ProductData.fromJson(fav['product']));
  }
}

class ProductData {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;
  ProductData(
      {this.id,
      this.price,
      this.oldPrice,
      this.discount,
      this.image,
      this.name,
      this.description});
  factory ProductData.fromJson(Map product) {
    return ProductData(
        id: product['id'],
        price: product['price'],
        oldPrice: product['old_price'],
        discount: product['discount'],
        image: product['image'],
        name: product['name'],
        description: product['description']);
  }
}

