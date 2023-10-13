abstract class CollectUserDetailsRepository {
  Future<bool> updateUserDetails({
    required String country,
    required String state,
    required String city,
    required String area,
    required String pincode,
    required String landmark,
    required String bio,
    required String gender,
    required String phone,
  });
}
