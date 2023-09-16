import 'package:eshop/features/home/data/data_source/remote/all_products_category_service.dart';
import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart';
import 'package:eshop/features/home/domain/repository/all_products_category_repository.dart';

class AllProductCategoriesImpl implements AllProductsCategoryRepository {
  final AllProductsCategoryService allProductsCategoryService;

  AllProductCategoriesImpl({required this.allProductsCategoryService});

  @override
  Future<AllProductsCategoryEntity?> getAllProductsCategories() async {
    return await allProductsCategoryService.getAllProductCategories();
  }
}
