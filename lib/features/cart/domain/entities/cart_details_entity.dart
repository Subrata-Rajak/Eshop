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

  Map<String, dynamic> toOrderItems() {
    List<Map<String, dynamic>> productsList = products.map((product) {
      return {
        'product_id': product.productId,
        'product_name': product.productName,
        'product_description': product.productDescription,
        'product_price': product.productPrice,
        'product_stock': product.productStock,
        'cart_quantity': product.cartQuantity,
        'product_image_url': product.productImageUrl,
        'id': product.id,
      };
    }).toList();

    return {
      'user_email': userEmail,
      'products': productsList,
      // Add other properties as needed
    };
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
