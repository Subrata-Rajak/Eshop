import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';

class ResendOtpUsecase {
  final AuthRepository authRepository;

  ResendOtpUsecase({required this.authRepository});

  Future<bool> resendOtp({required String email}) {
    return authRepository.resendOtp(email: email);
  }
}
