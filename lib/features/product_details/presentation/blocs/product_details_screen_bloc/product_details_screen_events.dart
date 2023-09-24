abstract class ProductDetailsScreenEvents {}

class ProductDetailsFetchingEvent extends ProductDetailsScreenEvents {
  final String productId;

  ProductDetailsFetchingEvent({required this.productId});
}

class AddToWishListEvent extends ProductDetailsScreenEvents {
  final String productId;

  AddToWishListEvent({required this.productId});
}

class RemoveFromWishlistEvent extends ProductDetailsScreenEvents {
  final String productId;

  RemoveFromWishlistEvent({required this.productId});
}

class AddToCartEvent extends ProductDetailsScreenEvents {
  final String productId;

  AddToCartEvent({required this.productId});
}

class RemoveFromCartEvent extends ProductDetailsScreenEvents {
  final String productId;

  RemoveFromCartEvent({required this.productId});
}
