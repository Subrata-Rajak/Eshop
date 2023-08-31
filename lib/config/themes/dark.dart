import 'package:eshop/core/values/colors.dart';
import 'package:flutter/material.dart';

class AppDarkTheme {
  static AppDarkTheme theme = AppDarkTheme();

  ThemeData getDarkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.colors.black,
    );
  }
}
