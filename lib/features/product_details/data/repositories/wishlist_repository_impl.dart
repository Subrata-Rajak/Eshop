import 'package:eshop/features/product_details/data/data_source/remote/wishlist_service.dart';
import 'package:eshop/features/product_details/domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistService wishlistService;

  WishlistRepositoryImpl({required this.wishlistService});

  @override
  Future<bool> isProductInWishlist({required String productId}) async {
    return await wishlistService.isProductInWishlist(productId: productId);
  }

  @override
  Future<bool> addToWishlist({required String productId}) async {
    return await wishlistService.addToWishList(productId: productId);
  }

  @override
  Future<bool> removeFromWishlist({required String productId}) async {
    return await wishlistService.removeFromWishlist(productId: productId);
  }
}
