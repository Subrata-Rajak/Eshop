abstract class ProductByCategoryScreenEvents {}

class FetchProductByCategoryDataEvent extends ProductByCategoryScreenEvents {
  final String categoryName;

  FetchProductByCategoryDataEvent({required this.categoryName});
}
