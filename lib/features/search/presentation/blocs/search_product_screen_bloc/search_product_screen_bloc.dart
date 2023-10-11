import 'dart:async';

import 'package:eshop/features/search/domain/entities/search_product_entity.dart';
import 'package:eshop/features/search/domain/usecases/search_product_usecase.dart';
import 'package:eshop/features/search/presentation/blocs/search_product_screen_bloc/search_product_screen_events.dart';
import 'package:eshop/features/search/presentation/blocs/search_product_screen_bloc/search_product_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductScreenBloc
    extends Bloc<SearchProductScreenEvents, SearchProductScreenStates> {
  final SearchProductUsecase searchProductUsecase;

  SearchProductScreenBloc({required this.searchProductUsecase})
      : super(SearchProductScreenInitialState()) {
    on<SearchProductEvent>(searchProduct);
  }

  FutureOr<void> searchProduct(
    SearchProductEvent event,
    Emitter<SearchProductScreenStates> emit,
  ) async {
    emit(SearchingProductState());

    try {
      SearchedProductListEntity? searchedProductList =
          await searchProductUsecase.searchProducts(tag: event.tag);

      if (searchedProductList != null) {
        emit(
          SearchSuccessfulState(
            searchedProductList: searchedProductList,
          ),
        );
      } else {
        emit(SearchErrorState());
      }
    } catch (error) {
      print("Error while searching product -- Bloc: $error");
      emit(SearchErrorState());
    }
  }
}
