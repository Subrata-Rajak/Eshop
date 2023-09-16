// To parse this JSON data, do
//
//     final singleProduct = singleProductFromJson(jsonString);

import 'dart:convert';

SingleProduct singleProductFromJson(String str) =>
    SingleProduct.fromJson(json.decode(str));

String singleProductToJson(SingleProduct data) => json.encode(data.toJson());

class SingleProduct {
  SingleProductsOwnerInfo ownerInfo;
  String id;
  String name;
  String description;
  int price;
  String category;
  String subCategory;
  String brand;
  List<String> imageUrl;
  int stockQuantity;
  List<String?> reviews;
  int v;

  SingleProduct({
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
  });

  factory SingleProduct.fromJson(Map<String, dynamic> json) => SingleProduct(
        ownerInfo: SingleProductsOwnerInfo.fromJson(json["owner_info"]),
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: json["category"],
        subCategory: json["sub_category"],
        brand: json["brand"],
        imageUrl: List<String>.from(json["image_url"].map((x) => x)),
        stockQuantity: json["stock_quantity"],
        reviews: List<String?>.from(json["reviews"].map((x) => x)),
        v: json["__v"],
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
        "image_url": List<String>.from(imageUrl.map((x) => x)),
        "stock_quantity": stockQuantity,
        "reviews": List<String?>.from(reviews.map((x) => x)),
        "__v": v,
      };
}

class SingleProductsOwnerInfo {
  String email;

  SingleProductsOwnerInfo({
    required this.email,
  });

  factory SingleProductsOwnerInfo.fromJson(Map<String, dynamic> json) =>
      SingleProductsOwnerInfo(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
