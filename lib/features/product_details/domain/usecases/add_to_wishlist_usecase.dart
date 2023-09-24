import 'package:eshop/features/product_details/domain/repositories/wishlist_repository.dart';

class AddToWishListUseCase {
  final WishlistRepository wishlistRepository;

  AddToWishListUseCase({required this.wishlistRepository});

  Future<bool> addToWishlist({required String productId}) async {
    return await wishlistRepository.addToWishlist(productId: productId);
  }
}
