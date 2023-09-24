abstract class WishlistScreenEvents {}

class WishlistScreenFetchDataEvent extends WishlistScreenEvents {}

class RemoveFromWishlistEvent extends WishlistScreenEvents {
  final String productId;

  RemoveFromWishlistEvent({required this.productId});
}
