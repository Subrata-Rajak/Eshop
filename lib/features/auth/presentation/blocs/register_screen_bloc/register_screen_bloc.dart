import 'dart:async';

import 'package:eshop/features/auth/presentation/blocs/register_screen_bloc/register_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/register_screen_bloc/register_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(RegisterInitialState()) {
    on<TogglePasswordObscureEvent>(togglePasswordObscure);
    on<ToggleConfirmPasswordObscureEvent>(toggleConfirmPasswordObscure);
    on<ToggleCheckEvent>(toggleCheck);
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
}
