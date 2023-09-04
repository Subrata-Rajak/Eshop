abstract class OtpVerificationScreenEvents {}

class VerifyOtpEvent extends OtpVerificationScreenEvents {
  final String otp1;
  final String otp2;
  final String otp3;
  final String otp4;
  final String email;

  VerifyOtpEvent({
    required this.otp1,
    required this.otp2,
    required this.otp3,
    required this.otp4,
    required this.email,
  });
}

class ResendOtpEvent extends OtpVerificationScreenEvents {
  final String email;

  ResendOtpEvent({required this.email});
}
