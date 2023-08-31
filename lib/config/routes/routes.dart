import 'package:eshop/config/routes/route_names.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/features/auth/presentation/views/email_for_otp_screen.dart';
import 'package:eshop/features/auth/presentation/views/forgot_password_screen.dart';
import 'package:eshop/features/auth/presentation/views/login_screen.dart';
import 'package:eshop/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:eshop/features/auth/presentation/views/register_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static AppRoutes routes = AppRoutes();

  final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: AppRouteNames.names.loginRouteName,
        path: AppRoutePaths.paths.loginPath,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: AppRouteNames.names.forgotPasswordRouteName,
        path: AppRoutePaths.paths.forgotPasswordPath,
        builder: (context, state) {
          return const ForgotPasswordScreen();
        },
      ),
      GoRoute(
        name: AppRouteNames.names.registerRouteName,
        path: AppRoutePaths.paths.registerPath,
        builder: (context, state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        name: AppRouteNames.names.emailForOtpRouteName,
        path: AppRoutePaths.paths.emailForOtpPath,
        builder: (context, state) {
          return const EmailForOtpScreen();
        },
      ),
      GoRoute(
        name: AppRouteNames.names.otpVerificationRouteName,
        path: AppRoutePaths.paths.initialPath,
        builder: (context, state) {
          return const OtpVerificationScreen();
        },
      ),
    ],
    initialLocation: AppRoutePaths.paths.initialPath,
  );
}
