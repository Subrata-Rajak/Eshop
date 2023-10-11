abstract class SearchProductScreenEvents {}

class SearchProductEvent extends SearchProductScreenEvents {
  final String tag;

  SearchProductEvent({required this.tag});
}
