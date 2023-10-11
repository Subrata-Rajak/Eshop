import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/home/utils/user_mapper.dart';

import '../../../domain/entity/user_entity.dart';
import '../../models/user_model.dart';

class UserService {
  final client = HttpService.httpClient;

  Future<UserEntity?> getUserInfo() async {
    UserEntity? userEntity;

    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    var userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);

    try {
      final url = "${ApiConstants.constants.baseUrl}user/info";

      final queryParams = {
        "email": userEmail,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(uri, headers: headers);

      print(response.statusCode);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        User user = userFromJson(jsonString);
        userEntity = UserMapper.mapUserModelToEntity(user: user);
      }
    } catch (error) {
      print("Error while fetching user info: $error");
    }

    return userEntity;
  }

  Future<bool> addAddress({
    required String email,
    required String country,
    required String state,
    required String city,
    required String landmark,
    required String pincode,
    required String area,
  }) async {
    var res = false;
    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    try {
      final url = "${ApiConstants.constants.baseUrl}user/address";

      final data = {
        "email": email,
        "country": country,
        "state": state,
        "city": city,
        "landmark": landmark,
        "pincode": pincode,
        "area": area,
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
      print("Error while adding address $error");
    }

    return res;
  }

  Future<bool> updateProfileImageUrl({
    required String email,
    required String url,
  }) async {
    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}user/profileImageUrl";

      final data = {
        "email": email,
        "url": url,
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
      print("Error while updating profile image url: $error");
    }

    return res;
  }

  Future<bool> updateUserProfileInfo({
    required String name,
    required String bio,
    required String gender,
    required String phone,
  }) async {
    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    var userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}user/update";

      final data = {
        "email": userEmail,
        "name": name,
        "bio": bio,
        "gender": gender,
        "phone": phone,
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
      print("Error while updating profile info -- Api: $error");
    }

    return res;
  }
}
