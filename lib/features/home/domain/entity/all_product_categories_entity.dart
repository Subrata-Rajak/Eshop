class AllProductsCategoryEntity {
  List<ProductCategory> allProductCategories;

  AllProductsCategoryEntity({required this.allProductCategories});
}

class ProductCategory {
  String id;
  String categoryName;
  String categoryImageUrl;
  List<String> subCategories;

  ProductCategory({
    required this.id,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.subCategories,
  });
}
