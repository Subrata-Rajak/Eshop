// To parse this JSON data, do
//
//     final cartDetails = cartDetailsFromJson(jsonString);

import 'dart:convert';

CartDetails cartDetailsFromJson(String str) =>
    CartDetails.fromJson(json.decode(str));

String cartDetailsToJson(CartDetails data) => json.encode(data.toJson());

class CartDetails {
  String id;
  String userEmail;
  List<CartDetailsProduct> products;
  int v;

  CartDetails({
    required this.id,
    required this.userEmail,
    required this.products,
    required this.v,
  });

  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
        id: json["_id"],
        userEmail: json["user_email"],
        products: List<CartDetailsProduct>.from(
            json["products"].map((x) => CartDetailsProduct.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_email": userEmail,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "__v": v,
      };
}

class CartDetailsProduct {
  String productId;
  String productName;
  String productDescription;
  int productPrice;
  int productStock;
  int cartQuantity;
  String productImageUrl;
  String id;

  CartDetailsProduct({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productStock,
    required this.cartQuantity,
    required this.productImageUrl,
    required this.id,
  });

  factory CartDetailsProduct.fromJson(Map<String, dynamic> json) =>
      CartDetailsProduct(
        productId: json["product_id"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productPrice: json["product_price"],
        productStock: json["product_stock"],
        cartQuantity: json["cart_quantity"],
        productImageUrl: json["product_image_url"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_description": productDescription,
        "product_price": productPrice,
        "product_stock": productStock,
        "cart_quantity": cartQuantity,
        "product_image_url": productImageUrl,
        "_id": id,
      };
}
