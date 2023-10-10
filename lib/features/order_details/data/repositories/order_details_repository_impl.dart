import 'package:eshop/features/order_details/data/data_source/remote/order_details_service.dart';
import 'package:eshop/features/order_details/domain/repositories/order_details_repository.dart';

import '../../../cart/domain/entities/cart_details_entity.dart';
import '../../../product_details/domain/entities/product_entity.dart';
import '../../presentation/blocs/payment_method_screen_bloc/payment_method_screen_bloc.dart';

class OrderDetailsRepositoryImpl implements OrderDetailsRepository {
  final OrderDetailsService orderDetailsService;

  OrderDetailsRepositoryImpl({required this.orderDetailsService});

  @override
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
  }) async {
    return orderDetailsService.placeOrder(
      addressId: addressId,
      country: country,
      state: state,
      city: city,
      landmark: landmark,
      area: area,
      pincode: pincode,
      paymentMethod: paymentMethod,
      amount: amount,
      orderItemsFromCartDetails: orderItemsFromCartDetails,
      orderItemsFromProductDetails: orderItemsFromProductDetails,
      totalAmount: totalAmount,
      orderSubTotal: orderSubTotal,
    );
  }
}
