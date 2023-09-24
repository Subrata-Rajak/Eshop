import 'dart:async';

import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/cart/domain/usecases/decrease_cart_quantity_usecase.dart';
import 'package:eshop/features/cart/domain/usecases/get_cart_details_usecase.dart';
import 'package:eshop/features/cart/domain/usecases/increase_cart_quantity_usecase.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_events.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartDetailsScreenBloc
    extends Bloc<CartDetailsScreenEvents, CartDetailsScreenStates> {
  final GetCartDetailsUsecase getCartDetailsUsecase;
  final IncreaseCartQuantityUsecase increaseCartQuantityUsecase;
  final DecreaseCartQuantityUsecase decreaseCartQuantityUsecase;

  CartDetailsScreenBloc({
    required this.getCartDetailsUsecase,
    required this.decreaseCartQuantityUsecase,
    required this.increaseCartQuantityUsecase,
  }) : super(CartDetailsScreenInitialState()) {
    on<FetchCartDetailsEvent>(fetchCartDetails);
    on<IncreaseCartQuantityEvent>(increaseCartQuantity);
    on<DecreaseCartQuantityEvent>(decreaseCartQuantity);
  }

  FutureOr<void> fetchCartDetails(
    FetchCartDetailsEvent event,
    Emitter<CartDetailsScreenStates> emit,
  ) async {
    emit(CartDetailsFetchingState());
    try {
      CartDetailsEntity? cartDetails =
          await getCartDetailsUsecase.getCartDetails();

      if (cartDetails != null) {
        emit(
          CartDetailsFetchingSuccessfulState(cartDetails: cartDetails),
        );
      } else {
        emit(CartDetailsFetchingErrorState());
      }
    } catch (error) {
      print("Error while fetching cart details -- CartDetailsBloc : $error");
      emit(CartDetailsFetchingErrorState());
    }
  }

  FutureOr<void> increaseCartQuantity(
    IncreaseCartQuantityEvent event,
    Emitter<CartDetailsScreenStates> emit,
  ) async {
    emit(IncreasingCartQuantityState());
    final productId = event.productId;

    try {
      bool res = await increaseCartQuantityUsecase.increaseCartQuantity(
        productId: productId,
      );

      CartDetailsEntity? cartDetails =
          await getCartDetailsUsecase.getCartDetails();

      if (res && cartDetails != null) {
        emit(
          IncreasingCartQuantitySuccessfulState(cartDetails: cartDetails),
        );
      } else {
        emit(IncreasingCartQuantityErrorState());
      }
    } catch (error) {
      print(
          "Error while increasing cart quantity -- Cart details bloc: $error");
      emit(IncreasingCartQuantityErrorState());
    }
  }

  FutureOr<void> decreaseCartQuantity(
    DecreaseCartQuantityEvent event,
    Emitter<CartDetailsScreenStates> emit,
  ) async {
    emit(DecreasingCartQuantityState());
    final productId = event.productId;
    try {
      bool res = await decreaseCartQuantityUsecase.decreaseCartQuantity(
        productId: productId,
      );

      CartDetailsEntity? cartDetails =
          await getCartDetailsUsecase.getCartDetails();

      if (res && cartDetails != null) {
        emit(
          DecreasingCartQuantitySuccessfulState(cartDetails: cartDetails),
        );
      } else {
        emit(DecreasingCartQuantityErrorState());
      }
    } catch (error) {
      print(
          "Error while decreasing cart quantity -- Cart details bloc: $error");
      emit(DecreasingCartQuantityErrorState());
    }
  }
}
