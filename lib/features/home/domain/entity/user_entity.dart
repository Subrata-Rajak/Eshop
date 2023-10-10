class UserEntity {
  final String id;
  final String name;
  final String email;
  final String password;
  final String profileImageUrl;
  final int v;
  final List<Address> addresses;
  final List<String?> reviewsAndRatings;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.profileImageUrl,
    required this.v,
    required this.addresses,
    required this.reviewsAndRatings,
  });
}

class Address {
  final String id;
  final String country;
  final String state;
  final String city;
  final String area;
  final String landmark;
  final String pincode;
  final bool selected;

  Address({
    required this.id,
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.selected,
  });
}
