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
}
