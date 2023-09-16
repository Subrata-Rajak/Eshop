import 'package:eshop/features/home/data/models/all_product_categories_model.dart'
    as pcmodel;
import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart'
    as pcentity;

class AllProductCategoriesMapper {
  static pcmodel.AllProductCategories mapAllProductCategoryEntityToModel({
    required pcentity.AllProductsCategoryEntity entity,
  }) {
    final List<pcmodel.ProductCategory> productCategories =
        entity.allProductCategories
            .map((category) => pcmodel.ProductCategory(
                  id: category.id,
                  categoryName: category.categoryName,
                  categoryImageUrl: category.categoryImageUrl,
                  subCategories: category.subCategories,
                  v: 0,
                ))
            .toList();

    return pcmodel.AllProductCategories(productCategories: productCategories);
  }

  static pcentity.AllProductsCategoryEntity
      mapAllProductCategoriesModelToEntity({
    required pcmodel.AllProductCategories model,
  }) {
    final List<pcentity.ProductCategory> productCategoryEntities =
        model.productCategories
            .map((category) => pcentity.ProductCategory(
                  id: category.id,
                  categoryName: category.categoryName,
                  categoryImageUrl: category.categoryImageUrl,
                  subCategories: category.subCategories,
                ))
            .toList();

    return pcentity.AllProductsCategoryEntity(
      allProductCategories: productCategoryEntities,
    );
  }
}
