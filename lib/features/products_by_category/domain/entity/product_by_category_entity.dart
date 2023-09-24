class ProductByCategoryEntity {
  List<ProductByCategoryProductEntity> productByCategory;

  ProductByCategoryEntity({required this.productByCategory});
}

class ProductByCategoryProductEntity {
  ProductByCategoryOwnerInfoEntity ownerInfo;
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

  ProductByCategoryProductEntity({
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
}

class ProductByCategoryOwnerInfoEntity {
  final String email;

  ProductByCategoryOwnerInfoEntity({required this.email});
}
