// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  UserClass user;

  User({
    required this.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class UserClass {
  String id;
  String name;
  String email;
  String password;
  List<String?> reviewsAndRatings;
  List<Address> address;
  int v;
  String profileImageUrl;

  UserClass({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.reviewsAndRatings,
    required this.address,
    required this.v,
    required this.profileImageUrl,
  });

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        reviewsAndRatings:
            List<String?>.from(json["reviews_and_ratings"].map((x) => x)),
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        v: json["__v"],
        profileImageUrl: json["profile_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "password": password,
        "reviews_and_ratings":
            List<String?>.from(reviewsAndRatings.map((x) => x)),
        "address": List<Address>.from(address.map((x) => x.toJson())),
        "__v": v,
        "profile_image_url": profileImageUrl,
      };
}

class Address {
  String country;
  String state;
  String city;
  String area;
  String landmark;
  String id;
  String pincode;
  bool selected;

  Address({
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.id,
    required this.pincode,
    required this.selected,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        country: json["country"],
        state: json["state"],
        city: json["city"],
        area: json["area"],
        landmark: json["landmark"],
        id: json["_id"],
        pincode: json["pincode"],
        selected: json['selected'],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "state": state,
        "city": city,
        "area": area,
        "landmark": landmark,
        "_id": id,
        "pincode": pincode,
        'selected': selected,
      };
}
