import '../data/models/product_model.dart' as pmodel;
import '../domain/entities/product_entity.dart' as pentity;

class ProductDetailsMapper {
  static pentity.ProductDetailsEntity mapModelToEntity({
    required pmodel.ProductDetails product,
  }) {
    return pentity.ProductDetailsEntity(
      ownerInfo:
          pentity.ProductDetailsOwnerInfoEntity(email: product.ownerInfo.email),
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
    );
  }

  static pmodel.ProductDetails mapEntityToModel({
    required pentity.ProductDetailsEntity product,
  }) {
    return pmodel.ProductDetails(
      ownerInfo: pmodel.ProductDetailsOwnerInfo(email: product.ownerInfo.email),
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
    );
  }
}
