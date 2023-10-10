import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';

abstract class OrderSummaryScreenStates {}

class OrderSummaryInitialState extends OrderSummaryScreenStates {}

class FetchingInitialDataState extends OrderSummaryScreenStates {}

class InitialDataFetchingSuccessState extends OrderSummaryScreenStates {
  final SelectedAddressEntity? selectedAddress;

  InitialDataFetchingSuccessState({required this.selectedAddress});
}

class InitialDataFetchingErrorState extends OrderSummaryScreenStates {}
