abstract class AuthRepository {
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  });
  Future<bool> loginUser({
    required String email,
    required String password,
  });
  Future<bool> sendOtp({required String email});
  Future<bool> verifyOtp({
    required String email,
    required String otp,
  });
  Future<bool> resendOtp({required String email});
  Future<bool> updatePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  });
}
