import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/auth/presentation/blocs/otp_verification_screen_bloc/otp_verification_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/otp_verification_screen_bloc/otp_verification_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/otp_verification_screen_bloc/otp_verification_screen_states.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';

// ignore: must_be_immutable
class OtpVerificationScreen extends StatefulWidget {
  OtpVerificationScreenArgs args;
  OtpVerificationScreen({
    super.key,
    required this.args,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with CommonWidgets {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();

  @override
  void dispose() {
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(height: 20),
                buildLogo(),
                verticalSpace(height: 40),
                buildHeader(),
                verticalSpace(height: 50),
                buildOtpTextField(size),
                verticalSpace(height: 10),
                buildResendOtpButton(context),
                verticalSpace(height: 20),
                buildExpandedButton(
                  size: size,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildResendOtpButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Didn't receive an otp?",
              style: TextStyle(
                color: AppColors.colors.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocProvider<OtpVerificationBloc>(
              create: (context) => sl(),
              child:
                  BlocBuilder<OtpVerificationBloc, OtpVerificationScreenStates>(
                builder: (context, state) {
                  if (state is ResendingOtpState) {
                    return TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateColor.resolveWith(
                          (states) {
                            return AppColors.colors.orange.withOpacity(0.1);
                          },
                        ),
                      ),
                      onPressed: null,
                      child: CircularProgressIndicator(
                        color: AppColors.colors.orange,
                      ),
                    );
                  }
                  return TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) {
                          return AppColors.colors.orange.withOpacity(0.1);
                        },
                      ),
                    ),
                    onPressed: () {
                      context
                          .read<OtpVerificationBloc>()
                          .add(ResendOtpEvent(email: widget.args.email));
                    },
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color: AppColors.colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }

  buildExpandedButton({required Size size}) {
    return BlocProvider<OtpVerificationBloc>(
      create: (context) => sl(),
      child: BlocConsumer<OtpVerificationBloc, OtpVerificationScreenStates>(
        listener: (context, state) {
          if (state is OtpVerificationSuccessState) {
            context.replace(
              AppRoutePaths.paths.updatePasswordPath,
              extra: UpdatePasswordScreenArgs(email: widget.args.email),
            );
          }
        },
        builder: (context, state) {
          if (state is OtpVerificationInitialState ||
              state is OtpVerificationErrorState) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: AppColors.colors.darkBlue,
                ),
                onPressed: () {
                  context.read<OtpVerificationBloc>().add(
                        VerifyOtpEvent(
                          otp1: otpController1.text,
                          otp2: otpController2.text,
                          otp3: otpController3.text,
                          otp4: otpController4.text,
                          email: widget.args.email,
                        ),
                      );
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          } else if (state is OtpVerifyingState) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: AppColors.colors.darkBlue,
                  disabledBackgroundColor: AppColors.colors.darkBlue,
                ),
                onPressed: null,
                child: CircularProgressIndicator(
                  color: AppColors.colors.white,
                ),
              ),
            );
          }

          return emptyBox();
        },
      ),
    );
  }

  buildOtpTextField(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 68,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: otpController1,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 68,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            keyboardType: TextInputType.number,
            controller: otpController2,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 68,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            keyboardType: TextInputType.number,
            controller: otpController3,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 68,
          child: TextFormField(
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            controller: otpController4,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter the otp!",
          style: TextStyle(
            color: AppColors.colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        verticalSpace(height: 10),
        Text(
          "Hey there!",
          style: TextStyle(
            color: AppColors.colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Row buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.colors.darkBlue,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Center(
                child: Text(
                  "E",
                  style: TextStyle(
                    color: AppColors.colors.orange,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            horizontalSpace(width: 10),
            Text(
              "Shop",
              style: TextStyle(
                color: AppColors.colors.darkBlue,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
