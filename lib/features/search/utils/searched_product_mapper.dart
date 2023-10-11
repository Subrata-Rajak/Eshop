import 'package:eshop/features/search/data/models/searched_product_model.dart';
import 'package:eshop/features/search/domain/entities/search_product_entity.dart';

class SearchedProductMapper {
  static SearchedProductListEntity mapModelToEntity({
    required SearchedProductList searchedProductList,
  }) {
    List<SearchedProductEntity> searchedProductListEntity = searchedProductList
        .productsList
        .map(
          (product) => SearchedProductEntity(
            ownerInfo:
                SearchedProductOwnerInfoEntity(email: product.ownerInfo.email),
            id: product.id,
            name: product.name,
            description: product.description,
            price: product.price,
            category: product.category,
            subCategory: product.subCategory,
            brand: product.brand,
            imageUrl: product.imageUrl,
            stockQuantity: product.stockQuantity,
            reviews: product.reviews,
            v: product.v,
            searchTags: product.searchTags,
            coupons: product.coupons,
          ),
        )
        .toList();

    return SearchedProductListEntity(
        searchedProductList: searchedProductListEntity);
  }

  static SearchedProductList mapEntityToModel({
    required SearchedProductListEntity searchedProductListEntity,
  }) {
    List<SearchedProduct> searchedProductList =
        searchedProductListEntity.searchedProductList
            .map(
              (product) => SearchedProduct(
                ownerInfo: SearchedProductOwnerInfo(
                  email: product.ownerInfo.email,
                ),
                id: product.id,
                name: product.name,
                description: product.description,
                price: product.price,
                category: product.category,
                subCategory: product.subCategory,
                brand: product.brand,
                imageUrl: product.imageUrl,
                stockQuantity: product.stockQuantity,
                reviews: product.reviews,
                v: product.v,
                searchTags: product.searchTags,
                coupons: product.coupons,
              ),
            )
            .toList();

    return SearchedProductList(productsList: searchedProductList);
  }
}
