import 'package:eshop/config/routes/routes.dart';
// import 'package:eshop/config/themes/dark.dart';
import 'package:eshop/config/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_storage/get_storage.dart';
import 'injection_container.dart';

void main() async {
  await initDep();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51NwIqrSFiGeroSBKW8tRhEZp9Ly6uUCseTxjK3dvSLVe9dkV5n3Bk4pJAmsfbLfnHtHUhTuWLfkPVulXjdZkFjOC00NEW3OtSz";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppLightTheme.theme.getLightTheme(),
      // darkTheme: AppDarkTheme.theme.getDarkTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.routes.router,
    );
  }
}
