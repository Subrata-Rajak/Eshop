abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterPasswordFieldState extends RegisterStates {
  final bool isPasswordObscure;

  RegisterPasswordFieldState({required this.isPasswordObscure});
}

class RegisterConfirmPasswordFieldState extends RegisterStates {
  final bool isConfirmPasswordObscure;

  RegisterConfirmPasswordFieldState({required this.isConfirmPasswordObscure});
}

class RegisterCheckState extends RegisterStates {
  final bool isChecked;

  RegisterCheckState({required this.isChecked});
}
