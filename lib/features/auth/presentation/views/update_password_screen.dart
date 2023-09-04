import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/auth/presentation/blocs/update_password_screen_bloc/update_password_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/update_password_screen_bloc/update_password_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/update_password_screen_bloc/update_password_screen_states.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';

class UpdatePasswordScreen extends StatefulWidget {
  final UpdatePasswordScreenArgs args;
  const UpdatePasswordScreen({
    super.key,
    required this.args,
  });

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen>
    with CommonWidgets {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController currentPasswordController =
      TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    currentPasswordController.dispose();
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
                buildCurrentPasswordTextField(),
                verticalSpace(height: 20),
                buildPasswordTextField(),
                verticalSpace(height: 20),
                buildConfirmPasswordTextField(),
                verticalSpace(height: 50),
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

  buildExpandedButton({required Size size}) {
    return BlocProvider<UpdatePasswordScreenBloc>(
      create: (context) => sl(),
      child: BlocConsumer<UpdatePasswordScreenBloc, UpdatePasswordScreenStates>(
        listener: (context, state) {
          if (state is UpdatingPasswordSuccessState) {
            context.replace(AppRoutePaths.paths.loginPath);
          }
        },
        builder: (context, state) {
          if (state is UpdatePasswordInitialState ||
              state is UpdatingPasswordErrorState) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: AppColors.colors.darkBlue,
                ),
                onPressed: () {
                  context.read<UpdatePasswordScreenBloc>().add(
                        UpdatePasswordEvent(
                          currentPassword: currentPasswordController.text,
                          newPassword: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
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
          } else if (state is UpdatingPasswordState) {
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

  BlocProvider<UpdatePasswordScreenBloc> buildPasswordTextField() {
    return BlocProvider<UpdatePasswordScreenBloc>(
      create: (context) => sl(),
      child: BlocBuilder<UpdatePasswordScreenBloc, UpdatePasswordScreenStates>(
        builder: (context, state) {
          if (state is UpdatePasswordInitialState) {
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
                        .read<UpdatePasswordScreenBloc>()
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
          } else if (state is UpdatePasswordScreenPasswordFieldState) {
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
                        .read<UpdatePasswordScreenBloc>()
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

  BlocProvider<UpdatePasswordScreenBloc> buildConfirmPasswordTextField() {
    return BlocProvider<UpdatePasswordScreenBloc>(
      create: (context) => sl(),
      child: BlocBuilder<UpdatePasswordScreenBloc, UpdatePasswordScreenStates>(
        builder: (context, state) {
          if (state is UpdatePasswordInitialState) {
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
                        .read<UpdatePasswordScreenBloc>()
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
          } else if (state is UpdatePasswordScreenConfirmPasswordFieldState) {
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
                        .read<UpdatePasswordScreenBloc>()
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

  BlocProvider<UpdatePasswordScreenBloc> buildCurrentPasswordTextField() {
    return BlocProvider<UpdatePasswordScreenBloc>(
      create: (context) => sl(),
      child: BlocBuilder<UpdatePasswordScreenBloc, UpdatePasswordScreenStates>(
        builder: (context, state) {
          if (state is UpdatePasswordInitialState) {
            return TextFormField(
              controller: currentPasswordController,
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
                label: const Text("Current Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<UpdatePasswordScreenBloc>()
                        .add(ToggleCurrentPasswordObscureEvent());
                  },
                  child: Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: true,
            );
          } else if (state is UpdatePasswordScreenCurrentPasswordFieldState) {
            return TextFormField(
              controller: currentPasswordController,
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
                label: const Text("Current Password"),
                hintText: "John@123",
                suffix: GestureDetector(
                  onTap: () {
                    context
                        .read<UpdatePasswordScreenBloc>()
                        .add(ToggleConfirmPasswordObscureEvent());
                  },
                  child: Icon(
                    state.isCurrentPasswordObscure
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: state.isCurrentPasswordObscure,
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
