import 'package:eshop/features/order_history/data/data_sources/remote/order_history_service.dart';
import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:eshop/features/order_history/domain/repositories/order_history_repository.dart';

class OrderHistoryRepositoryImpl implements OrderHistoryRepository {
  final OrderHistoryService orderHistoryService;

  OrderHistoryRepositoryImpl({required this.orderHistoryService});

  @override
  Future<OrderHistoryEntity?> getOrderHistory() async {
    return await orderHistoryService.getOrderHistory();
  }

  @override
  Future<bool> cancelOrder({required String orderId}) async {
    return await orderHistoryService.cancelOrder(orderId: orderId);
  }
}
