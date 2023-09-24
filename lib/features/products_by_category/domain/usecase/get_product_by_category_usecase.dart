import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';
import 'package:eshop/features/products_by_category/domain/repository/product_by_category_repository.dart';

class GetProductByCategoryUsecase {
  final ProductByCategoryRepository productByCategoryRepository;

  GetProductByCategoryUsecase({required this.productByCategoryRepository});

  Future<ProductByCategoryEntity?> getProductsByCategory({
    required String categoryName,
  }) async {
    return await productByCategoryRepository.getProductsByCategory(
      categoryName: categoryName,
    );
  }
}
