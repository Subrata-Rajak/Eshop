import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/product_details/data/models/product_model.dart';
import 'package:eshop/features/product_details/domain/entities/product_entity.dart';
import 'package:eshop/features/product_details/utils/product_mapper.dart';

class ProductDetailsService {
  final client = HttpService.httpClient;

  Future<ProductDetailsEntity?> getProductDetails({
    required String productId,
  }) async {
    ProductDetailsEntity? productDetails;
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    try {
      final url = "${ApiConstants.constants.baseUrl}product/id";

      final queryParams = {
        "productId": productId,
      };

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(uri, headers: headers);

      if (response.statusCode == 200) {
        var jsonString = response.body;
        ProductDetails product = productDetailsFromJson(jsonString);
        productDetails =
            ProductDetailsMapper.mapModelToEntity(product: product);
      }
    } catch (error) {
      print("Error while fetching product details $error");
    }

    return productDetails;
  }
}
