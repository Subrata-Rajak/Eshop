// To parse this JSON data, do
//
//     final selectedAddress = selectedAddressFromJson(jsonString);

import 'dart:convert';

SelectedAddress selectedAddressFromJson(String str) =>
    SelectedAddress.fromJson(json.decode(str));

String selectedAddressToJson(SelectedAddress data) =>
    json.encode(data.toJson());

class SelectedAddress {
  SelectedAddressClass selectedAddress;

  SelectedAddress({
    required this.selectedAddress,
  });

  factory SelectedAddress.fromJson(Map<String, dynamic> json) =>
      SelectedAddress(
        selectedAddress:
            SelectedAddressClass.fromJson(json["selected_address"]),
      );

  Map<String, dynamic> toJson() => {
        "selected_address": selectedAddress.toJson(),
      };
}

class SelectedAddressClass {
  String country;
  String state;
  String city;
  String area;
  String landmark;
  String pincode;
  bool selected;
  String id;

  SelectedAddressClass({
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.selected,
    required this.id,
  });

  factory SelectedAddressClass.fromJson(Map<String, dynamic> json) =>
      SelectedAddressClass(
        country: json["country"],
        state: json["state"],
        city: json["city"],
        area: json["area"],
        landmark: json["landmark"],
        pincode: json["pincode"],
        selected: json["selected"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "state": state,
        "city": city,
        "area": area,
        "landmark": landmark,
        "pincode": pincode,
        "selected": selected,
        "_id": id,
      };
}
