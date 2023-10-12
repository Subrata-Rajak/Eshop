import 'package:eshop/features/order_history/domain/repositories/order_history_repository.dart';

class CancelOrderUsecase {
  final OrderHistoryRepository orderHistoryRepository;

  CancelOrderUsecase({required this.orderHistoryRepository});

  Future<bool> cancelOrder({required String orderId}) async {
    return await orderHistoryRepository.cancelOrder(orderId: orderId);
  }
}
