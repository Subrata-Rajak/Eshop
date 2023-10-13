import 'package:eshop/config/get_storage/get_box.dart';
import 'package:eshop/config/get_storage/local_keys.dart';
import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_names.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/features/address/presentation/views/add_new_address_screen.dart';
import 'package:eshop/features/address/presentation/views/address_details_screen.dart';
import 'package:eshop/features/address/presentation/views/edit_address_screen.dart';
import 'package:eshop/features/auth/presentation/views/collect_user_details_screen.dart';
import 'package:eshop/features/auth/presentation/views/email_for_otp_screen.dart';
import 'package:eshop/features/auth/presentation/views/select_profile_image_url_screen.dart';
import 'package:eshop/features/auth/presentation/views/update_password_screen.dart';
import 'package:eshop/features/auth/presentation/views/login_screen.dart';
import 'package:eshop/features/auth/presentation/views/otp_verification_screen.dart';
import 'package:eshop/features/auth/presentation/views/register_screen.dart';
import 'package:eshop/features/cart/presentation/views/cart_screen.dart';
import 'package:eshop/features/home/presentation/views/edit_profile_screen.dart';
import 'package:eshop/features/home/presentation/views/home_screen.dart';
import 'package:eshop/features/home/presentation/views/profile_screen.dart';
import 'package:eshop/features/home/presentation/views/wishlist_screen.dart';
import 'package:eshop/features/order_details/presentation/views/order_place_screen.dart';
import 'package:eshop/features/order_details/presentation/views/order_summary.dart';
import 'package:eshop/features/order_details/presentation/views/payment_method_screen.dart';
import 'package:eshop/features/order_history/presentation/views/order_history_details_screen.dart';
import 'package:eshop/features/order_history/presentation/views/order_history_screen.dart';
import 'package:eshop/features/product_details/presentation/views/product_details_screen.dart';
import 'package:eshop/features/search/presentation/views/search_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/products_by_category/presentation/views/products_by_category_screen.dart';

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
        path: AppRoutePaths.paths.homePath,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.productDetailsPath,
        name: AppRouteNames.names.productDetailsRouteName,
        builder: (context, state) {
          ProductDetailsScreenArgs args =
              state.extra as ProductDetailsScreenArgs;
          return ProductDetailsScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.profilePath,
        name: AppRouteNames.names.profileRouteName,
        builder: (context, state) {
          return const ProfileScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.wishlistPath,
        name: AppRouteNames.names.wishlistRouteName,
        builder: (context, state) {
          return const WishlistScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.cartPath,
        name: AppRouteNames.names.cartRouteName,
        builder: (context, state) {
          return const CartDetailsScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.paymentMethodPath,
        name: AppRouteNames.names.paymentMethodRouteName,
        builder: (context, state) {
          PaymentMethodScreenArgs args = state.extra as PaymentMethodScreenArgs;
          return PaymentMethodScreen(
            args: args,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.addressPath,
        name: AppRouteNames.names.addressRouteName,
        builder: (context, state) {
          return const AddressDetailsScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.orderPlacePath,
        name: AppRouteNames.names.orderPlaceRouteName,
        builder: (context, state) {
          OrderPlaceScreenArgs args = state.extra as OrderPlaceScreenArgs;
          return OrderPlaceScreen(
            args: args,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.productByCategoryPath,
        name: AppRouteNames.names.productByCategoryRouteName,
        builder: (context, state) {
          ProductByCategoryScreenArgs args =
              state.extra as ProductByCategoryScreenArgs;
          return ProductsByCategoryScreen(
            categoryName: args.categoryName,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.orderSummaryPath,
        name: AppRouteNames.names.orderSummaryRouteName,
        builder: (context, state) {
          OrderSummaryScreenArgs args = state.extra as OrderSummaryScreenArgs;
          return OrderSummaryScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.editProfilePath,
        name: AppRouteNames.names.editProfileRouteName,
        builder: (context, state) {
          EditProfileScreenArgs args = state.extra as EditProfileScreenArgs;
          return EditProfileScreen(
            args: args,
          );
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.searchPath,
        name: AppRouteNames.names.searchRouteName,
        builder: (context, state) {
          return const SearchScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.addNewAddressPath,
        name: AppRouteNames.names.addNewAddressRouteName,
        builder: (context, state) {
          return const AddNewAddressScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.editAddressPath,
        name: AppRouteNames.names.editAddressRouteName,
        builder: (context, state) {
          EditAddressScreenArgs args = state.extra as EditAddressScreenArgs;
          return EditAddressScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.orderHistoryDetailsPath,
        name: AppRouteNames.names.orderHistoryDetailsRouteName,
        builder: (context, state) {
          OrderHistoryDetailsScreenArgs args =
              state.extra as OrderHistoryDetailsScreenArgs;
          return OrderHistoryDetailsScreen(args: args);
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.orderHistoryPath,
        name: AppRouteNames.names.orderHistoryRouteName,
        builder: (context, state) {
          return const OrderHistoryScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.selectProfileImagePath,
        name: AppRouteNames.names.selectProfileImageUrlRouteName,
        builder: (context, state) {
          return const SelectProfileImageUrlScreen();
        },
      ),
      GoRoute(
        path: AppRoutePaths.paths.collectUserDetailsPath,
        name: AppRouteNames.names.collectUserDetailsRouteName,
        builder: (context, state) {
          return const CollectUserDetailsScreen();
        },
      ),
    ],
    initialLocation: getInitialPath(),
  );
}

getInitialPath() {
  final isLoggedIn =
      GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.isLoggedIn);
  final isRegistered =
      GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.isRegistered);
  final isUploadedImage =
      GetBox.getBox.readFromLocalDb(key: AppLocalKeys.keys.isUploadedImage);
  final isCollectedUserDetails = GetBox.getBox
      .readFromLocalDb(key: AppLocalKeys.keys.isCollectedUserDetails);

  return isLoggedIn != null
      ? isLoggedIn
          ? AppRoutePaths.paths.homePath
          : AppRoutePaths.paths.loginPath
      : isRegistered != null
          ? isUploadedImage != null
              ? isCollectedUserDetails != null
                  ? AppRoutePaths.paths.homePath
                  : AppRoutePaths.paths.collectUserDetailsPath
              : AppRoutePaths.paths.selectProfileImagePath
          : AppRoutePaths.paths.registerPath;
}


/*
isLoggedIn != null
      ? isLoggedIn == true
          ? AppRoutePaths.paths.homePath
          : isRegistered != null
              ? isUploadedImage != null
                  ? isCollectedUserDetails != null
                      ? AppRoutePaths.paths.homePath
                      : AppRoutePaths.paths.collectUserDetailsPath
                  : AppRoutePaths.paths.selectProfileImagePath
              : AppRoutePaths.paths.registerPath
      : isCollectedUserDetails != null
          ? AppRoutePaths.paths.homePath
          : isUploadedImage != null
              ? AppRoutePaths.paths.collectUserDetailsPath
              : isRegistered != null
                  ? AppRoutePaths.paths.selectProfileImagePath
                  : AppRoutePaths.paths.registerPath;
*/