import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_names.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/features/auth/presentation/views/email_for_otp_screen.dart';
import 'package:eshop/features/auth/presentation/views/update_password_screen.dart';
import 'package:eshop/features/auth/presentation/views/login_screen.dart';
import 'package:eshop/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:eshop/features/auth/presentation/views/register_screen.dart';
import 'package:eshop/features/home/presentation/views/home_screen.dart';
import 'package:eshop/features/product_details/presentation/views/product_details_screen.dart';
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
        name: AppRouteNames.names.updatePasswordRouteName,
        path: AppRoutePaths.paths.updatePasswordPath,
        builder: (context, state) {
          final UpdatePasswordScreenArgs args =
              state.extra as UpdatePasswordScreenArgs;
          return UpdatePasswordScreen(args: args);
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
        path: AppRoutePaths.paths.otpVerificationPath,
        builder: (context, state) {
          OtpVerificationScreenArgs args =
              state.extra as OtpVerificationScreenArgs;
          return OtpVerificationScreen(
            args: args,
          );
        },
      ),
      GoRoute(
        name: AppRouteNames.names.homeRouteName,
        path: AppRoutePaths.paths.initialPath,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.productDetailsPath,
        name: AppRouteNames.names.productDetailsName,
        builder: (context, state) {
          ProductDetailsScreenArgs args =
              state.extra as ProductDetailsScreenArgs;
          return ProductDetailsScreen(args: args);
        },
      )
    ],
    initialLocation: AppRoutePaths.paths.initialPath,
  );
}
