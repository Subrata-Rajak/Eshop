import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';

abstract class ProductByCategoryScreenStates {}

class ProductByCategoryInitialState extends ProductByCategoryScreenStates {}

class ProductByCategoryDataFetchingState
    extends ProductByCategoryScreenStates {}

class ProductByCategoryFetchingSuccessfulState
    extends ProductByCategoryScreenStates {
  ProductByCategoryEntity? productByCategory;

  ProductByCategoryFetchingSuccessfulState({required this.productByCategory});
}

class ProductByCategoryFetchingErrorState
    extends ProductByCategoryScreenStates {}
