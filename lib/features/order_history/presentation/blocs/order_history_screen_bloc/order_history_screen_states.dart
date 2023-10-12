import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';

abstract class OrderHistoryScreenStates {}

class OrderHistoryScreenInitialState extends OrderHistoryScreenStates {}

class FetchingOrderHistoryState extends OrderHistoryScreenStates {}

class FetchingSuccessfulState extends OrderHistoryScreenStates {
  final OrderHistoryEntity? orderHistory;

  FetchingSuccessfulState({required this.orderHistory});
}

class FetchingErrorState extends OrderHistoryScreenStates {}
