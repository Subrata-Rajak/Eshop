abstract class UpdatePasswordScreenStates {}

class UpdatePasswordInitialState extends UpdatePasswordScreenStates {}

class UpdatingPasswordState extends UpdatePasswordScreenStates {}

class UpdatingPasswordSuccessState extends UpdatePasswordScreenStates {}

class UpdatingPasswordErrorState extends UpdatePasswordScreenStates {}

class UpdatePasswordScreenPasswordFieldState
    extends UpdatePasswordScreenStates {
  final bool isPasswordObscure;

  UpdatePasswordScreenPasswordFieldState({required this.isPasswordObscure});
}

class UpdatePasswordScreenConfirmPasswordFieldState
    extends UpdatePasswordScreenStates {
  final bool isConfirmPasswordObscure;

  UpdatePasswordScreenConfirmPasswordFieldState(
      {required this.isConfirmPasswordObscure});
}

class UpdatePasswordScreenCurrentPasswordFieldState
    extends UpdatePasswordScreenStates {
  final bool isCurrentPasswordObscure;

  UpdatePasswordScreenCurrentPasswordFieldState(
      {required this.isCurrentPasswordObscure});
}
