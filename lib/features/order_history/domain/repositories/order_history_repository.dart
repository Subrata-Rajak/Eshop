import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';

abstract class OrderHistoryRepository {
  Future<OrderHistoryEntity?> getOrderHistory();
  Future<bool> cancelOrder({required String orderId});
}
