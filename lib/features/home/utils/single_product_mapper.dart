import '../data/models/single_product_model.dart' as spmodel;
import '../domain/entity/single_product_entity.dart' as spentity;

class SingleProductMapper {
  static spmodel.SingleProduct mapEntityToModel(
      {required spentity.SingleProductEntity singleProductEntity}) {
    return spmodel.SingleProduct(
      ownerInfo: spmodel.SingleProductsOwnerInfo(
          email: singleProductEntity.ownerInfo.email),
      id: singleProductEntity.id,
      name: singleProductEntity.name,
      description: singleProductEntity.description,
      price: singleProductEntity.price,
      category: singleProductEntity.category,
      subCategory: singleProductEntity.subCategory,
      brand: singleProductEntity.brand,
      imageUrl: singleProductEntity.imageUrl,
      stockQuantity: singleProductEntity.stockQuantity,
      reviews: singleProductEntity.reviews,
      v: singleProductEntity.v,
    );
  }

  static spentity.SingleProductEntity mapModelToEntity(
      {required spmodel.SingleProduct singleProduct}) {
    return spentity.SingleProductEntity(
      ownerInfo: spentity.SingleProductsOwnerInfoEntity(
          email: singleProduct.ownerInfo.email),
      id: singleProduct.id,
      name: singleProduct.name,
      description: singleProduct.description,
      price: singleProduct.price,
      category: singleProduct.category,
      subCategory: singleProduct.subCategory,
      brand: singleProduct.brand,
      imageUrl: singleProduct.imageUrl,
      stockQuantity: singleProduct.stockQuantity,
      reviews: singleProduct.reviews,
      v: singleProduct.v,
    );
  }
}
