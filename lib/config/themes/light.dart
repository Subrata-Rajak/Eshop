import 'package:eshop/core/values/colors.dart';
import 'package:flutter/material.dart';

class AppLightTheme {
  static AppLightTheme theme = AppLightTheme();

  ThemeData getLightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.colors.white,
    );
  }
}
