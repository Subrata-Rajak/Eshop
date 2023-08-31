import 'dart:async';

import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(LoginInitialState()) {
    on<TogglePasswordObscureEvent>(togglePasswordObscure);
    on<ToggleCheckEvent>(toggleCheck);
  }

  FutureOr<void> togglePasswordObscure(
    TogglePasswordObscureEvent event,
    Emitter<LoginStates> emit,
  ) {
    if (state is LoginInitialState) {
      emit(LoginPasswordFieldState(isObscure: false));
    } else {
      final currentState = state as LoginPasswordFieldState;
      emit(LoginPasswordFieldState(isObscure: !currentState.isObscure));
    }
  }

  FutureOr<void> toggleCheck(
    ToggleCheckEvent event,
    Emitter<LoginStates> emit,
  ) {
    if (state is LoginInitialState) {
      emit(LoginCheckState(isChecked: true));
    } else {
      final currentState = state as LoginCheckState;
      emit(LoginCheckState(isChecked: !currentState.isChecked));
    }
  }
}
