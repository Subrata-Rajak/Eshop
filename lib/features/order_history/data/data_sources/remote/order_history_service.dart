import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/order_history/data/models/order_history_model.dart';
import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:eshop/features/order_history/utils/order_history_mapper.dart';

class OrderHistoryService {
  final client = HttpService.httpClient;

  Future<OrderHistoryEntity?> getOrderHistory() async {
    var userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    OrderHistoryEntity? orderHistory;

    try {
      final url = "${ApiConstants.constants.baseUrl}order/all";

      final queryParams = {
        "email": userEmail,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        OrdersHistory ordersHistoryModel = ordersHistoryFromJson(jsonString);
        orderHistory = OrderHistoryMapper.mapModelToEntity(
          ordersHistory: ordersHistoryModel,
        );
      }
    } catch (error) {
      print("Error while fetching order history -- API: $error");
    }

    return orderHistory;
  }

  Future<bool> cancelOrder({required String orderId}) async {
    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    bool res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}order/cancel";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final data = {
        "orderId": orderId,
      };

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        res = true;
      }
    } catch (error) {
      print("Error while cancelling order -- API: $error");
    }

    return res;
  }
}
