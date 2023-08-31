import 'package:eshop/config/routes/routes.dart';
import 'package:eshop/config/themes/dark.dart';
import 'package:eshop/config/themes/light.dart';
import 'package:flutter/material.dart';

void main() {
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
      darkTheme: AppDarkTheme.theme.getDarkTheme(),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.routes.router,
    );
  }
}