import 'package:eshop/features/cart/domain/repository/cart_details_repository.dart';

class DecreaseCartQuantityUsecase {
  final CartDetailsRepository cartDetailsRepository;

  DecreaseCartQuantityUsecase({required this.cartDetailsRepository});

  Future<bool> decreaseCartQuantity({required String productId}) async {
    return await cartDetailsRepository.decreaseCartQuantity(
      productId: productId,
    );
  }
}
