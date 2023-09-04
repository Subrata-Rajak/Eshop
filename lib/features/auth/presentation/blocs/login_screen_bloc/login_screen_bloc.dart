import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:eshop/features/auth/domain/usecases/login_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final LoginUsecase loginUsecase;
  LoginBloc({required this.loginUsecase}) : super(LoginInitialState()) {
    on<TogglePasswordObscureEvent>(togglePasswordObscure);
    on<ToggleCheckEvent>(toggleCheck);
    on<LoginUserEvent>(loginUser);
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

  FutureOr<void> loginUser(
    LoginUserEvent event,
    Emitter<LoginStates> emit,
  ) async {
    emit(LoggingInState());
    final email = event.email;
    final password = event.password;

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        if (EmailValidator.validate(email)) {
          var res = await loginUsecase.loginUser(
            email: email,
            password: password,
          );

          if (res) {
            emit(LoginSuccessState());
          } else {
            emit(LoginErrorState());
          }
        } else {
          emit(LoginErrorState());
        }
      } else {
        emit(LoginErrorState());
      }
    } catch (error) {
      print("Error while Logging in user: $error");
      emit(LoginErrorState());
    }
  }
}
