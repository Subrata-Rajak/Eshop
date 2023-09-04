import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:eshop/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/email_for_otp_screen_bloc/email_for_otp_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/email_for_otp_screen_bloc/email_for_otp_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailForOtpScreenBloc
    extends Bloc<EmailForOtpScreenEvents, EmailForOtpScreenStates> {
  final SendOtpUsecase sendOtpUsecase;
  EmailForOtpScreenBloc({required this.sendOtpUsecase})
      : super(SendOtpInitialState()) {
    on<SendOtpEvent>(sendOtp);
  }

  FutureOr<void> sendOtp(
    SendOtpEvent event,
    Emitter<EmailForOtpScreenStates> emit,
  ) async {
    emit(SendingOtpState());
    final email = event.email;

    try {
      if (email.isNotEmpty && EmailValidator.validate(email)) {
        var res = await sendOtpUsecase.sendOtp(email: email);
        if (res) {
          emit(SendingOtpSuccessState());
        } else {
          emit(SendingOtpErrorState());
        }
      } else {
        emit(SendingOtpErrorState());
      }
    } catch (error) {
      print("Error while sending otp: $error");
      emit(SendingOtpErrorState());
    }
  }
}
