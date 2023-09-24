import 'dart:async';

import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';
import 'package:eshop/features/products_by_category/domain/usecase/get_product_by_category_usecase.dart';
import 'package:eshop/features/products_by_category/presentation/blocs/product_by_category_screen_bloc/product_by_category_screen_States.dart';
import 'package:eshop/features/products_by_category/presentation/blocs/product_by_category_screen_bloc/product_by_category_screen_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductByCategoryScreenBloc
    extends Bloc<ProductByCategoryScreenEvents, ProductByCategoryScreenStates> {
  final GetProductByCategoryUsecase getProductByCategoryUsecase;

  ProductByCategoryScreenBloc({
    required this.getProductByCategoryUsecase,
  }) : super(ProductByCategoryInitialState()) {
    on<FetchProductByCategoryDataEvent>(fetchProductByCategoryData);
  }

  FutureOr<void> fetchProductByCategoryData(
    FetchProductByCategoryDataEvent event,
    Emitter<ProductByCategoryScreenStates> emit,
  ) async {
    emit(ProductByCategoryDataFetchingState());
    final categoryName = event.categoryName;

    try {
      ProductByCategoryEntity? productByCategory =
          await getProductByCategoryUsecase.getProductsByCategory(
              categoryName: categoryName);

      if (productByCategory != null) {
        emit(
          ProductByCategoryFetchingSuccessfulState(
            productByCategory: productByCategory,
          ),
        );
      } else {
        emit(ProductByCategoryFetchingErrorState());
      }
    } catch (error) {
      print(
          "Error while fetching product by category data -- ProductByCategoryScreenBloc: $error");
      emit(ProductByCategoryFetchingErrorState());
    }
  }
}
