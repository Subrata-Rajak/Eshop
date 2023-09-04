import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtpUsecase {
  final AuthRepository authRepository;

  VerifyOtpUsecase({required this.authRepository});

  Future<bool> verifyOtp({
    required String email,
    required String otp,
  }) {
    return authRepository.verifyOtp(
      email: email,
      otp: otp,
    );
  }
}
