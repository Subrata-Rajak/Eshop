import 'package:eshop/features/home/domain/repository/user_repository.dart';

class UpdateProfileImageUrlUsecase {
  final UserRepoSitory userRepoSitory;

  UpdateProfileImageUrlUsecase({required this.userRepoSitory});

  Future<bool> updateUserProfileImageUrl(
      {required String email, required String url}) {
    return userRepoSitory.updateProfileImageUrl(
      email: email,
      url: url,
    );
  }
}
