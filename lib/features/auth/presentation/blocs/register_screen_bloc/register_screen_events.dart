abstract class RegisterEvents {}

class TogglePasswordObscureEvent extends RegisterEvents {}

class ToggleConfirmPasswordObscureEvent extends RegisterEvents {}

class ToggleCheckEvent extends RegisterEvents {}

class RegisteringUserEvent extends RegisterEvents {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegisteringUserEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
