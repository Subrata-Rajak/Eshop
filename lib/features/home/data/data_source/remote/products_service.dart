import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/home/data/models/all_products_model.dart';
import 'package:eshop/features/home/domain/entity/all_products_entity.dart';
import 'package:eshop/features/home/utils/all_products_mapper.dart';

class ProductsService {
  final client = HttpService.httpClient;

  Future<AllProductsEntity?> getAllProducts() async {
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);
    AllProductsEntity? allProductsEntity;

    try {
      final url = "${ApiConstants.constants.baseUrl}product/all";

      final headers = {
        "Content-Type": "application.json",
        "Authorization": "Bearer $userToken",
      };

      final uri = Uri.parse(url);

      final response = await client.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;
        AllProducts products = allProductsFromJson(jsonString);
        allProductsEntity =
            AllProductsMapper.mapModelToEntity(allProducts: products);
      }
    } catch (error) {
      print("Error fetching all products $error");
    }
    return allProductsEntity;
  }
}
