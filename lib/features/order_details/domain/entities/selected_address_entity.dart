class SelectedAddressEntity {
  SelectedAddressClassEntity selectedAddressClassEntity;

  SelectedAddressEntity({required this.selectedAddressClassEntity});
}

class SelectedAddressClassEntity {
  String country;
  String state;
  String city;
  String area;
  String landmark;
  String pincode;
  bool selected;
  String id;

  SelectedAddressClassEntity({
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.selected,
    required this.id,
  });
}
