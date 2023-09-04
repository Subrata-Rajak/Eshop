import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});

  Future<bool> loginUser({
    required String email,
    required String password,
  }) {
    return authRepository.loginUser(
      email: email,
      password: password,
    );
  }
}
