import 'dart:async';

import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';
import 'package:eshop/features/home/domain/usecases/get_wishlist_usecase.dart';
import 'package:eshop/features/home/presentation/blocs/wishlist_screen_bloc/wishlist_screen_events.dart';
import 'package:eshop/features/home/presentation/blocs/wishlist_screen_bloc/wishlist_screen_states.dart';
import 'package:eshop/features/product_details/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreenBloc
    extends Bloc<WishlistScreenEvents, WishlistScreenStates> {
  final GetWishlistUsecase getWishlistUsecase;
  final RemoveFromWishlistUsecase removeFromWishlistUsecase;
  WishlistScreenBloc({
    required this.getWishlistUsecase,
    required this.removeFromWishlistUsecase,
  }) : super(WishlistScreenInitialState()) {
    on<WishlistScreenFetchDataEvent>(fetchWishlistData);
    on<RemoveFromWishlistEvent>(removeFromWishlist);
  }

  FutureOr<void> fetchWishlistData(
    WishlistScreenFetchDataEvent event,
    Emitter<WishlistScreenStates> emit,
  ) async {
    emit(WishlistScreenDataFetchingState());

    try {
      WishlistItemsEntity? wishlist = await getWishlistUsecase.getWishlist();

      if (wishlist != null) {
        emit(WishlistScreenDataFetchingSuccessState(wishlist: wishlist));
      } else {
        emit(WishlistScreenDataFetchingErrorState());
      }
    } catch (error) {
      print("Error while fetching wishlist data -- Bloc $error");
      emit(WishlistScreenDataFetchingErrorState());
    }
  }

  FutureOr<void> removeFromWishlist(
    RemoveFromWishlistEvent event,
    Emitter<WishlistScreenStates> emit,
  ) async {
    emit(RemovingFromWishlistState());

    try {
      final bool res = await removeFromWishlistUsecase.removeFromWishlist(
        productId: event.productId,
      );

      if (res) {
        final WishlistItemsEntity? wishlist =
            await getWishlistUsecase.getWishlist();

        if (wishlist != null) {
          emit(RemovedSuccessfulState(wishlist: wishlist));
        } else {
          emit(RemovedErrorState());
        }
      } else {
        emit(RemovedErrorState());
      }
    } catch (error) {
      print(
          "Error while removing product from wishlist -- Wishlist Bloc $error");
      emit(RemovedErrorState());
    }
  }
}
