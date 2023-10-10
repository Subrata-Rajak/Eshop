import 'dart:async';

import 'package:eshop/features/order_details/domain/usecases/place_order_usecase.dart';
import 'package:eshop/features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_events.dart';
import 'package:eshop/features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum PaymentMethods {
  payOnDelivery,
  payWithStripe,
}

class PaymentMethodScreenBloc
    extends Bloc<PaymentMethodScreenEvents, PaymentMethodScreenStates> {
  final PlaceOrderUsecase placeOrderUsecase;
  PaymentMethodScreenBloc({
    required this.placeOrderUsecase,
  }) : super(
          PaymentMethodScreenInitialState(),
        ) {
    on<PlaceOrderEvent>(placeOrder);
  }

  FutureOr<void> placeOrder(
    PlaceOrderEvent event,
    Emitter<PaymentMethodScreenStates> emit,
  ) async {
    emit(PlacingOrderState());
    try {
      var res = await placeOrderUsecase.placeOrder(
        country: event.country,
        state: event.state,
        city: event.city,
        landmark: event.landmark,
        area: event.area,
        pincode: event.pincode,
        paymentMethod: event.paymentMethod,
        amount: event.amount,
        addressId: event.addressId,
        orderItemsFromCartDetails: event.orderItemsFromCartDetails,
        orderItemsFromProductDetails: event.orderItemsFromProductDetails,
        totalAmount: event.totalAmount,
        orderSubTotal: event.orderSubTotal,
      );

      if (res) {
        emit(OrderPlacedSuccessfullyState());
      } else {
        emit(OrderPlacingErrorState());
      }
    } catch (error) {
      print("Error while placing order -- Payment Method Screen Bloc: $error");
      emit(OrderPlacingErrorState());
    }
  }
}
