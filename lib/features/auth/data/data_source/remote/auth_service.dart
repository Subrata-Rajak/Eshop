import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/auth/data/models/user_model.dart';

import '../../../../../core/common/service.dart';

class AuthService {
  final client = HttpService.httpClient;

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    var res = false;
    try {
      final url = '${ApiConstants.constants.baseUrl}user/login';

      final data = {
        "email": email,
        "password": password,
      };

      final headers = {
        "Content-type": "application/json",
      };

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      User user;

      if (response.statusCode == 200) {
        res = true;
        user = userFromJson(response.body);
        var userToken =
            GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
        var userEmail =
            GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);

        if (userToken == null) {
          await GetBox.getBox.writeToLocalDb(
            key: AppLocalKeys.keys.userTokenKey,
            value: user.token,
          );
        }

        if (userEmail == null) {
          await GetBox.getBox.writeToLocalDb(
            key: AppLocalKeys.keys.userEmailKey,
            value: user.user.email,
          );
        }
      }
    } catch (error) {
      print("Error while Logging in the user: $error");
    }
    return res;
  }

  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    var res = false;
    try {
      final url = '${ApiConstants.constants.baseUrl}user/register';

      final data = {
        "name": name,
        "email": email,
        "password": password,
      };

      final headers = {
        'Content-Type': "application/json",
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
      print("Error while Registering User: $error");
    }
    return res;
  }

  Future<bool> sendOtp({required String email}) async {
    var res = false;
    try {
      final url = "${ApiConstants.constants.baseUrl}user/otp";

      final data = {
        "email": email,
      };

      final headers = {
        "Content-Type": "application/json",
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
      print("Error while sending otp");
    }
    return res;
  }

  Future<bool> verifyOtp({
    required String otp,
    required String email,
  }) async {
    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}user/verifyOtp";

      final data = {
        "otp": otp,
        "email": email,
      };

      final headers = {"Content-Type": "application/json"};

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        res = true;
      }
    } catch (error) {
      print("Error while verifying otp");
    }

    return res;
  }

  Future<bool> resendOtp({
    required String email,
  }) async {
    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}user/resendOtp";

      final data = {
        "email": email,
      };

      final headers = {"Content-Type": "application/json"};

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
      print("Error while verifying otp");
    }

    return res;
  }

  Future<bool> updatePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    var res = false;

    try {
      final url = "${ApiConstants.constants.baseUrl}user/updatePassword";

      final data = {
        "email": email,
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      };

      final headers = {"Content-Type": "application/json"};

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        res = true;
      }
    } catch (error) {
      print("Error while verifying otp");
    }

    return res;
  }
}
