import 'dart:async';

import 'package:eshop/features/order_history/domain/usecases/cancel_order_usecase.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_details_screen_bloc/order_history_details_screen_events.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_details_screen_bloc/order_history_details_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryDetailsScreenBloc extends Bloc<
    OrderHistoryDetailsScreenEvents, OrderHistoryDetailsScreenStates> {
  final CancelOrderUsecase cancelOrderUsecase;

  OrderHistoryDetailsScreenBloc({required this.cancelOrderUsecase})
      : super(OrderHistoryDetailsScreenInitialState()) {
    on<CancelOrderEvent>(cancelOrder);
  }

  FutureOr<void> cancelOrder(
    CancelOrderEvent event,
    Emitter<OrderHistoryDetailsScreenStates> emit,
  ) async {
    emit(CancellingOrderState());

    try {
      var res = await cancelOrderUsecase.cancelOrder(orderId: event.orderId);

      if (res) {
        emit(CancellationSuccessfulState());
      } else {
        emit(CancellationErrorState());
      }
    } catch (error) {
      print("Error while cancelling order -- Bloc: $error");
      emit(CancellationErrorState());
    }
  }
}
