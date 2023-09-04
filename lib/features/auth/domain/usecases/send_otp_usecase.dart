import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';

class SendOtpUsecase {
  final AuthRepository authRepository;

  SendOtpUsecase({required this.authRepository});

  Future<bool> sendOtp({required String email}) {
    return authRepository.sendOtp(email: email);
  }
}
