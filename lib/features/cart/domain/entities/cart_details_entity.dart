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

  List<Map<String, dynamic>> toOrderItems() {
    List<Map<String, dynamic>> productsList = products
        .map(
          (product) => {
            'product_id': product.productId,
            'product_name': product.productName,
            'product_description': product.productDescription,
            'product_price': product.productPrice,
            'stock_quantity': product.productStock,
            'cart_quantity': product.cartQuantity,
            'product_image_url': product.productImageUrl,
          },
        )
        .toList();

    return productsList;
  }
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
