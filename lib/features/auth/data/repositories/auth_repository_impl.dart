import 'package:eshop/features/auth/data/data_source/remote/auth_service.dart';
import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    return await authService.loginUser(
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return await authService.registerUser(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<bool> resendOtp({required String email}) async {
    return await authService.resendOtp(email: email);
  }

  @override
  Future<bool> sendOtp({required String email}) async {
    return await authService.sendOtp(email: email);
  }

  @override
  Future<bool> updatePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    return await authService.updatePassword(
      email: email,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<bool> verifyOtp({
    required String email,
    required String otp,
  }) async {
    return await authService.verifyOtp(otp: otp, email: email);
  }
}
