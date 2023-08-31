import 'package:eshop/core/values/colors.dart';
import 'package:flutter/material.dart';

mixin CommonWidgets {
  SizedBox verticalSpace({required double height}) {
    return SizedBox(
      height: height,
      width: 0,
    );
  }

  SizedBox horizontalSpace({required double width}) {
    return SizedBox(
      width: width,
      height: 0,
    );
  }

  SizedBox emptyBox() {
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }

  SizedBox expandedButton({required Size size, required void Function()? fun}) {
    return SizedBox(
      width: size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: AppColors.colors.darkBlue,
        ),
        onPressed: fun,
        child: const Text(
          "Submit",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
