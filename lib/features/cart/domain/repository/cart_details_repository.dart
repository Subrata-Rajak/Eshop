import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';

abstract class CartDetailsRepository {
  Future<CartDetailsEntity?> getCartDetails();
  Future<bool> increaseCartQuantity({required String productId});
  Future<bool> decreaseCartQuantity({required String productId});
  Future<bool> removeFromCart({required String productId});
}
