import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with CommonWidgets {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
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
                buildEmailTextField(),
                verticalSpace(height: 20),
                buildPasswordTextField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildRememberMeCheck(),
                    buildForgotPasswordButton(context),
                  ],
                ),
                verticalSpace(height: 50),
                expandedButton(
                  size: size,
                  fun: () {},
                ),
                buildRegisterNavButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildRegisterNavButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Don't have an account?",
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
              onPressed: () =>
                  context.replace(AppRoutePaths.paths.registerPath),
              child: Text(
                "Register",
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

  TextButton buildForgotPasswordButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
          (states) {
            return AppColors.colors.red.withOpacity(0.1);
          },
        ),
      ),
      onPressed: () => context.push(AppRoutePaths.paths.forgotPasswordPath),
      child: Text(
        "Forgot Password?",
        style: TextStyle(color: AppColors.colors.red),
      ),
    );
  }

  Row buildRememberMeCheck() {
    return Row(
      children: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
          child: BlocBuilder<LoginBloc, LoginStates>(
            builder: (context, state) {
              if (state is LoginInitialState) {
                return Checkbox(
                  value: false,
                  onChanged: (val) =>
                      context.read<LoginBloc>().add(ToggleCheckEvent()),
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
              } else if (state is LoginCheckState) {
                return Checkbox(
                  value: state.isChecked,
                  onChanged: (val) =>
                      context.read<LoginBloc>().add(ToggleCheckEvent()),
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
          "Remember me",
          style: TextStyle(
            color: AppColors.colors.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  BlocProvider<LoginBloc> buildPasswordTextField() {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocBuilder<LoginBloc, LoginStates>(
        builder: (context, state) {
          if (state is LoginInitialState) {
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
                    context.read<LoginBloc>().add(TogglePasswordObscureEvent());
                  },
                  child: Icon(
                    FontAwesomeIcons.eyeSlash,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: true,
            );
          } else if (state is LoginPasswordFieldState) {
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
                    context.read<LoginBloc>().add(TogglePasswordObscureEvent());
                  },
                  child: Icon(
                    state.isObscure
                        ? FontAwesomeIcons.eyeSlash
                        : FontAwesomeIcons.eye,
                    color: AppColors.colors.black,
                  ),
                ),
              ),
              obscureText: state.isObscure,
            );
          }

          return emptyBox();
        },
      ),
    );
  }

  TextFormField buildEmailTextField() {
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
  }

  Column buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back again!👋",
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
