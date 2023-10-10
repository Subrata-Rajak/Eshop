import '../../../cart/domain/entities/cart_details_entity.dart';
import '../../../product_details/domain/entities/product_entity.dart';
import '../../presentation/blocs/payment_method_screen_bloc/payment_method_screen_bloc.dart';

abstract class OrderDetailsRepository {
  Future<bool> placeOrder({
    required String addressId,
    required String country,
    required String state,
    required String city,
    required String landmark,
    required String area,
    required String pincode,
    required PaymentMethods paymentMethod,
    required String amount,
    required CartDetailsEntity? orderItemsFromCartDetails,
    required ProductDetailsEntity? orderItemsFromProductDetails,
    required String totalAmount,
    required String orderSubTotal,
  });
}
