import 'package:eshop/features/home/data/data_source/remote/user_service.dart';
import 'package:eshop/features/home/domain/repository/user_repository.dart';

import '../../domain/entity/user_entity.dart';

class UserRepositoryImpl implements UserRepoSitory {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<UserEntity?> getUserInfo() {
    return userService.getUserInfo();
  }

  @override
  Future<bool> updateProfileImageUrl({
    required String email,
    required String url,
  }) {
    return userService.updateProfileImageUrl(
      email: email,
      url: url,
    );
  }

  @override
  Future<bool> updateProfileInfo({
    required String name,
    required String bio,
    required String gender,
    required String phone,
  }) async {
    return await userService.updateUserProfileInfo(
      name: name,
      bio: bio,
      gender: gender,
      phone: phone,
    );
  }
}
