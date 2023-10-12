import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:eshop/features/order_history/domain/repositories/order_history_repository.dart';

class GetOrderHistoryUsecase {
  final OrderHistoryRepository orderHistoryRepository;

  GetOrderHistoryUsecase({required this.orderHistoryRepository});

  Future<OrderHistoryEntity?> getOrderHistory() async {
    return await orderHistoryRepository.getOrderHistory();
  }
}
