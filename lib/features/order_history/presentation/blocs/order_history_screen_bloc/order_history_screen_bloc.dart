import 'dart:async';

import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:eshop/features/order_history/domain/usecases/get_order_history_usecase.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_screen_bloc/order_history_screen_events.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_screen_bloc/order_history_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryScreenBloc
    extends Bloc<OrderHistoryScreenEvents, OrderHistoryScreenStates> {
  final GetOrderHistoryUsecase getOrderHistoryUsecase;

  OrderHistoryScreenBloc({required this.getOrderHistoryUsecase})
      : super(OrderHistoryScreenInitialState()) {
    on<FetchOrderHistoryEvent>(fetchOrderHistory);
  }

  FutureOr<void> fetchOrderHistory(
    FetchOrderHistoryEvent event,
    Emitter<OrderHistoryScreenStates> emit,
  ) async {
    emit(FetchingOrderHistoryState());

    try {
      OrderHistoryEntity? orderHistory =
          await getOrderHistoryUsecase.getOrderHistory();

      if (orderHistory != null) {
        emit(
          FetchingSuccessfulState(
            orderHistory: orderHistory,
          ),
        );
      } else {
        emit(FetchingErrorState());
      }
    } catch (error) {
      print("Error while fetching order history -- Bloc: $error");
      emit(FetchingErrorState());
    }
  }
}
