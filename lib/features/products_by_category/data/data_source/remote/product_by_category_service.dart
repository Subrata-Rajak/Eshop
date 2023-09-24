import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';
import 'package:eshop/features/products_by_category/utils/product_by_category_mapper.dart';

import '../../models/product_by_category_model.dart';

class ProductByCategoryService {
  final client = HttpService.httpClient;

  Future<ProductByCategoryEntity?> getProductByCategory({
    required String categoryName,
  }) async {
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    ProductByCategoryEntity? productByCategory;

    try {
      final url = "${ApiConstants.constants.baseUrl}product/category";

      final queryParams = {
        "category": categoryName,
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
        ProductByCategory productByCategoryModel =
            productByCategoryFromJson(jsonString);
        productByCategory = ProductByCategoryMapper.mapModelToEntity(
            productByCategory: productByCategoryModel);
      }
    } catch (error) {
      print("Error while fetching products by category -- Api: $error");
    }

    return productByCategory;
  }
}
