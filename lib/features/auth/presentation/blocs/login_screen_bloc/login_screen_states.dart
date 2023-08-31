abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginPasswordFieldState extends LoginStates {
  final bool isObscure;

  LoginPasswordFieldState({required this.isObscure});
}

class LoginCheckState extends LoginStates {
  final bool isChecked;

  LoginCheckState({required this.isChecked});
}
