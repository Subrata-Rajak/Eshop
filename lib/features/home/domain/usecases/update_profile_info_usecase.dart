import 'package:eshop/features/home/domain/repository/user_repository.dart';

class UpdateProfileInfoUsecase {
  final UserRepoSitory userRepoSitory;

  UpdateProfileInfoUsecase({required this.userRepoSitory});

  Future<bool> updateProfileInfo({
    required String name,
    required String bio,
    required String gender,
    required String phone,
  }) async {
    return await userRepoSitory.updateProfileInfo(
      name: name,
      bio: bio,
      gender: gender,
      phone: phone,
    );
  }
}
