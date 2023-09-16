// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

AllProductCategories allProductCategoriesFromJson(String str) =>
    AllProductCategories.fromJson(json.decode(str));

String allProductCategoriesToJson(AllProductCategories data) =>
    json.encode(data.toJson());

class AllProductCategories {
  List<ProductCategory> productCategories;

  AllProductCategories({
    required this.productCategories,
  });

  factory AllProductCategories.fromJson(Map<String, dynamic> json) =>
      AllProductCategories(
        productCategories: List<ProductCategory>.from(
            json["product_categories"].map((x) => ProductCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_categories":
            List<dynamic>.from(productCategories.map((x) => x.toJson())),
      };
}

class ProductCategory {
  String id;
  String categoryName;
  String categoryImageUrl;
  List<String> subCategories;
  int v;

  ProductCategory({
    required this.id,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.subCategories,
    required this.v,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["_id"],
        categoryName: json["category_name"],
        categoryImageUrl: json["category_image_url"],
        subCategories: List<String>.from(json["sub_categories"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
        "category_image_url": categoryImageUrl,
        "sub_categories": List<dynamic>.from(subCategories.map((x) => x)),
        "__v": v,
      };
}
