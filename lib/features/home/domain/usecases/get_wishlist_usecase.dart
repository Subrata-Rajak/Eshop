import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';
import 'package:eshop/features/home/domain/repository/wishlist_items_repository.dart';

class GetWishlistUsecase {
  final WishlistItemsRepository wishlistItemsRepository;

  GetWishlistUsecase({required this.wishlistItemsRepository});

  Future<WishlistItemsEntity?> getWishlist() async {
    return await wishlistItemsRepository.getWishlist();
  }
}
