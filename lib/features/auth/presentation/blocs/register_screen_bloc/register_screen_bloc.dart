import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:eshop/features/auth/domain/usecases/register_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/register_screen_bloc/register_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/register_screen_bloc/register_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  final RegisterUsecase registerUsecase;
  RegisterBloc({required this.registerUsecase})
      : super(RegisterInitialState()) {
    on<TogglePasswordObscureEvent>(togglePasswordObscure);
    on<ToggleConfirmPasswordObscureEvent>(toggleConfirmPasswordObscure);
    on<ToggleCheckEvent>(toggleCheck);
    on<RegisteringUserEvent>(registeringUser);
  }

  FutureOr<void> togglePasswordObscure(
    TogglePasswordObscureEvent event,
    Emitter<RegisterStates> emit,
  ) {
    if (state is RegisterInitialState) {
      emit(RegisterPasswordFieldState(isPasswordObscure: false));
    } else {
      final currentState = state as RegisterPasswordFieldState;
      emit(
        RegisterPasswordFieldState(
            isPasswordObscure: !currentState.isPasswordObscure),
      );
    }
  }

  FutureOr<void> toggleCheck(
    ToggleCheckEvent event,
    Emitter<RegisterStates> emit,
  ) {
    if (state is RegisterInitialState) {
      emit(RegisterCheckState(isChecked: true));
    } else {
      final currentState = state as RegisterCheckState;
      emit(RegisterCheckState(isChecked: !currentState.isChecked));
    }
  }

  FutureOr<void> toggleConfirmPasswordObscure(
    ToggleConfirmPasswordObscureEvent event,
    Emitter<RegisterStates> emit,
  ) {
    if (state is RegisterInitialState) {
      emit(RegisterConfirmPasswordFieldState(isConfirmPasswordObscure: false));
    } else {
      final currentState = state as RegisterConfirmPasswordFieldState;
      emit(
        RegisterConfirmPasswordFieldState(
            isConfirmPasswordObscure: !currentState.isConfirmPasswordObscure),
      );
    }
  }

  FutureOr<void> registeringUser(
    RegisteringUserEvent event,
    Emitter<RegisterStates> emit,
  ) async {
    emit(RegisteringUserState());
    final name = event.name;
    final email = event.email;
    final password = event.password;
    final confirmPassword = event.confirmPassword;

    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty) {
        if (EmailValidator.validate(email) &&
            (password == confirmPassword) &&
            password.length >= 6) {
          var res = await registerUsecase.registerUser(
            email: email,
            name: name,
            password: password,
          );

          if (res) {
            emit(RegisterSuccessState());
          } else {
            emit(RegisterErrorState());
          }
        } else {
          emit(RegisterErrorState());
        }
      } else {
        emit(RegisterErrorState());
      }
    } catch (error) {
      print("Error while registering user: $error");
      emit(RegisterErrorState());
    }
  }
}
