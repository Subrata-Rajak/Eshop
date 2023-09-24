import 'package:eshop/features/product_details/domain/repositories/product_details_cart_repository.dart';

class IsProductInCartUsecase {
  final ProductDetailsCartRepository productDetailsCartRepository;

  IsProductInCartUsecase({required this.productDetailsCartRepository});

  Future<bool> isProductInCart({required String productId}) async {
    return await productDetailsCartRepository.isProductInCart(
      productId: productId,
    );
  }
}
