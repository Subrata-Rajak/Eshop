import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';

abstract class CartDetailsScreenStates {}

class CartDetailsScreenInitialState extends CartDetailsScreenStates {}

class CartDetailsFetchingState extends CartDetailsScreenStates {}

class CartDetailsFetchingSuccessfulState extends CartDetailsScreenStates {
  final CartDetailsEntity? cartDetails;

  CartDetailsFetchingSuccessfulState({required this.cartDetails});
}

class CartDetailsFetchingErrorState extends CartDetailsScreenStates {}

class IncreasingCartQuantityState extends CartDetailsScreenStates {}

class IncreasingCartQuantitySuccessfulState extends CartDetailsScreenStates {
  final CartDetailsEntity? cartDetails;

  IncreasingCartQuantitySuccessfulState({required this.cartDetails});
}

class IncreasingCartQuantityErrorState extends CartDetailsScreenStates {}

class DecreasingCartQuantityState extends CartDetailsScreenStates {}

class DecreasingCartQuantitySuccessfulState extends CartDetailsScreenStates {
  final CartDetailsEntity? cartDetails;

  DecreasingCartQuantitySuccessfulState({required this.cartDetails});
}

class DecreasingCartQuantityErrorState extends CartDetailsScreenStates {}

class RemovingFromCartState extends CartDetailsScreenStates {}

class RemovingFromCartSuccessfulState extends CartDetailsScreenStates {
  final CartDetailsEntity? cartDetails;

  RemovingFromCartSuccessfulState({required this.cartDetails});
}

class RemovingFromCartErrorState extends CartDetailsScreenStates {}
