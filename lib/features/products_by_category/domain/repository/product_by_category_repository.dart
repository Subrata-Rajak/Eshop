import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';

abstract class ProductByCategoryRepository {
  Future<ProductByCategoryEntity?> getProductsByCategory({
    required String categoryName,
  });
}
