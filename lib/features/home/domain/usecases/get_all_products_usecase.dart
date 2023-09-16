import 'package:eshop/features/home/domain/entity/all_products_entity.dart';
import 'package:eshop/features/home/domain/repository/products_repository.dart';

class GetAllProductsUsecase {
  ProductsRepository productsRepository;

  GetAllProductsUsecase({required this.productsRepository});

  Future<AllProductsEntity?> getAllProducts() async {
    return productsRepository.getAllProducts();
  }
}
