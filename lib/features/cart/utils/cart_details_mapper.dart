import 'package:eshop/features/cart/data/models/cart_details_model.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';

class CartDetailsMapper {
  static CartDetailsEntity mapModelToEntity(CartDetails cartDetails) {
    return CartDetailsEntity(
      id: cartDetails.id,
      userEmail: cartDetails.userEmail,
      products: cartDetails.products
          .map(
            (product) => CartDetailsProductEntity(
              productId: product.productId,
              productName: product.productName,
              productDescription: product.productDescription,
              productPrice: product.productPrice,
              productStock: product.productStock,
              cartQuantity: product.cartQuantity,
              productImageUrl: product.productImageUrl,
              id: product.id,
            ),
          )
          .toList(),
      v: cartDetails.v,
    );
  }

  static CartDetails mapEntityToModel(CartDetailsEntity cartDetails) {
    return CartDetails(
      id: cartDetails.id,
      userEmail: cartDetails.userEmail,
      products: cartDetails.products
          .map(
            (product) => CartDetailsProduct(
              productId: product.productId,
              productName: product.productName,
              productDescription: product.productDescription,
              productPrice: product.productPrice,
              productStock: product.productStock,
              cartQuantity: product.cartQuantity,
              productImageUrl: product.productImageUrl,
              id: product.id,
            ),
          )
          .toList(),
      v: cartDetails.v,
    );
  }
}
