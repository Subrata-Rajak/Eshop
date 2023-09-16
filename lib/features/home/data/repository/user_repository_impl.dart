import 'package:eshop/features/home/data/data_source/remote/user_service.dart';
import 'package:eshop/features/home/domain/repository/user_repository.dart';

import '../../domain/entity/user_entity.dart';

class UserRepositoryImpl implements UserRepoSitory {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<bool> addAddress({
    required String email,
    required String country,
    required String state,
    required String city,
    required String landmark,
    required String pincode,
    required String area,
  }) {
    return userService.addAddress(
      email: email,
      country: country,
      state: state,
      city: city,
      landmark: landmark,
      pincode: pincode,
      area: area,
    );
  }

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
}
