import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:eshop/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/otp_verification_screen_bloc/otp_verification_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/otp_verification_screen_bloc/otp_verification_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpVerificationBloc
    extends Bloc<OtpVerificationScreenEvents, OtpVerificationScreenStates> {
  final VerifyOtpUsecase verifyOtpUsecase;
  final ResendOtpUsecase resendOtpUsecase;
  OtpVerificationBloc({
    required this.verifyOtpUsecase,
    required this.resendOtpUsecase,
  }) : super(OtpVerificationInitialState()) {
    on<VerifyOtpEvent>(verifyOtp);
    on<ResendOtpEvent>(resendOtp);
  }

  FutureOr<void> verifyOtp(
    VerifyOtpEvent event,
    Emitter<OtpVerificationScreenStates> emit,
  ) async {
    emit(OtpVerifyingState());
    final email = event.email;
    final otp1 = event.otp1;
    final otp2 = event.otp2;
    final otp3 = event.otp3;
    final otp4 = event.otp4;

    try {
      if (email.isNotEmpty &&
          otp1.isNotEmpty &&
          otp2.isNotEmpty &&
          otp3.isNotEmpty &&
          otp4.isNotEmpty) {
        if (EmailValidator.validate(email)) {
          final otp = otp1 + otp2 + otp3 + otp4;
          print(otp);
          var res = await verifyOtpUsecase.verifyOtp(
            email: email,
            otp: otp,
          );

          if (res) {
            emit(OtpVerificationSuccessState());
          } else {
            emit(OtpVerificationErrorState());
          }
        } else {
          emit(OtpVerificationErrorState());
        }
      } else {
        emit(OtpVerificationErrorState());
      }
    } catch (error) {
      print("Error while verifying Otp");
      emit(OtpVerificationErrorState());
    }
  }

  FutureOr<void> resendOtp(
    ResendOtpEvent event,
    Emitter<OtpVerificationScreenStates> emit,
  ) async {
    emit(ResendingOtpState());
    final email = event.email;

    try {
      if (email.isNotEmpty) {
        if (EmailValidator.validate(email)) {
          var res = await resendOtpUsecase.resendOtp(email: email);

          if (res) {
            emit(ResendingOtpSuccessState());
          } else {
            emit(ResendingOtpErrorState());
          }
        } else {
          emit(ResendingOtpErrorState());
        }
      } else {
        emit(ResendingOtpErrorState());
      }
    } catch (error) {
      print("Error while Resending Otp");
      emit(ResendingOtpErrorState());
    }
  }
}
