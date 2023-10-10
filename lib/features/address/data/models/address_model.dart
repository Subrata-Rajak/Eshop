// To parse this JSON data, do
//
//     final addresses = addressesFromJson(jsonString);

import 'dart:convert';

AddressesModel addressesFromJson(String str) =>
    AddressesModel.fromJson(json.decode(str));

String addressesToJson(AddressesModel data) => json.encode(data.toJson());

class AddressesModel {
  List<Address> addresses;

  AddressesModel({
    required this.addresses,
  });

  factory AddressesModel.fromJson(Map<String, dynamic> json) => AddressesModel(
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
      };
}

class Address {
  String country;
  String state;
  String city;
  String area;
  String landmark;
  String pincode;
  bool selected;
  String id;

  Address({
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.selected,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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
