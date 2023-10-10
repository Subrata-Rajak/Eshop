import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_bloc.dart';
import 'package:eshop/features/product_details/domain/entities/product_entity.dart';

class OrderDetailsService {
  final client = HttpService.httpClient;

  Future<bool> placeOrder({
    required String addressId,
    required String country,
    required String state,
    required String city,
    required String landmark,
    required String area,
    required String pincode,
    required PaymentMethods paymentMethod,
    required String amount,
    required CartDetailsEntity? orderItemsFromCartDetails,
    required ProductDetailsEntity? orderItemsFromProductDetails,
    required String totalAmount,
    required String orderSubTotal,
  }) async {
    var res = false;
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    try {
      final url = "${ApiConstants.constants.baseUrl}order/place";

      final data = {
        "paymentStatus":
            paymentMethod == PaymentMethods.payOnDelivery ? "pending" : "paid",
        "addressId": addressId,
        "country": country,
        "state": state,
        "city": city,
        "landmark": landmark,
        "area": area,
        "pincode": pincode,
        "paymentMethod": paymentMethod == PaymentMethods.payOnDelivery
            ? "Pay on Delivery"
            : "Pay with Stripe",
        "paymentId":
            paymentMethod == PaymentMethods.payOnDelivery ? "COD" : "StripeId",
        "paymentDate": paymentMethod == PaymentMethods.payOnDelivery
            ? "pending"
            : "${DateTime.now()}",
        "customerEmail": userEmail,
        "orderItems": orderItemsFromCartDetails == null
            ? [orderItemsFromProductDetails!.toOrderItem()]
            : orderItemsFromCartDetails.toOrderItems(),
        "totalDiscounts": "",
        "totalAmount": totalAmount,
        "orderSubTotal": orderSubTotal,
        "cancelOrderAction": true,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final response = await client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        res = true;
      }
    } catch (error) {
      print("Error while placing order: $error");
    }

    return res;
  }
}
