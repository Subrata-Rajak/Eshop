import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/home/data/models/all_product_categories_model.dart';
import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart';
import 'package:eshop/features/home/utils/all_product_categories_mapper.dart';

class AllProductsCategoryService {
  final client = HttpService.httpClient;

  Future<AllProductsCategoryEntity?> getAllProductCategories() async {
    AllProductsCategoryEntity? allProductsCategoryEntity;
    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    try {
      final url = "${ApiConstants.constants.baseUrl}categories/all";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url);

      final response = await client.get(
        uri,
        headers: headers,
      );

      AllProductCategories result;

      if (response.statusCode == 200) {
        var jsonString = response.body;
        result = allProductCategoriesFromJson(jsonString);
        allProductsCategoryEntity =
            AllProductCategoriesMapper.mapAllProductCategoriesModelToEntity(
          model: result,
        );
      }
    } catch (error) {
      print("Error while fetching all product categories: $error");
    }
    return allProductsCategoryEntity;
  }
}
