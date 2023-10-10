class ProductDetailsEntity {
  ProductDetailsOwnerInfoEntity ownerInfo;
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

  ProductDetailsEntity({
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

  Map<String, dynamic> toOrderItem() {
    return {
      'product_id': id,
      'product_name': name,
      'product_description': description,
      'product_price': price,
      'product_category': category,
      'product_subcategory': subCategory,
      'product_brand': brand,
      'product_image_url': imageUrl,
      'stock_quantity': stockQuantity,
      'owner_email': ownerInfo.email,
      // Add other properties as needed
    };
  }
}

class ProductDetailsOwnerInfoEntity {
  String email;

  ProductDetailsOwnerInfoEntity({required this.email});
}
