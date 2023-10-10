import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/order_details/data/models/selected_address_model.dart';
import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';
import 'package:eshop/features/order_details/utils/selected_address_mapper.dart';

class SelectedAddressService {
  final client = HttpService.httpClient;

  Future<SelectedAddressEntity?> getSelectedAddress() async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);

    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    SelectedAddressEntity? selectedAddress;

    try {
      final url = "${ApiConstants.constants.baseUrl}user/address/selected";

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
        SelectedAddress selectedAddressModel =
            selectedAddressFromJson(jsonString);
        selectedAddress = SelectedAddressMapper.mapModelToEntity(
          selectedAddress: selectedAddressModel,
        );
      }
    } catch (error) {
      print("Error while fetching selected address -- API: $error");
    }

    return selectedAddress;
  }
}
