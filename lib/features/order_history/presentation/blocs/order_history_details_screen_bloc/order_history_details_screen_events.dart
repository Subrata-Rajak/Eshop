abstract class OrderHistoryDetailsScreenEvents {}

class CancelOrderEvent extends OrderHistoryDetailsScreenEvents {
  final String orderId;

  CancelOrderEvent({required this.orderId});
}
