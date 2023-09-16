import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart';
import 'package:eshop/features/home/domain/repository/all_products_category_repository.dart';

class GetAllProductCategoriesUsecase {
  final AllProductsCategoryRepository allProductsCategoryRepository;

  GetAllProductCategoriesUsecase({required this.allProductsCategoryRepository});

  Future<AllProductsCategoryEntity?> getAllProductCategories() {
    return allProductsCategoryRepository.getAllProductsCategories();
  }
}
