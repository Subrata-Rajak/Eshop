import 'package:eshop/features/address/domain/entities/address_entity.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:eshop/features/product_details/domain/entities/product_entity.dart';

import '../../features/home/domain/entity/user_entity.dart';
import '../../features/order_details/domain/entities/selected_address_entity.dart';
import '../../features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_bloc.dart';

class OtpVerificationScreenArgs {
  final String email;

  OtpVerificationScreenArgs({required this.email});
}

class UpdatePasswordScreenArgs {
  final String email;

  UpdatePasswordScreenArgs({required this.email});
}

class ProductDetailsScreenArgs {
  final String productId;

  ProductDetailsScreenArgs({required this.productId});
}

class ProductByCategoryScreenArgs {
  final String categoryName;

  ProductByCategoryScreenArgs({required this.categoryName});
}

class OrderSummaryScreenArgs {
  final CartDetailsEntity? cartDetails;
  final ProductDetailsEntity? productDetails;

  OrderSummaryScreenArgs({
    required this.cartDetails,
    required this.productDetails,
  });
}

class PaymentMethodScreenArgs {
  final String amount;
  final SelectedAddressEntity? selectedAddress;
  final CartDetailsEntity? cartDetails;
  final ProductDetailsEntity? productDetails;
  final String orderSubTotal;

  PaymentMethodScreenArgs({
    required this.amount,
    required this.selectedAddress,
    required this.cartDetails,
    required this.productDetails,
    required this.orderSubTotal,
  });
}

class OrderPlaceScreenArgs {
  final String addressId;
  final String country;
  final String state;
  final String city;
  final String landmark;
  final String area;
  final String pincode;
  final PaymentMethods paymentMethod;
  final String amount;
  final CartDetailsEntity? orderItemsFromCartDetails;
  final ProductDetailsEntity? orderItemsFromProductDetails;
  final String totalAmount;
  final String orderSubTotal;

  OrderPlaceScreenArgs({
    required this.addressId,
    required this.country,
    required this.state,
    required this.city,
    required this.landmark,
    required this.area,
    required this.pincode,
    required this.paymentMethod,
    required this.amount,
    required this.orderItemsFromCartDetails,
    required this.orderItemsFromProductDetails,
    required this.totalAmount,
    required this.orderSubTotal,
  });
}

class EditProfileScreenArgs {
  UserEntity? user;

  EditProfileScreenArgs({required this.user});
}

class EditAddressScreenArgs {
  AddressEntity? addressEntity;

  EditAddressScreenArgs({required this.addressEntity});
}

class OrderHistoryDetailsScreenArgs {
  OrderEntity orderEntity;

  OrderHistoryDetailsScreenArgs({required this.orderEntity});
}
