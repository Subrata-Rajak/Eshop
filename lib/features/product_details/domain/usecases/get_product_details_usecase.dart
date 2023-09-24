import '../entities/product_entity.dart';

import '../repositories/product_repository.dart';

class GetProductDetailsUsecase {
  final ProductDetailsRepository productRepository;

  GetProductDetailsUsecase({required this.productRepository});

  Future<ProductDetailsEntity?> getProductDetails(
      {required String productId}) async {
    return await productRepository.getProductDetails(productId: productId);
  }
}
