// To parse this JSON data, do
//
//     final searchedProduct = searchedProductFromJson(jsonString);

import 'dart:convert';

SearchedProductList searchedProductFromJson(String str) =>
    SearchedProductList.fromJson(json.decode(str));

String searchedProductToJson(SearchedProductList data) =>
    json.encode(data.toJson());

class SearchedProductList {
  List<SearchedProduct> productsList;

  SearchedProductList({
    required this.productsList,
  });

  factory SearchedProductList.fromJson(Map<String, dynamic> json) =>
      SearchedProductList(
        productsList: List<SearchedProduct>.from(
            json["products"].map((x) => SearchedProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(productsList.map((x) => x.toJson())),
      };
}

class SearchedProduct {
  SearchedProductOwnerInfo ownerInfo;
  String id;
  String name;
  String description;
  int price;
  String category;
  String subCategory;
  String brand;
  List<String> imageUrl;
  int stockQuantity;
  List<dynamic> reviews;
  int v;
  List<String> searchTags;
  List<dynamic> coupons;

  SearchedProduct({
    required this.ownerInfo,
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.subCategory,
    required this.brand,
    required this.imageUrl,
    required this.stockQuantity,
    required this.reviews,
    required this.v,
    required this.searchTags,
    required this.coupons,
  });

  factory SearchedProduct.fromJson(Map<String, dynamic> json) =>
      SearchedProduct(
        ownerInfo: SearchedProductOwnerInfo.fromJson(json["owner_info"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        subCategory: json["sub_category"],
        brand: json["brand"],
        imageUrl: List<String>.from(json["image_url"].map((x) => x)),
        stockQuantity: json["stock_quantity"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        v: json["__v"],
        searchTags: List<String>.from(json["search_tags"].map((x) => x)),
        coupons: List<dynamic>.from(json["coupons"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "owner_info": ownerInfo.toJson(),
        "_id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category,
        "sub_category": subCategory,
        "brand": brand,
        "image_url": List<dynamic>.from(imageUrl.map((x) => x)),
        "stock_quantity": stockQuantity,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "__v": v,
        "search_tags": List<dynamic>.from(searchTags.map((x) => x)),
        "coupons": List<dynamic>.from(coupons.map((x) => x)),
      };
}

class SearchedProductOwnerInfo {
  String email;

  SearchedProductOwnerInfo({
    required this.email,
  });

  factory SearchedProductOwnerInfo.fromJson(Map<String, dynamic> json) =>
      SearchedProductOwnerInfo(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
