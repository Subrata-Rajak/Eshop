abstract class ProductDetailsCartRepository {
  Future<bool> addToCart({required String productId});
  Future<bool> removeFromCart({required String productId});
  Future<bool> isProductInCart({required String productId});
}
