import 'package:eshop/features/products_by_category/data/models/product_by_category_model.dart';
import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';

class ProductByCategoryMapper {
  static ProductByCategoryEntity mapModelToEntity({
    required ProductByCategory productByCategory,
  }) {
    final res = productByCategory.products
        .map((product) => ProductByCategoryProductEntity(
              ownerInfo: ProductByCategoryOwnerInfoEntity(
                  email: product.ownerInfo.email),
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
            ))
        .toList();

    return ProductByCategoryEntity(productByCategory: res);
  }

  static ProductByCategory mapEntityToModel({
    required ProductByCategoryEntity productByCategoryEntity,
  }) {
    final res = productByCategoryEntity.productByCategory
        .map((product) => ProductByCategoryProduct(
              ownerInfo:
                  ProductByCategoryOwnerInfo(email: product.ownerInfo.email),
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
            ))
        .toList();

    return ProductByCategory(products: res);
  }
}
