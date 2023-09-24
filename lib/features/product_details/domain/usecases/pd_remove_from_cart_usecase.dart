import 'package:eshop/features/product_details/domain/repositories/product_details_cart_repository.dart';

class PDRemoveFromCartUsecase {
  final ProductDetailsCartRepository productDetailsCartRepository;

  PDRemoveFromCartUsecase({required this.productDetailsCartRepository});

  Future<bool> removeFromCart({required String productId}) async {
    return await productDetailsCartRepository.removeFromCart(
      productId: productId,
    );
  }
}
