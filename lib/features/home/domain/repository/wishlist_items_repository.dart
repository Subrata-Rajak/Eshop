import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';

abstract class WishlistItemsRepository {
  Future<WishlistItemsEntity?> getWishlist();
}
