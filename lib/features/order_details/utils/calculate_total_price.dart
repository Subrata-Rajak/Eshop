import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';

double calculateTotalPrice({
  required CartDetailsEntity? cartDetails,
}) {
  double totalPrice = 0;

  for (int i = 0; i < cartDetails!.products.length; i++) {
    totalPrice += (cartDetails.products[i].productPrice *
        cartDetails.products[i].cartQuantity);
  }

  return totalPrice;
}

double calculatePriceAfterGst({required double totalPrice}) {
  double priceAfterGst = totalPrice + (totalPrice * 0.12);
  return priceAfterGst;
}
