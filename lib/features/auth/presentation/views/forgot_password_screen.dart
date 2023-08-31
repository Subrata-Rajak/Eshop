import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/auth/presentation/blocs/forgot_password_screen_bloc/forgot_password_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/forgot_password_screen_bloc/forgot_password_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/values/colors.dart';
import '../blocs/forgot_password_screen_bloc/forgot_password_screen_events.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with CommonWidgets {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                buildPasswordTextField(),
                verticalSpace(height: 20),
                buildConfirmPasswordTextField(),
                verticalSpace(height: 50),
                expandedButton(
                  size: size,
                  fun: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocProvider<ForgotPasswordBloc> buildPasswordTextField() {
    return BlocProvider<ForgotPasswordBloc>(
      create: (context) => ForgotPasswordBloc(),
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordStates>(
        builder: (context, state) {
          if (state is ForgotPasswordInitialState) {
            return TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(TogglePasswordObscureEvent());
                  },
                  child: Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: true,
            );
          } else if (state is ForgotPasswordScreenPasswordFieldState) {
            return TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(TogglePasswordObscureEvent());
                  },
                  child: Icon(
                    state.isPasswordObscure
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: state.isPasswordObscure,
            );
          }

          return emptyBox();
        },
      ),
    );
  }

  BlocProvider<ForgotPasswordBloc> buildConfirmPasswordTextField() {
    return BlocProvider<ForgotPasswordBloc>(
      create: (context) => ForgotPasswordBloc(),
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordStates>(
        builder: (context, state) {
          if (state is ForgotPasswordInitialState) {
            return TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Confirm Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(ToggleConfirmPasswordObscureEvent());
                  },
                  child: Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: true,
            );
          } else if (state is ForgotPasswordScreenConfirmPasswordFieldState) {
            return TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Confirm Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<ForgotPasswordBloc>()
                        .add(ToggleConfirmPasswordObscureEvent());
                  },
                  child: Icon(
                    state.isConfirmPasswordObscure
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: state.isConfirmPasswordObscure,
            );
          }

          return emptyBox();
        },
      ),
    );
  }

  Column buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Change Your Password!",
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
