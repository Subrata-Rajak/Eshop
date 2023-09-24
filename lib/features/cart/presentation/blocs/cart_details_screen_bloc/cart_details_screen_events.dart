abstract class CartDetailsScreenEvents {}

class FetchCartDetailsEvent extends CartDetailsScreenEvents {}

class IncreaseCartQuantityEvent extends CartDetailsScreenEvents {
  final String productId;

  IncreaseCartQuantityEvent({required this.productId});
}

class DecreaseCartQuantityEvent extends CartDetailsScreenEvents {
  final String productId;

  DecreaseCartQuantityEvent({required this.productId});
}
