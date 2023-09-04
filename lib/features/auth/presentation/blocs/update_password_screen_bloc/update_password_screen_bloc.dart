import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:eshop/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/update_password_screen_bloc/update_password_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'update_password_screen_events.dart';

class UpdatePasswordScreenBloc
    extends Bloc<UpdatePasswordScreenEvents, UpdatePasswordScreenStates> {
  final UpdatePasswordUsecase updatePasswordUsecase;
  UpdatePasswordScreenBloc({required this.updatePasswordUsecase})
      : super(UpdatePasswordInitialState()) {
    on<UpdatePasswordEvent>(updatePassword);
    on<TogglePasswordObscureEvent>(togglePasswordObscure);
    on<ToggleConfirmPasswordObscureEvent>(toggleConfirmPasswordObscure);
    on<ToggleCurrentPasswordObscureEvent>(toggleCurrentPasswordObscure);
  }

  FutureOr<void> updatePassword(
    UpdatePasswordEvent event,
    Emitter<UpdatePasswordScreenStates> emit,
  ) async {
    emit(UpdatingPasswordState());
    final currentPassword = event.currentPassword;
    final confirmPassword = event.confirmPassword;
    final newPassword = event.newPassword;
    final email = event.email;

    try {
      if (currentPassword.isNotEmpty &&
          newPassword.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          email.isNotEmpty) {
        if (EmailValidator.validate(email) &&
            newPassword.length >= 6 &&
            (newPassword == currentPassword)) {
          var res = await updatePasswordUsecase.updatePassword(
            email: email,
            currentPassword: currentPassword,
            newPassword: newPassword,
          );

          if (res) {
            emit(UpdatingPasswordSuccessState());
          } else {
            emit(UpdatingPasswordErrorState());
          }
        } else {
          emit(UpdatingPasswordErrorState());
        }
      } else {
        emit(UpdatingPasswordErrorState());
      }
    } catch (error) {
      print("Error while updating password: $error");
      emit(UpdatingPasswordErrorState());
    }
  }

  FutureOr<void> togglePasswordObscure(
    TogglePasswordObscureEvent event,
    Emitter<UpdatePasswordScreenStates> emit,
  ) {
    if (state is UpdatePasswordInitialState) {
      emit(UpdatePasswordScreenPasswordFieldState(isPasswordObscure: false));
    } else {
      final currentState = state as UpdatePasswordScreenPasswordFieldState;
      emit(UpdatePasswordScreenPasswordFieldState(
          isPasswordObscure: !currentState.isPasswordObscure));
    }
  }

  FutureOr<void> toggleConfirmPasswordObscure(
    ToggleConfirmPasswordObscureEvent event,
    Emitter<UpdatePasswordScreenStates> emit,
  ) {
    if (state is UpdatePasswordInitialState) {
      emit(UpdatePasswordScreenConfirmPasswordFieldState(
          isConfirmPasswordObscure: false));
    } else {
      final currentState =
          state as UpdatePasswordScreenConfirmPasswordFieldState;
      emit(UpdatePasswordScreenConfirmPasswordFieldState(
          isConfirmPasswordObscure: !currentState.isConfirmPasswordObscure));
    }
  }

  FutureOr<void> toggleCurrentPasswordObscure(
    ToggleCurrentPasswordObscureEvent event,
    Emitter<UpdatePasswordScreenStates> emit,
  ) {
    if (state is UpdatePasswordInitialState) {
      emit(UpdatePasswordScreenCurrentPasswordFieldState(
          isCurrentPasswordObscure: false));
    } else {
      final currentState =
          state as UpdatePasswordScreenCurrentPasswordFieldState;
      emit(UpdatePasswordScreenCurrentPasswordFieldState(
          isCurrentPasswordObscure: !currentState.isCurrentPasswordObscure));
    }
  }
}
