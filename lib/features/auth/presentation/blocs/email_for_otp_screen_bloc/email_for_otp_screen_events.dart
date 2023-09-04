abstract class EmailForOtpScreenEvents {}

class SendOtpEvent extends EmailForOtpScreenEvents {
  final String email;

  SendOtpEvent({required this.email});
}
