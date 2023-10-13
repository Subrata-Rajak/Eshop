import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';

class UploadImageService {
  final client = HttpService.httpClient;

  Future<bool> uploadImageUrl({required String imageUrl}) async {
    var res = false;
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);

    print(userEmail);
    print(userToken);

    try {
      final url = "${ApiConstants.constants.baseUrl}user/profileImageUrl";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final data = {
        "email": userEmail,
        "url": imageUrl,
      };

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        res = true;
        await GetBox.getBox.writeToLocalDb(
          key: AppLocalKeys.keys.isUploadedImage,
          value: true,
        );
      }
    } catch (error) {
      print("Error while uploading image url -- API: $error");
    }

    return res;
  }
}
