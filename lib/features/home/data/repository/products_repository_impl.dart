import 'package:eshop/features/home/data/data_source/remote/products_service.dart';
import 'package:eshop/features/home/domain/entity/all_products_entity.dart';
import 'package:eshop/features/home/domain/repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsService productsService;

  ProductsRepositoryImpl({required this.productsService});

  @override
  Future<AllProductsEntity?> getAllProducts() async {
    return await productsService.getAllProducts();
  }
}
