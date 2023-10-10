import 'dart:async';

import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';
import 'package:eshop/features/order_details/domain/usecases/get_selected_address_usecase.dart';
import 'package:eshop/features/order_details/presentation/blocs/order_summary_bloc/order_summary_events.dart';
import 'package:eshop/features/order_details/presentation/blocs/order_summary_bloc/order_summary_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderSummaryScreenBloc
    extends Bloc<OrderSummaryScreenEvents, OrderSummaryScreenStates> {
  final GetSelectedAddressUsecase getSelectedAddressUsecase;

  OrderSummaryScreenBloc({
    required this.getSelectedAddressUsecase,
  }) : super(OrderSummaryInitialState()) {
    on<FetchInitialDataEvent>(fetchInitialData);
  }

  FutureOr<void> fetchInitialData(
    FetchInitialDataEvent event,
    Emitter<OrderSummaryScreenStates> emit,
  ) async {
    emit(FetchingInitialDataState());

    try {
      SelectedAddressEntity? selectedAddress =
          await getSelectedAddressUsecase.getSElectedAddress();

      if (selectedAddress != null) {
        emit(
          InitialDataFetchingSuccessState(selectedAddress: selectedAddress),
        );
      } else {
        emit(InitialDataFetchingErrorState());
      }
    } catch (error) {
      print("Error while fetching initial data -- Order Summary bloc: $error");
      emit(InitialDataFetchingErrorState());
    }
  }
}
