import 'package:eshop/features/cart/domain/repository/cart_details_repository.dart';

class IncreaseCartQuantityUsecase {
  final CartDetailsRepository cartDetailsRepository;

  IncreaseCartQuantityUsecase({required this.cartDetailsRepository});

  Future<bool> increaseCartQuantity({required String productId}) async {
    return await cartDetailsRepository.increaseCartQuantity(
      productId: productId,
    );
  }
}
