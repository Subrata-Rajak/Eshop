import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart';
import 'package:eshop/features/home/domain/entity/all_products_entity.dart';

import '../../../domain/entity/user_entity.dart';

abstract class HomeScreenStates {}

class HomeInitialState extends HomeScreenStates {}

class HomeLoadingState extends HomeScreenStates {}

class HomeInitialDataFetchingSuccessState extends HomeScreenStates {
  UserEntity? user;
  AllProductsCategoryEntity? allProductsCategories;
  AllProductsEntity? allProducts;

  HomeInitialDataFetchingSuccessState({
    required this.user,
    required this.allProductsCategories,
    required this.allProducts,
  });
}

class HomeInitialDataFetchingErrorState extends HomeScreenStates {}
