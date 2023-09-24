import 'package:eshop/features/product_details/domain/repositories/wishlist_repository.dart';

class IsProductInWishListUsecase {
  final WishlistRepository wishlistRepository;

  IsProductInWishListUsecase({required this.wishlistRepository});

  Future<bool> isProductInWishlist({required String productId}) async {
    return await wishlistRepository.isProductInWishlist(productId: productId);
  }
}
