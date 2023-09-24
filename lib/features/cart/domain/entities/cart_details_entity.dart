class CartDetailsEntity {
  String id;
  String userEmail;
  List<CartDetailsProductEntity> products;
  int v;

  CartDetailsEntity({
    required this.id,
    required this.userEmail,
    required this.products,
    required this.v,
  });
}

class CartDetailsProductEntity {
  String productId;
  String productName;
  String productDescription;
  int productPrice;
  int productStock;
  int cartQuantity;
  String productImageUrl;
  String id;

  CartDetailsProductEntity({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productStock,
    required this.cartQuantity,
    required this.productImageUrl,
    required this.id,
  });
}
