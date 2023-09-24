import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';

abstract class WishlistScreenStates {}

class WishlistScreenInitialState extends WishlistScreenStates {}

class WishlistScreenDataFetchingState extends WishlistScreenStates {}

class WishlistScreenDataFetchingSuccessState extends WishlistScreenStates {
  final WishlistItemsEntity? wishlist;

  WishlistScreenDataFetchingSuccessState({required this.wishlist});
}

class WishlistScreenDataFetchingErrorState extends WishlistScreenStates {}

class RemovingFromWishlistState extends WishlistScreenStates {}

class RemovedSuccessfulState extends WishlistScreenStates {
  final WishlistItemsEntity? wishlist;

  RemovedSuccessfulState({required this.wishlist});
}

class RemovedErrorState extends WishlistScreenStates {}
