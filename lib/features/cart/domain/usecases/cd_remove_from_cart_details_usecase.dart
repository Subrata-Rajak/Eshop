import 'package:eshop/features/cart/domain/repository/cart_details_repository.dart';

class CDRemoveFormCartUsecase {
  final CartDetailsRepository cartDetailsRepository;

  CDRemoveFormCartUsecase({required this.cartDetailsRepository});

  Future<bool> removeFromCart({required String productId}) async {
    return await cartDetailsRepository.removeFromCart(productId: productId);
  }
}
