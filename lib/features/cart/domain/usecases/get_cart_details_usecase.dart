import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/cart/domain/repository/cart_details_repository.dart';

class GetCartDetailsUsecase {
  final CartDetailsRepository cartDetailsRepository;

  GetCartDetailsUsecase({required this.cartDetailsRepository});

  Future<CartDetailsEntity?> getCartDetails() async {
    return await cartDetailsRepository.getCartDetails();
  }
}
