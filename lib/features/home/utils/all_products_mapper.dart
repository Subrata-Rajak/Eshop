import 'package:eshop/features/home/data/models/all_products_model.dart'
    as pmodel;
import 'package:eshop/features/home/domain/entity/all_products_entity.dart'
    as pentity;

class AllProductsMapper {
  static pentity.AllProductsEntity mapModelToEntity({
    required pmodel.AllProducts allProducts,
  }) {
    final List<pentity.Product> products = allProducts.products
        .map(
          (product) => pentity.Product(
            ownerInfo: pentity.OwnerInfo(email: product.ownerInfo.email),
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
          ),
        )
        .toList();

    return pentity.AllProductsEntity(products: products);
  }

  static pmodel.AllProducts mapEntityToModel({
    required pentity.AllProductsEntity entity,
  }) {
    final List<pmodel.Product> products = entity.products
        .map(
          (product) => pmodel.Product(
            brand: product.brand,
            category: product.category,
            description: product.description,
            id: product.id,
            imageUrl: product.imageUrl,
            name: product.name,
            ownerInfo: pmodel.OwnerInfo(email: product.ownerInfo.email),
            price: product.price,
            reviews: product.reviews,
            stockQuantity: product.stockQuantity,
            subCategory: product.subCategory,
            v: product.v,
          ),
        )
        .toList();

    return pmodel.AllProducts(products: products);
  }
}
