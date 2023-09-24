// To parse this JSON data, do
//
//     final wishlistItems = wishlistItemsFromJson(jsonString);

import 'dart:convert';

WishlistItems wishlistItemsFromJson(String str) =>
    WishlistItems.fromJson(json.decode(str));

String wishlistItemsToJson(List<WishlistItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistItems {
  String id;
  String userEmail;
  List<WishlistItemsProduct> products;
  int v;

  WishlistItems({
    required this.id,
    required this.userEmail,
    required this.products,
    required this.v,
  });

  factory WishlistItems.fromJson(Map<String, dynamic> json) => WishlistItems(
        id: json["_id"],
        userEmail: json["user_email"],
        products: List<WishlistItemsProduct>.from(
            json["products"].map((x) => WishlistItemsProduct.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_email": userEmail,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "__v": v,
      };
}

class WishlistItemsProduct {
  String productId;
  String productName;
  String productDescription;
  String productImageUrl;
  int productPrice;
  int productStock;
  String id;

  WishlistItemsProduct({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productImageUrl,
    required this.productPrice,
    required this.productStock,
    required this.id,
  });

  factory WishlistItemsProduct.fromJson(Map<String, dynamic> json) =>
      WishlistItemsProduct(
        productId: json["product_id"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productImageUrl: json["product_image_url"],
        productPrice: json["product_price"],
        productStock: json["product_stock"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_description": productDescription,
        "product_image_url": productImageUrl,
        "product_price": productPrice,
        "product_stock": productStock,
        "_id": id,
      };
}
