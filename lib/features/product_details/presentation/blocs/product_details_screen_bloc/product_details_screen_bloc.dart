import 'dart:async';

import 'package:eshop/features/product_details/domain/entities/product_entity.dart';
import 'package:eshop/features/product_details/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/get_product_details_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/is_product_in_cart_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/is_product_in_wishlist_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/pd_add_to_cart_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/pd_remove_from_cart_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:eshop/features/product_details/presentation/blocs/product_details_screen_bloc/product_details_screen_events.dart';
import 'package:eshop/features/product_details/presentation/blocs/product_details_screen_bloc/product_details_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreenBloc
    extends Bloc<ProductDetailsScreenEvents, ProductDetailsScreenStates> {
  final GetProductDetailsUsecase getProductDetailsUsecase;
  final IsProductInWishListUsecase isProductInWishListUsecase;
  final AddToWishListUseCase addToWishListUseCase;
  final RemoveFromWishlistUsecase removeFromWishlistUsecase;
  final PDAddToUsecase pdAddToUsecase;
  final PDRemoveFromCartUsecase pdRemoveFromCartUsecase;
  final IsProductInCartUsecase isProductInCartUsecase;

  ProductDetailsScreenBloc({
    required this.getProductDetailsUsecase,
    required this.isProductInWishListUsecase,
    required this.addToWishListUseCase,
    required this.removeFromWishlistUsecase,
    required this.pdAddToUsecase,
    required this.pdRemoveFromCartUsecase,
    required this.isProductInCartUsecase,
  }) : super(ProductDetailsScreenInitialState()) {
    on<ProductDetailsFetchingEvent>(fetchProductDetails);
    on<AddToWishListEvent>(addToWishlist);
    on<RemoveFromWishlistEvent>(removeFromWishlist);
    on<AddToCartEvent>(addToCart);
    on<RemoveFromCartEvent>(removeFromCart);
  }

  FutureOr<void> fetchProductDetails(
    ProductDetailsFetchingEvent event,
    Emitter<ProductDetailsScreenStates> emit,
  ) async {
    emit(ProductDetailsScreenLoadingState());
    final productId = event.productId;

    try {
      ProductDetailsEntity? productDetails = await getProductDetailsUsecase
          .getProductDetails(productId: productId);

      var wishlistRes = await isProductInWishListUsecase.isProductInWishlist(
        productId: productId,
      );

      var cartRes =
          await isProductInCartUsecase.isProductInCart(productId: productId);

      if (productDetails == null) {
        emit(ProductDetailsFetchingErrorState());
      } else {
        emit(
          ProductDetailsFetchingSuccessState(
            productDetailsEntity: productDetails,
            isProductInWishlist: wishlistRes,
            isProductInCart: cartRes,
          ),
        );
      }
    } catch (error) {
      print("Error while fetching product details -- Bloc $error");
      emit(ProductDetailsFetchingErrorState());
    }
  }

  FutureOr<void> addToWishlist(
    AddToWishListEvent event,
    Emitter<ProductDetailsScreenStates> emit,
  ) async {
    emit(AddingToWishlistState());
    final productId = event.productId;

    try {
      var res = await addToWishListUseCase.addToWishlist(productId: productId);

      if (res) {
        emit(
          AddedToWishlistSuccessState(isAdded: true),
        );
      } else {
        emit(AddedToWishlistErrorState());
      }
    } catch (error) {
      print("Error while adding product to wishlist -- Bloc : $error");
      emit(AddedToWishlistErrorState());
    }
  }

  FutureOr<void> removeFromWishlist(
    RemoveFromWishlistEvent event,
    Emitter<ProductDetailsScreenStates> emit,
  ) async {
    emit(RemovingFromWishlistState());
    final productId = event.productId;

    try {
      var res = await removeFromWishlistUsecase.removeFromWishlist(
          productId: productId);

      if (res) {
        emit(
          RemovedFromWishlistSuccessState(isRemoved: true),
        );
      } else {
        emit(RemovedFromWishlistErrorState());
      }
    } catch (error) {
      print("Error while removing product from wishlist -- Bloc : $error");
      emit(RemovedFromWishlistErrorState());
    }
  }

  FutureOr<void> addToCart(
    AddToCartEvent event,
    Emitter<ProductDetailsScreenStates> emit,
  ) async {
    emit(AddingToCartState());

    try {
      final bool res =
          await pdAddToUsecase.addToUsecase(productId: event.productId);

      if (res) {
        emit(AddedToCartSuccessfullyState(isAdded: true));
      } else {
        emit(AddedToCartErrorState());
      }
    } catch (error) {
      print("Error while adding to cart -- Product Details Bloc $error");
      emit(AddedToCartErrorState());
    }
  }

  FutureOr<void> removeFromCart(
    RemoveFromCartEvent event,
    Emitter<ProductDetailsScreenStates> emit,
  ) async {
    emit(RemovingFromCartState());

    try {
      final bool res = await pdRemoveFromCartUsecase.removeFromCart(
        productId: event.productId,
      );

      if (res) {
        emit(RemovedFromCartSuccessfulState(isRemoved: true));
      } else {
        emit(RemovedFromCartErrorState());
      }
    } catch (error) {
      print(
          "Error while removing product from cart -- Product details bloc: $error");
      emit(RemovedFromCartErrorState());
    }
  }
}
