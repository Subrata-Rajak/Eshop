abstract class LoginEvents {}

class TogglePasswordObscureEvent extends LoginEvents {}

class ToggleCheckEvent extends LoginEvents {}

class LoginUserEvent extends LoginEvents {
  final String email;
  final String password;

  LoginUserEvent({
    required this.email,
    required this.password,
  });
}
