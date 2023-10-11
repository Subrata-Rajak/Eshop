class SearchedProductListEntity {
  List<SearchedProductEntity> searchedProductList;

  SearchedProductListEntity({required this.searchedProductList});
}

class SearchedProductEntity {
  SearchedProductOwnerInfoEntity ownerInfo;
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
  List<String> searchTags;
  List<dynamic> coupons;

  SearchedProductEntity({
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
    required this.searchTags,
    required this.coupons,
  });
}

class SearchedProductOwnerInfoEntity {
  String email;

  SearchedProductOwnerInfoEntity({required this.email});
}
