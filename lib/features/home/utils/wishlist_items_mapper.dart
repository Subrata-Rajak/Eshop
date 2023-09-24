import '../domain/entity/wishlist_items_entity.dart';
import '../data/models/wishlist_items_model.dart';

class WishlistItemsMapper {
  static WishlistItems mapEntityToModel({
    required WishlistItemsEntity wishlist,
  }) {
    return WishlistItems(
      id: wishlist.id,
      userEmail: wishlist.userEmail,
      products: wishlist.products
          .map(
            (product) => WishlistItemsProduct(
              productId: product.productId,
              productName: product.productName,
              productDescription: product.productDescription,
              productImageUrl: product.productImageUrl,
              productPrice: product.productPrice,
              productStock: product.productStock,
              id: product.id,
            ),
          )
          .toList(),
      v: wishlist.v,
    );
  }

  static WishlistItemsEntity mapModelToEntity({
    required WishlistItems wishlistItems,
  }) {
    return WishlistItemsEntity(
      id: wishlistItems.id,
      userEmail: wishlistItems.userEmail,
      products: wishlistItems.products
          .map(
            (product) => WishlistItemsProductEntity(
              productId: product.productId,
              productName: product.productName,
              productDescription: product.productDescription,
              productImageUrl: product.productImageUrl,
              productPrice: product.productPrice,
              productStock: product.productStock,
              id: product.id,
            ),
          )
          .toList(),
      v: wishlistItems.v,
    );
  }
}
