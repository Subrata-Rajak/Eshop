import 'package:eshop/features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_bloc.dart';

import '../../../../cart/domain/entities/cart_details_entity.dart';
import '../../../../product_details/domain/entities/product_entity.dart';

abstract class PaymentMethodScreenEvents {}

class PlaceOrderEvent extends PaymentMethodScreenEvents {
  final String addressId;
  final String country;
  final String state;
  final String city;
  final String landmark;
  final String area;
  final String pincode;
  final PaymentMethods paymentMethod;
  final String amount;
  final CartDetailsEntity? orderItemsFromCartDetails;
  final ProductDetailsEntity? orderItemsFromProductDetails;
  final String totalAmount;
  final String orderSubTotal;

  PlaceOrderEvent({
    required this.addressId,
    required this.country,
    required this.state,
    required this.city,
    required this.landmark,
    required this.area,
    required this.pincode,
    required this.paymentMethod,
    required this.amount,
    required this.orderItemsFromCartDetails,
    required this.orderItemsFromProductDetails,
    required this.totalAmount,
    required this.orderSubTotal,
  });
}
