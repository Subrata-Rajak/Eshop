// To parse this JSON data, do
//
//     final allProducts = allProductsFromJson(jsonString);

import 'dart:convert';

AllProducts allProductsFromJson(String str) =>
    AllProducts.fromJson(json.decode(str));

String allProductsToJson(AllProducts data) => json.encode(data.toJson());

class AllProducts {
  List<Product> products;

  AllProducts({
    required this.products,
  });

  factory AllProducts.fromJson(Map<String, dynamic> json) => AllProducts(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  OwnerInfo ownerInfo;
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

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        ownerInfo: OwnerInfo.fromJson(json["owner_info"]),
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

class OwnerInfo {
  String email;

  OwnerInfo({
    required this.email,
  });

  factory OwnerInfo.fromJson(Map<String, dynamic> json) => OwnerInfo(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
