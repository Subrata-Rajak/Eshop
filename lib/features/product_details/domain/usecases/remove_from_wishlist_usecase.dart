import 'package:eshop/features/product_details/domain/repositories/wishlist_repository.dart';

class RemoveFromWishlistUsecase {
  final WishlistRepository wishlistRepository;

  RemoveFromWishlistUsecase({required this.wishlistRepository});

  Future<bool> removeFromWishlist({required String productId}) async {
    return await wishlistRepository.removeFromWishlist(productId: productId);
  }
}
