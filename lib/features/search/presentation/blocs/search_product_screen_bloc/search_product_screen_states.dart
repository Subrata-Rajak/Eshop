import 'package:eshop/features/search/domain/entities/search_product_entity.dart';

abstract class SearchProductScreenStates {}

class SearchProductScreenInitialState extends SearchProductScreenStates {}

class SearchingProductState extends SearchProductScreenStates {}

class SearchSuccessfulState extends SearchProductScreenStates {
  final SearchedProductListEntity? searchedProductList;

  SearchSuccessfulState({required this.searchedProductList});
}

class SearchErrorState extends SearchProductScreenStates {}
