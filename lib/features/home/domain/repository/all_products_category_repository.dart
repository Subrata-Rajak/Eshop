import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart';

abstract class AllProductsCategoryRepository {
  Future<AllProductsCategoryEntity?> getAllProductsCategories();
}
