abstract class ForgotPasswordStates {}

class ForgotPasswordInitialState extends ForgotPasswordStates {}

class ForgotPasswordScreenPasswordFieldState extends ForgotPasswordStates {
  final bool isPasswordObscure;

  ForgotPasswordScreenPasswordFieldState({required this.isPasswordObscure});
}

class ForgotPasswordScreenConfirmPasswordFieldState
    extends ForgotPasswordStates {
  final bool isConfirmPasswordObscure;

  ForgotPasswordScreenConfirmPasswordFieldState(
      {required this.isConfirmPasswordObscure});
}
