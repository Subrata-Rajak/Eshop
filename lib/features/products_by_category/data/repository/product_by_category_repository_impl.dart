import 'package:eshop/features/products_by_category/data/data_source/remote/product_by_category_service.dart';
import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';
import 'package:eshop/features/products_by_category/domain/repository/product_by_category_repository.dart';

class ProductByCategoryRepositoryImpl implements ProductByCategoryRepository {
  final ProductByCategoryService productByCategoryService;

  ProductByCategoryRepositoryImpl({required this.productByCategoryService});

  @override
  Future<ProductByCategoryEntity?> getProductsByCategory({
    required String categoryName,
  }) async {
    return await productByCategoryService.getProductByCategory(
      categoryName: categoryName,
    );
  }
}
