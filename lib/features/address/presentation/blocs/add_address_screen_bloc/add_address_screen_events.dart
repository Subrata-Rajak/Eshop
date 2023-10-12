abstract class AddAddressScreenEvents {}

class AddAddressEvent extends AddAddressScreenEvents {
  final String country;
  final String area;
  final String pincode;
  final String landmark;
  final String city;
  final String state;
  final bool selected;

  AddAddressEvent({
    required this.area,
    required this.city,
    required this.country,
    required this.landmark,
    required this.pincode,
    required this.selected,
    required this.state,
  });
}
