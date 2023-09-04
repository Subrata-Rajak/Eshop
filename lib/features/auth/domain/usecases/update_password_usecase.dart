import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';

class UpdatePasswordUsecase {
  final AuthRepository authRepository;

  UpdatePasswordUsecase({required this.authRepository});

  Future<bool> updatePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) {
    return authRepository.updatePassword(
      email: email,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
