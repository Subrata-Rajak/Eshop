import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;

  RegisterUsecase({required this.authRepository});

  Future<bool> registerUser({
    required String email,
    required String name,
    required String password,
  }) async {
    return await authRepository.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }
}
