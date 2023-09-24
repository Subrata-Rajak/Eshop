import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/cart/data/models/cart_details_model.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/cart/utils/cart_details_mapper.dart';

class CartDetailsService {
  final client = HttpService.httpClient;

  Future<CartDetailsEntity?> getCartDetails() async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);

    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    CartDetailsEntity? cartDetailsEntity;

    try {
      final url = "${ApiConstants.constants.baseUrl}cart/all";

      final queryParams = {
        "email": userEmail,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;
        CartDetails cartDetails = cartDetailsFromJson(jsonString);
        cartDetailsEntity = CartDetailsMapper.mapModelToEntity(cartDetails);
      }
    } catch (error) {
      print("Error while fetching cart details -- API : $error");
    }

    return cartDetailsEntity;
  }

  Future<bool> increaseCartQuantity({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    bool res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}cart/quantity/increase";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final data = {
        "email": userEmail,
        "productId": productId,
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
      print("Error while increasing product cart quantity -- API $error");
    }

    return res;
  }

  Future<bool> decreaseCartQuantity({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    bool res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}cart/quantity/decrease";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final data = {
        "email": userEmail,
        "productId": productId,
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
      print("Error while increasing product cart quantity -- API $error");
    }

    return res;
  }
}
