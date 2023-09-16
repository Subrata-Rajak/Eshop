import 'package:eshop/features/home/domain/entity/all_products_entity.dart';

abstract class ProductsRepository {
  Future<AllProductsEntity?> getAllProducts();
}
