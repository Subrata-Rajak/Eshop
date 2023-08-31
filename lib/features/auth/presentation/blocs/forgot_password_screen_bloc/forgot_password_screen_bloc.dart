import 'dart:async';

import 'package:eshop/features/auth/presentation/blocs/forgot_password_screen_bloc/forgot_password_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/forgot_password_screen_bloc/forgot_password_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvents, ForgotPasswordStates> {
  ForgotPasswordBloc() : super(ForgotPasswordInitialState()) {
    on<TogglePasswordObscureEvent>(togglePasswordObscure);
    on<ToggleConfirmPasswordObscureEvent>(toggleConfirmPasswordObscure);
  }

  FutureOr<void> togglePasswordObscure(
    TogglePasswordObscureEvent event,
    Emitter<ForgotPasswordStates> emit,
  ) {
    if (state is ForgotPasswordInitialState) {
      emit(ForgotPasswordScreenPasswordFieldState(isPasswordObscure: false));
    } else {
      final currentState = state as ForgotPasswordScreenPasswordFieldState;
      emit(
        ForgotPasswordScreenPasswordFieldState(
          isPasswordObscure: !currentState.isPasswordObscure,
        ),
      );
    }
  }

  FutureOr<void> toggleConfirmPasswordObscure(
    ToggleConfirmPasswordObscureEvent event,
    Emitter<ForgotPasswordStates> emit,
  ) {
    if (state is ForgotPasswordInitialState) {
      emit(ForgotPasswordScreenConfirmPasswordFieldState(
          isConfirmPasswordObscure: false));
    } else {
      final currentState =
          state as ForgotPasswordScreenConfirmPasswordFieldState;
      emit(
        ForgotPasswordScreenConfirmPasswordFieldState(
          isConfirmPasswordObscure: !currentState.isConfirmPasswordObscure,
        ),
      );
    }
  }
}
