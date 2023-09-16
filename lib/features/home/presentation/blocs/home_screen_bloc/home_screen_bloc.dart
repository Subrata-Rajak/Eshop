import 'dart:async';

import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart';
import 'package:eshop/features/home/domain/entity/all_products_entity.dart';
import 'package:eshop/features/home/domain/usecases/get_all_products_categories_usecase.dart';
import 'package:eshop/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:eshop/features/home/domain/usecases/get_user_info_usecase.dart';
import 'package:eshop/features/home/presentation/blocs/home_screen_bloc/home_screen_events.dart';
import 'package:eshop/features/home/presentation/blocs/home_screen_bloc/home_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/user_entity.dart';

class HomeBloc extends Bloc<HomeScreenEvents, HomeScreenStates> {
  GetUserInfoUsecase getUserInfoUsecase;
  GetAllProductCategoriesUsecase getAllProductCategoriesUsecase;
  GetAllProductsUsecase getAllProductsUsecase;
  HomeBloc({
    required this.getAllProductCategoriesUsecase,
    required this.getUserInfoUsecase,
    required this.getAllProductsUsecase,
  }) : super(HomeInitialState()) {
    on<HomeInitialDataFetchingEvent>(fetchInitialData);
  }

  FutureOr<void> fetchInitialData(
    HomeInitialDataFetchingEvent event,
    Emitter<HomeScreenStates> emit,
  ) async {
    emit(HomeLoadingState());
    try {
      UserEntity? user = await getUserInfoUsecase.getUserInfo();
      AllProductsCategoryEntity? allProductCategories =
          await getAllProductCategoriesUsecase.getAllProductCategories();
      AllProductsEntity? allProducts =
          await getAllProductsUsecase.getAllProducts();

      if (user != null && allProductCategories != null) {
        emit(HomeInitialDataFetchingSuccessState(
          user: user,
          allProductsCategories: allProductCategories,
          allProducts: allProducts,
        ));
      } else {
        emit(HomeInitialDataFetchingErrorState());
      }
    } catch (error) {
      print("Error while fetching initial home screen data $error");
      emit(HomeInitialDataFetchingErrorState());
    }
  }
}
