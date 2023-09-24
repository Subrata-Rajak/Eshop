import 'package:eshop/features/product_details/data/data_source/remote/product_details_cart_service.dart';
import 'package:eshop/features/product_details/domain/repositories/product_details_cart_repository.dart';

class ProductDetailsCartRepositoryImpl implements ProductDetailsCartRepository {
  final ProductDetailsCartService productDetailsCartService;

  ProductDetailsCartRepositoryImpl({required this.productDetailsCartService});

  @override
  Future<bool> addToCart({required String productId}) async {
    return await productDetailsCartService.addToCart(productId: productId);
  }

  @override
  Future<bool> removeFromCart({required String productId}) async {
    return await productDetailsCartService.removeFromCart(productId: productId);
  }

  @override
  Future<bool> isProductInCart({required String productId}) async {
    return await productDetailsCartService.isProductInCart(
      productId: productId,
    );
  }
}
