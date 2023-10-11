import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/search/data/models/searched_product_model.dart';
import 'package:eshop/features/search/domain/entities/search_product_entity.dart';
import 'package:eshop/features/search/utils/searched_product_mapper.dart';

class SearchProductService {
  final client = HttpService.httpClient;

  Future<SearchedProductListEntity?> searchProducts(
      {required String tag}) async {
    var userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    SearchedProductListEntity? searchedProductList;

    try {
      final url = "${ApiConstants.constants.baseUrl}product/search";

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $userToken",
      };

      final queryParams = {
        "tag": tag,
      };

      final uri = Uri.parse(url).replace(queryParameters: queryParams);

      final response = await client.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var jsonString = response.body;
        SearchedProductList searchedProduct =
            searchedProductFromJson(jsonString);
        searchedProductList = SearchedProductMapper.mapModelToEntity(
            searchedProductList: searchedProduct);
      }
    } catch (error) {
      print("Error while searching products -- API: $error");
    }

    return searchedProductList;
  }
}
