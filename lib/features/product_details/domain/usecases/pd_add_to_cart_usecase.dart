import 'package:eshop/features/product_details/domain/repositories/product_details_cart_repository.dart';

class PDAddToUsecase {
  final ProductDetailsCartRepository productDetailsCartRepository;

  PDAddToUsecase({required this.productDetailsCartRepository});

  Future<bool> addToUsecase({required String productId}) async {
    return productDetailsCartRepository.addToCart(productId: productId);
  }
}
