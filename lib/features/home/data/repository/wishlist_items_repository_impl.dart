import 'package:eshop/features/home/data/data_source/remote/wishlist_items_service.dart';
import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';
import 'package:eshop/features/home/domain/repository/wishlist_items_repository.dart';

class WishlistItemsRepositoryImpl implements WishlistItemsRepository {
  final WishlistItemsService wishlistItemsService;

  WishlistItemsRepositoryImpl({required this.wishlistItemsService});
  @override
  Future<WishlistItemsEntity?> getWishlist() async {
    return await wishlistItemsService.getWishlist();
  }
}
