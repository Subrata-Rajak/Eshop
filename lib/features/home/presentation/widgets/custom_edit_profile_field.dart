import 'package:eshop/core/common/widgets.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/colors.dart';

class CustomEditProfileField extends StatelessWidget with CommonWidgets {
  final TextEditingController controller;
  final String labelName;
  const CustomEditProfileField({
    super.key,
    required this.controller,
    required this.labelName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.colors.darkBlue,
          ),
        ),
        verticalSpace(height: 20),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.colors.darkBlue,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.colors.darkBlue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.colors.darkBlue,
                width: 2,
              ),
            ),
          ),
          maxLines: labelName == "Bio" ? 8 : 1,
        ),
      ],
    );
  }
}
