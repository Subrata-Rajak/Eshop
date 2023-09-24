// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetailsOwnerInfo ownerInfo;
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

  ProductDetails({
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

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
        ownerInfo: ProductDetailsOwnerInfo.fromJson(json["owner_info"]),
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

class ProductDetailsOwnerInfo {
  String email;

  ProductDetailsOwnerInfo({
    required this.email,
  });

  factory ProductDetailsOwnerInfo.fromJson(Map<String, dynamic> json) =>
      ProductDetailsOwnerInfo(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
