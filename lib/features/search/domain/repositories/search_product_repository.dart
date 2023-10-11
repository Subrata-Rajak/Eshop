import 'package:eshop/features/search/domain/entities/search_product_entity.dart';

abstract class SearchedProductRepository {
  Future<SearchedProductListEntity?> searchProducts({required String tag});
}
