import 'package:eshop/features/product_details/domain/entities/product_entity.dart';

abstract class ProductDetailsRepository {
  Future<ProductDetailsEntity?> getProductDetails({required String productId});
}
