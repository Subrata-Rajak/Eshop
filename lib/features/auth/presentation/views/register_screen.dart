import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/route_paths.dart';
import '../../../../core/values/colors.dart';
import '../blocs/register_screen_bloc/register_screen_bloc.dart';
import '../blocs/register_screen_bloc/register_screen_states.dart';
import '../blocs/register_screen_bloc/register_screen_events.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with CommonWidgets {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                buildUsernameTextField(),
                verticalSpace(height: 20),
                buildEmailTextField(),
                verticalSpace(height: 20),
                buildPasswordTextField(),
                verticalSpace(height: 20),
                buildConfirmPasswordTextField(),
                buildTAndCCheck(),
                verticalSpace(height: 50),
                buildExpandedButton(size: size),
                buildLoginNavButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocProvider<RegisterBloc> buildExpandedButton({required Size size}) {
    return BlocProvider<RegisterBloc>(
      create: (context) => sl(),
      child: BlocConsumer<RegisterBloc, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            context.replace(AppRoutePaths.paths.loginPath);
          }
        },
        builder: (context, state) {
          if (state is RegisterInitialState || state is RegisterErrorState) {
            return SizedBox(
              width: size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: AppColors.colors.darkBlue,
                ),
                onPressed: () {
                  context.read<RegisterBloc>().add(
                        RegisteringUserEvent(
                          name: usernameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          confirmPassword: confirmPasswordController.text,
                        ),
                      );
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          } else if (state is RegisteringUserState) {
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

  Row buildLoginNavButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Already have an account?",
              style: TextStyle(
                color: AppColors.colors.darkBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) {
                    return AppColors.colors.orange.withOpacity(0.1);
                  },
                ),
              ),
              onPressed: () => context.replace(AppRoutePaths.paths.loginPath),
              child: Text(
                "Login",
                style: TextStyle(
                  color: AppColors.colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildTAndCCheck() {
    return Row(
      children: [
        BlocProvider<RegisterBloc>(
          create: (context) => sl(),
          child: BlocBuilder<RegisterBloc, RegisterStates>(
            builder: (context, state) {
              if (state is RegisterInitialState) {
                return Checkbox(
                  value: false,
                  onChanged: (val) =>
                      context.read<RegisterBloc>().add(ToggleCheckEvent()),
                  fillColor: MaterialStateColor.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.colors.darkBlue;
                      }
                      return AppColors.colors.grey;
                    },
                  ),
                  checkColor: AppColors.colors.orange,
                );
              } else if (state is RegisterCheckState) {
                return Checkbox(
                  value: state.isChecked,
                  onChanged: (val) =>
                      context.read<RegisterBloc>().add(ToggleCheckEvent()),
                  fillColor: MaterialStateColor.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppColors.colors.darkBlue;
                      }
                      return AppColors.colors.grey;
                    },
                  ),
                  checkColor: AppColors.colors.orange,
                );
              }
              return emptyBox();
            },
          ),
        ),
        Text(
          "Terms & Conditions",
          style: TextStyle(
            color: AppColors.colors.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  BlocProvider<RegisterBloc> buildPasswordTextField() {
    return BlocProvider<RegisterBloc>(
      create: (context) => sl(),
      child: BlocBuilder<RegisterBloc, RegisterStates>(
        builder: (context, state) {
          if (state is RegisterInitialState) {
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
                        .read<RegisterBloc>()
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
          } else if (state is RegisterPasswordFieldState) {
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
                        .read<RegisterBloc>()
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
          } else if (state is RegisteringUserState) {
            return TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Password"),
                hintText: "John@123",
                suffix: Icon(
                  FontAwesomeIcons.eyeSlash,
                  color: AppColors.colors.black,
                ),
              ),
              enabled: false,
              obscureText: true,
            );
          }

          return emptyBox();
        },
      ),
    );
  }

  BlocProvider<RegisterBloc> buildConfirmPasswordTextField() {
    return BlocProvider<RegisterBloc>(
      create: (context) => sl(),
      child: BlocBuilder<RegisterBloc, RegisterStates>(
        builder: (context, state) {
          if (state is RegisterInitialState) {
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
                        .read<RegisterBloc>()
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
          } else if (state is RegisterConfirmPasswordFieldState) {
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
                        .read<RegisterBloc>()
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
          } else if (state is RegisteringUserState) {
            return TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                enabled: false,
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: const Text("Confirm Password"),
                hintText: "John@123",
                suffix: Icon(
                  FontAwesomeIcons.eyeSlash,
                  color: AppColors.colors.black,
                ),
              ),
              obscureText: true,
            );
          }

          return emptyBox();
        },
      ),
    );
  }

  buildEmailTextField() {
    return BlocProvider<RegisterBloc>(
      create: (context) => sl(),
      child: BlocBuilder<RegisterBloc, RegisterStates>(
        builder: (context, state) {
          if (state is RegisterInitialState) {
            return TextFormField(
              controller: emailController,
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
                label: Text("Email"),
                hintText: "john@gmail.com",
              ),
            );
          } else if (state is RegisteringUserState) {
            return TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                enabled: false,
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                label: Text("Email"),
                hintText: "john@gmail.com",
              ),
            );
          }
          return emptyBox();
        },
      ),
    );
  }

  BlocProvider<RegisterBloc> buildUsernameTextField() {
    return BlocProvider<RegisterBloc>(
      create: (context) => sl(),
      child: BlocBuilder<RegisterBloc, RegisterStates>(
        builder: (context, state) {
          if (state is RegisterInitialState) {
            return TextFormField(
              controller: usernameController,
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
                label: Text("Username"),
                hintText: "john",
              ),
            );
          } else if (state is RegisteringUserState) {
            return TextFormField(
              controller: usernameController,
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
                label: Text("Username"),
                hintText: "john",
              ),
              enabled: false,
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
          "Welcome to EShop!👋",
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
