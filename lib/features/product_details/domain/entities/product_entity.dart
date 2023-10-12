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

  List<Map<String, dynamic>> toOrderItem() {
    return [
      {
        'product_id': id,
        'product_name': name,
        'product_description': description,
        'product_price': price,
        'product_image_url': imageUrl[0],
        'stock_quantity': stockQuantity,
        "cart_quantity": 1
      }
    ];
  }
}

class ProductDetailsOwnerInfoEntity {
  String email;

  ProductDetailsOwnerInfoEntity({required this.email});
}
