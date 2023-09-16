import 'package:eshop/features/home/domain/repository/user_repository.dart';

import '../entity/user_entity.dart';

class GetUserInfoUsecase {
  final UserRepoSitory userRepoSitory;

  GetUserInfoUsecase({required this.userRepoSitory});

  Future<UserEntity?> getUserInfo() {
    return userRepoSitory.getUserInfo();
  }
}
