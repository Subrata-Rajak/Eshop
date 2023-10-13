abstract class CollectUserInfoScreenEvents {}

class CollectUserInfoEvent extends CollectUserInfoScreenEvents {
  final String country;
  final String state;
  final String city;
  final String area;
  final String landmark;
  final String pincode;
  final String gender;
  final String bio;
  final String phone;

  CollectUserInfoEvent({
    required this.country,
    required this.state,
    required this.city,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.gender,
    required this.bio,
    required this.phone,
  });
}
