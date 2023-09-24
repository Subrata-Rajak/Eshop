import 'package:eshop/features/product_details/domain/entities/product_entity.dart';

abstract class ProductDetailsScreenStates {}

class ProductDetailsScreenInitialState extends ProductDetailsScreenStates {}

class ProductDetailsScreenLoadingState extends ProductDetailsScreenStates {}

class ProductDetailsFetchingSuccessState extends ProductDetailsScreenStates {
  final ProductDetailsEntity? productDetailsEntity;
  final bool isProductInWishlist;
  final bool isProductInCart;

  ProductDetailsFetchingSuccessState({
    required this.productDetailsEntity,
    required this.isProductInWishlist,
    required this.isProductInCart,
  });
}

class ProductDetailsFetchingErrorState extends ProductDetailsScreenStates {}

class AddingToWishlistState extends ProductDetailsScreenStates {}

class AddedToWishlistSuccessState extends ProductDetailsScreenStates {
  final bool isAdded;

  AddedToWishlistSuccessState({required this.isAdded});
}

class AddedToWishlistErrorState extends ProductDetailsScreenStates {}

class RemovingFromWishlistState extends ProductDetailsScreenStates {}

class RemovedFromWishlistSuccessState extends ProductDetailsScreenStates {
  final bool isRemoved;

  RemovedFromWishlistSuccessState({required this.isRemoved});
}

class RemovedFromWishlistErrorState extends ProductDetailsScreenStates {}

class AddingToCartState extends ProductDetailsScreenStates {}

class AddedToCartSuccessfullyState extends ProductDetailsScreenStates {
  bool isAdded = false;

  AddedToCartSuccessfullyState({required this.isAdded});
}

class AddedToCartErrorState extends ProductDetailsScreenStates {}

class RemovingFromCartState extends ProductDetailsScreenStates {}

class RemovedFromCartSuccessfulState extends ProductDetailsScreenStates {
  bool isRemoved = false;

  RemovedFromCartSuccessfulState({required this.isRemoved});
}

class RemovedFromCartErrorState extends ProductDetailsScreenStates {}
