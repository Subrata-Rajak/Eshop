import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/core/common/service.dart';
import 'package:eshop/core/constants/api_constants.dart';
import 'package:eshop/features/home/data/models/wishlist_items_model.dart';
import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';
import 'package:eshop/features/home/utils/wishlist_items_mapper.dart';

class WishlistItemsService {
  final client = HttpService.httpClient;

  Future<WishlistItemsEntity?> getWishlist() async {
    final userEmail =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userEmailKey);
    final userToken =
        GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.userTokenKey);

    WishlistItemsEntity? wishlistItemsEntity;

    try {
      final url = "${ApiConstants.constants.baseUrl}wishlist/all";

      final queryParams = {
        "email": userEmail,
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
        WishlistItems wishlistItems = wishlistItemsFromJson(jsonString);
        wishlistItemsEntity =
            WishlistItemsMapper.mapModelToEntity(wishlistItems: wishlistItems);
      }
    } catch (error) {
      print("Error while fetching wishlist items $error");
    }

    return wishlistItemsEntity;
  }
}
