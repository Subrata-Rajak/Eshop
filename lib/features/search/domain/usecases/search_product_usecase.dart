import 'package:eshop/features/search/domain/entities/search_product_entity.dart';
import 'package:eshop/features/search/domain/repositories/search_product_repository.dart';

class SearchProductUsecase {
  final SearchedProductRepository searchedProductRepository;

  SearchProductUsecase({required this.searchedProductRepository});

  Future<SearchedProductListEntity?> searchProducts(
      {required String tag}) async {
    return await searchedProductRepository.searchProducts(tag: tag);
  }
}
