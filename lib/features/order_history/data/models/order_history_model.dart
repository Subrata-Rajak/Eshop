// To parse this JSON data, do
//
//     final ordersHistory = ordersHistoryFromJson(jsonString);

import 'dart:convert';

OrdersHistory ordersHistoryFromJson(String str) =>
    OrdersHistory.fromJson(json.decode(str));

String ordersHistoryToJson(OrdersHistory data) => json.encode(data.toJson());

class OrdersHistory {
  List<Order> orders;

  OrdersHistory({
    required this.orders,
  });

  factory OrdersHistory.fromJson(Map<String, dynamic> json) => OrdersHistory(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  OrderInfo orderInfo;
  PaymentInfo paymentInfo;
  ShippingInfo shippingInfo;
  CustomerInfo customerInfo;
  OrderTotals orderTotals;
  OrderActions orderActions;
  String id;
  List<OrderItem> orderItems;
  int v;

  Order({
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

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderInfo: OrderInfo.fromJson(json["order_info"]),
        paymentInfo: PaymentInfo.fromJson(json["payment_info"]),
        shippingInfo: ShippingInfo.fromJson(json["shipping_info"]),
        customerInfo: CustomerInfo.fromJson(json["customer_info"]),
        orderTotals: OrderTotals.fromJson(json["order_totals"]),
        orderActions: OrderActions.fromJson(json["order_actions"]),
        id: json["_id"],
        orderItems: List<OrderItem>.from(
            json["order_items"].map((x) => OrderItem.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "order_info": orderInfo.toJson(),
        "payment_info": paymentInfo.toJson(),
        "shipping_info": shippingInfo.toJson(),
        "customer_info": customerInfo.toJson(),
        "order_totals": orderTotals.toJson(),
        "order_actions": orderActions.toJson(),
        "_id": id,
        "order_items": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "__v": v,
      };
}

class CustomerInfo {
  String customerEmail;

  CustomerInfo({
    required this.customerEmail,
  });

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        customerEmail: json["customer_email"],
      );

  Map<String, dynamic> toJson() => {
        "customer_email": customerEmail,
      };
}

class OrderActions {
  bool cancelOrder;

  OrderActions({
    required this.cancelOrder,
  });

  factory OrderActions.fromJson(Map<String, dynamic> json) => OrderActions(
        cancelOrder: json["cancel_order"],
      );

  Map<String, dynamic> toJson() => {
        "cancel_order": cancelOrder,
      };
}

class OrderInfo {
  ShippingAddress shippingAddress;
  DateTime orderDate;
  String orderStatus;
  String paymentStatus;

  OrderInfo({
    required this.shippingAddress,
    required this.orderDate,
    required this.orderStatus,
    required this.paymentStatus,
  });

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
        orderDate: DateTime.parse(json["order_date"]),
        orderStatus: json["order_status"],
        paymentStatus: json["payment_status"],
      );

  Map<String, dynamic> toJson() => {
        "shipping_address": shippingAddress.toJson(),
        "order_date": orderDate.toIso8601String(),
        "order_status": orderStatus,
        "payment_status": paymentStatus,
      };
}

class ShippingAddress {
  String addressId;
  String country;
  String state;
  String city;
  String area;
  String landmark;
  String pincode;

  ShippingAddress({
    required this.addressId,
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.pincode,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        addressId: json["address_id"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        area: json["area"],
        landmark: json["landmark"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId,
        "country": country,
        "state": state,
        "city": city,
        "area": area,
        "landmark": landmark,
        "pincode": pincode,
      };
}

class OrderItem {
  String productId;
  String productName;
  String productDescription;
  int productPrice;
  int cartQuantity;
  String productImageUrl;
  int stockQuantity;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.cartQuantity,
    required this.productImageUrl,
    required this.stockQuantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"],
        productName: json["product_name"],
        productDescription: json["product_description"],
        productPrice: json["product_price"],
        cartQuantity: json["cart_quantity"],
        productImageUrl: json["product_image_url"],
        stockQuantity: json["stock_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_description": productDescription,
        "product_price": productPrice,
        "cart_quantity": cartQuantity,
        "product_image_url": productImageUrl,
        "stock_quantity": stockQuantity,
      };
}

class OrderTotals {
  String subtotal;
  String discounts;
  String shippingCost;
  String totalAmount;

  OrderTotals({
    required this.subtotal,
    required this.discounts,
    required this.shippingCost,
    required this.totalAmount,
  });

  factory OrderTotals.fromJson(Map<String, dynamic> json) => OrderTotals(
        subtotal: json["subtotal"],
        discounts: json["discounts"],
        shippingCost: json["shipping_cost"],
        totalAmount: json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "discounts": discounts,
        "shipping_cost": shippingCost,
        "total_amount": totalAmount,
      };
}

class PaymentInfo {
  String paymentMethod;
  String paymentId;
  String paymentAmount;
  String paymentDate;

  PaymentInfo({
    required this.paymentMethod,
    required this.paymentId,
    required this.paymentAmount,
    required this.paymentDate,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) => PaymentInfo(
        paymentMethod: json["payment_method"],
        paymentId: json["payment_id"],
        paymentAmount: json["payment_amount"],
        paymentDate: json["payment_date"],
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "payment_id": paymentId,
        "payment_amount": paymentAmount,
        "payment_date": paymentDate,
      };
}

class ShippingInfo {
  String shippingCost;
  DateTime estimatedDeliveryDate;

  ShippingInfo({
    required this.shippingCost,
    required this.estimatedDeliveryDate,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) => ShippingInfo(
        shippingCost: json["shipping_cost"],
        estimatedDeliveryDate: DateTime.parse(json["estimated_delivery_date"]),
      );

  Map<String, dynamic> toJson() => {
        "shipping_cost": shippingCost,
        "estimated_delivery_date": estimatedDeliveryDate.toIso8601String(),
      };
}
