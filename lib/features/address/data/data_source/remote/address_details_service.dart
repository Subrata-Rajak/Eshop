import 'dart:convert';

import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/address/data/models/address_model.dart';
import 'package:eshop/features/address/domain/entities/address_entity.dart';
import 'package:eshop/features/address/utils/address_maper.dart';

class AddressDetailsService {
  final client = HttpService.httpClient;

  Future<AddressesEntity?> getAddresses() async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    AddressesEntity? addressesEntity;

    try {
      final url = "${ApiConstants.constants.baseUrl}user/address";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final queryParams = {
        "email": userEmail,
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        AddressesModel addressesModel = addressesFromJson(jsonString);
        addressesEntity =
            AddressMapper.mapModelToEntity(addressesModel: addressesModel);
      }
    } catch (error) {
      print("Error while fetching address details -- API: $error");
    }

    return addressesEntity;
  }

  Future<bool> addAddress({
    required String country,
    required String state,
    required String city,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  }) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    var res = false;
    try {
      final url = "${ApiConstants.constants.baseUrl}user/address";

      final data = {
        "email": userEmail,
        "country": country,
        "state": state,
        "area": area,
        "landmark": landmark,
        "pincode": pincode,
        "selected": selected,
        "city": city,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        body: jsonEncode(data),
        headers: headers,
      );

      if (response.statusCode == 201) {
        res = true;
      }
    } catch (error) {
      print("Error while adding new address -- API: $error");
    }

    return res;
  }

  Future<bool> editAddress({
    required String country,
    required String state,
    required String city,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  }) async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    var res = false;
    try {
      final url = "${ApiConstants.constants.baseUrl}user/address/edit";

      final data = {
        "email": userEmail,
        "country": country,
        "state": state,
        "area": area,
        "landmark": landmark,
        "pincode": pincode,
        "selected": selected,
        "city": city,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url);

      final response = await client.post(
        uri,
        body: jsonEncode(data),
        headers: headers,
      );

      if (response.statusCode == 201) {
        res = true;
      }
    } catch (error) {
      print("Error while updating address -- API: $error");
    }

    return res;
  }
}
