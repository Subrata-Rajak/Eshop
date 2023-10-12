import '../entity/user_entity.dart';

abstract class UserRepoSitory {
  Future<UserEntity?> getUserInfo();
  Future<bool> updateProfileImageUrl({
    required String email,
    required String url,
  });
  Future<bool> updateProfileInfo({
    required String name,
    required String bio,
    required String gender,
    required String phone,
  });
}
