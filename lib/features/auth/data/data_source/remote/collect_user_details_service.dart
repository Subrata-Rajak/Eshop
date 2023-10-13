import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';

class CollectUserDetailsService {
  final client = HttpService.httpClient;

  Future<bool> updateUserDetails({
    required String country,
    required String state,
    required String city,
    required String area,
    required String pincode,
    required String landmark,
    required String bio,
    required String gender,
    required String phone,
  }) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    var res = false;

    try {
      final addressUrl = "${ApiConstants.constants.baseUrl}user/address";
      final userInfoUrl = "${ApiConstants.constants.baseUrl}user/update";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final userInfoData = {
        "email": userEmail,
        "bio": bio,
        "gender": gender,
        "phone": phone,
      };

      final addressData = {
        "email": userEmail,
        "country": country,
        "state": state,
        "area": area,
        "landmark": landmark,
        "pincode": pincode,
        "selected": true,
        "city": city,
      };

      final userInfoUri = Uri.parse(userInfoUrl);
      final addressUri = Uri.parse(addressUrl);

      final userInfoResponse = await client.post(
        userInfoUri,
        headers: headers,
        body: jsonEncode(userInfoData),
      );

      final addressResponse = await client.post(
        addressUri,
        headers: headers,
        body: jsonEncode(addressData),
      );

      if (userInfoResponse.statusCode == 201 &&
          addressResponse.statusCode == 201) {
        res = true;

        await GetBox.getBox.writeToLocalDb(
          key: AppLocalKeys.keys.isCollectedUserDetails,
          value: true,
        );
      }
    } catch (error) {
      print("Error while collecting user details -- API: $error");
    }

    return res;
  }
}
