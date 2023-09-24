abstract class WishlistRepository {
  Future<bool> isProductInWishlist({required String productId});
  Future<bool> addToWishlist({required String productId});
  Future<bool> removeFromWishlist({required String productId});
}
