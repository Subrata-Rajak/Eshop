import '../entity/user_entity.dart';

abstract class UserRepoSitory {
  Future<UserEntity?> getUserInfo();
  Future<bool> addAddress({
    required String email,
    required String country,
    required String state,
    required String city,
    required String landmark,
    required String pincode,
    required String area,
  });
  Future<bool> updateProfileImageUrl({
    required String email,
    required String url,
  });
}
