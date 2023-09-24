class WishlistItemsEntity {
  String id;
  String userEmail;
  List<WishlistItemsProductEntity> products;
  int v;

  WishlistItemsEntity({
    required this.id,
    required this.userEmail,
    required this.products,
    required this.v,
  });
}

class WishlistItemsProductEntity {
  String productId;
  String productName;
  String productDescription;
  String productImageUrl;
  int productPrice;
  int productStock;
  String id;

  WishlistItemsProductEntity({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productImageUrl,
    required this.productPrice,
    required this.productStock,
    required this.id,
  });
}
