import 'package:eshop/features/product_details/data/data_source/remote/product_service.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  ProductDetailsService productDetailsService;

  ProductDetailsRepositoryImpl({required this.productDetailsService});
  @override
  Future<ProductDetailsEntity?> getProductDetails({
    required String productId,
  }) async {
    return await productDetailsService.getProductDetails(productId: productId);
  }
}
