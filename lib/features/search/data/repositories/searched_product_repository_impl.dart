import 'package:eshop/features/search/data/data_source/remote/search_product_service.dart';
import 'package:eshop/features/search/domain/entities/search_product_entity.dart';
import 'package:eshop/features/search/domain/repositories/search_product_repository.dart';

class SearchedProductRepositoryImpl implements SearchedProductRepository {
  final SearchProductService searchProductService;

  SearchedProductRepositoryImpl({required this.searchProductService});

  @override
  Future<SearchedProductListEntity?> searchProducts(
      {required String tag}) async {
    return await searchProductService.searchProducts(tag: tag);
  }
}
