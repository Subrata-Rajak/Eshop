abstract class UpdatePasswordScreenEvents {}

class UpdatePasswordEvent extends UpdatePasswordScreenEvents {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final String email;

  UpdatePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.email,
  });
}

class TogglePasswordObscureEvent extends UpdatePasswordScreenEvents {}

class ToggleConfirmPasswordObscureEvent extends UpdatePasswordScreenEvents {}

class ToggleCurrentPasswordObscureEvent extends UpdatePasswordScreenEvents {}
