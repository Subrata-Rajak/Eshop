import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';

class ProductDetailsCartService {
  final client = HttpService.httpClient;

  Future<bool> addToCart({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    bool res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}cart/add";

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
      print("Error while adding product to cart: $error");
    }

    return res;
  }

  Future<bool> removeFromCart({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    bool res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}cart/remove";

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
      print("Error while removing product from cart: $error");
    }

    return res;
  }

  Future<bool> isProductInCart({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    bool res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}cart/product";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final queryParams = {
        "email": userEmail,
        "productId": productId,
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        res = true;
      }
    } catch (error) {
      print("Error while checking if product is in cart: $error");
    }

    return res;
  }
}
