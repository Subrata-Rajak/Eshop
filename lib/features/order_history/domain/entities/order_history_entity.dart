class OrderHistoryEntity {
  List<OrderEntity> orders;

  OrderHistoryEntity({
    required this.orders,
  });
}

class OrderEntity {
  OrderInfoEntity orderInfo;
  PaymentInfoEntity paymentInfo;
  ShippingInfoEntity shippingInfo;
  CustomerInfoEntity customerInfo;
  OrderTotalsEntity orderTotals;
  OrderActionsEntity orderActions;
  String id;
  List<OrderItemEntity> orderItems;
  int v;

  OrderEntity({
    required this.orderInfo,
    required this.paymentInfo,
    required this.shippingInfo,
    required this.customerInfo,
    required this.orderTotals,
    required this.orderActions,
    required this.id,
    required this.orderItems,
    required this.v,
  });
}

class CustomerInfoEntity {
  String customerEmail;

  CustomerInfoEntity({required this.customerEmail});
}

class OrderActionsEntity {
  bool cancelOrder;

  OrderActionsEntity({required this.cancelOrder});
}

class OrderInfoEntity {
  ShippingAddressEntity shippingAddress;
  DateTime orderDate;
  String orderStatus;
  String paymentStatus;

  OrderInfoEntity({
    required this.shippingAddress,
    required this.orderDate,
    required this.orderStatus,
    required this.paymentStatus,
  });
}

class ShippingAddressEntity {
  String addressId;
  String country;
  String state;
  String city;
  String area;
  String landmark;
  String pincode;

  ShippingAddressEntity({
    required this.addressId,
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.pincode,
  });
}

class OrderItemEntity {
  String productId;
  String productName;
  String productDescription;
  int productPrice;
  int cartQuantity;
  String productImageUrl;
  int stockQuantity;

  OrderItemEntity({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.cartQuantity,
    required this.productImageUrl,
    required this.stockQuantity,
  });
}

class OrderTotalsEntity {
  String subtotal;
  String discounts;
  String shippingCost;
  String totalAmount;

  OrderTotalsEntity({
    required this.subtotal,
    required this.discounts,
    required this.shippingCost,
    required this.totalAmount,
  });
}

class PaymentInfoEntity {
  String paymentMethod;
  String paymentId;
  String paymentAmount;
  String paymentDate;

  PaymentInfoEntity({
    required this.paymentMethod,
    required this.paymentId,
    required this.paymentAmount,
    required this.paymentDate,
  });
}

class ShippingInfoEntity {
  String shippingCost;
  DateTime estimatedDeliveryDate;

  ShippingInfoEntity({
    required this.shippingCost,
    required this.estimatedDeliveryDate,
  });
}
