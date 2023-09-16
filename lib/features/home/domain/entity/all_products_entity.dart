class AllProductsEntity {
  List<Product> products;

  AllProductsEntity({required this.products});
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
}

class OwnerInfo {
  String email;

  OwnerInfo({required this.email});
}
