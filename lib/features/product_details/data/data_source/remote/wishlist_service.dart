import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';

class WishlistService {
  final client = HttpService.httpClient;

  Future<bool> isProductInWishlist({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}wishlist/product";

      final queryParams = {
        "email": userEmail,
        "productId": productId,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        res = true;
      }
    } catch (error) {
      print("Error while checking is product in wishlist: $error");
    }

    return res;
  }

  Future<bool> addToWishList({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);

    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}wishlist/add";

      final data = {
        "email": userEmail,
        "productId": productId,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
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
      print("Error while adding product to wishlist $error");
    }

    return res;
  }

  Future<bool> removeFromWishlist({required String productId}) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);

    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}wishlist/remove";

      final data = {
        "email": userEmail,
        "productId": productId,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
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
      print("Error while removing product from wishlist $error");
    }

    return res;
  }
}
