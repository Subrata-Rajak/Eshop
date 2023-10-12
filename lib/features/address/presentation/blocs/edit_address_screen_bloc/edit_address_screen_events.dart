abstract class EditAddressScreenEvents {}

class EditAddressEvent extends EditAddressScreenEvents {
  final String country;
  final String city;
  final String area;
  final String pincode;
  final String landmark;
  final String state;
  final bool selected;

  EditAddressEvent({
    required this.area,
    required this.city,
    required this.country,
    required this.landmark,
    required this.pincode,
    required this.selected,
    required this.state,
  });
}
