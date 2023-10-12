import 'package:eshop/features/order_history/data/models/order_history_model.dart';
import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';

class OrderHistoryMapper {
  static OrderHistoryEntity mapModelToEntity({
    required OrdersHistory ordersHistory,
  }) {
    var ordersList = ordersHistory.orders
        .map(
          (order) => OrderEntity(
            orderInfo: OrderInfoEntity(
              orderDate: order.orderInfo.orderDate,
              orderStatus: order.orderInfo.orderStatus,
              paymentStatus: order.orderInfo.paymentStatus,
              shippingAddress: ShippingAddressEntity(
                addressId: order.orderInfo.shippingAddress.addressId,
                area: order.orderInfo.shippingAddress.area,
                city: order.orderInfo.shippingAddress.city,
                country: order.orderInfo.shippingAddress.country,
                landmark: order.orderInfo.shippingAddress.landmark,
                pincode: order.orderInfo.shippingAddress.pincode,
                state: order.orderInfo.shippingAddress.state,
              ),
            ),
            paymentInfo: PaymentInfoEntity(
              paymentAmount: order.paymentInfo.paymentAmount,
              paymentDate: order.paymentInfo.paymentDate,
              paymentId: order.paymentInfo.paymentId,
              paymentMethod: order.paymentInfo.paymentMethod,
            ),
            shippingInfo: ShippingInfoEntity(
              estimatedDeliveryDate: order.shippingInfo.estimatedDeliveryDate,
              shippingCost: order.shippingInfo.shippingCost,
            ),
            customerInfo: CustomerInfoEntity(
              customerEmail: order.customerInfo.customerEmail,
            ),
            orderTotals: OrderTotalsEntity(
              discounts: order.orderTotals.discounts,
              shippingCost: order.orderTotals.shippingCost,
              subtotal: order.orderTotals.subtotal,
              totalAmount: order.orderTotals.totalAmount,
            ),
            orderActions: OrderActionsEntity(
              cancelOrder: order.orderActions.cancelOrder,
            ),
            id: order.id,
            orderItems: order.orderItems
                .map(
                  (orderItem) => OrderItemEntity(
                    productId: orderItem.productId,
                    productName: orderItem.productName,
                    productDescription: orderItem.productDescription,
                    productPrice: orderItem.productPrice,
                    productImageUrl: orderItem.productImageUrl,
                    cartQuantity: orderItem.cartQuantity,
                    stockQuantity: orderItem.stockQuantity,
                  ),
                )
                .toList(),
            v: order.v,
          ),
        )
        .toList();

    return OrderHistoryEntity(orders: ordersList);
  }
}
