// To parse this JSON data, do
//
//     final productByCategory = productByCategoryFromJson(jsonString);

import 'dart:convert';

ProductByCategory productByCategoryFromJson(String str) =>
    ProductByCategory.fromJson(json.decode(str));

String productByCategoryToJson(ProductByCategory data) =>
    json.encode(data.toJson());

class ProductByCategory {
  List<ProductByCategoryProduct> products;

  ProductByCategory({
    required this.products,
  });

  factory ProductByCategory.fromJson(Map<String, dynamic> json) =>
      ProductByCategory(
        products: List<ProductByCategoryProduct>.from(
            json["products"].map((x) => ProductByCategoryProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductByCategoryProduct {
  ProductByCategoryOwnerInfo ownerInfo;
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

  ProductByCategoryProduct({
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

  factory ProductByCategoryProduct.fromJson(Map<String, dynamic> json) =>
      ProductByCategoryProduct(
        ownerInfo: ProductByCategoryOwnerInfo.fromJson(json["owner_info"]),
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
      };
}

class ProductByCategoryOwnerInfo {
  String email;

  ProductByCategoryOwnerInfo({
    required this.email,
  });

  factory ProductByCategoryOwnerInfo.fromJson(Map<String, dynamic> json) =>
      ProductByCategoryOwnerInfo(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
