import 'package:eshop/features/cart/data/data_source/remote/cart_details_service.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/cart/domain/repository/cart_details_repository.dart';

class CartDetailsRepositoryImpl implements CartDetailsRepository {
  final CartDetailsService cartDetailsService;

  CartDetailsRepositoryImpl({required this.cartDetailsService});

  @override
  Future<CartDetailsEntity?> getCartDetails() async {
    return await cartDetailsService.getCartDetails();
  }

  @override
  Future<bool> decreaseCartQuantity({required String productId}) async {
    return await cartDetailsService.decreaseCartQuantity(productId: productId);
  }

  @override
  Future<bool> increaseCartQuantity({required String productId}) async {
    return await cartDetailsService.increaseCartQuantity(productId: productId);
  }
}
