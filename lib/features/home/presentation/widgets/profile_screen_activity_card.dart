import 'package:eshop/core/common/widgets.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/colors.dart';

class ProfileScreenActivityCard extends StatelessWidget with CommonWidgets {
  final Size size;
  final IconData? icon;
  final String cardText;
  final void Function()? fun;
  const ProfileScreenActivityCard({
    super.key,
    required this.size,
    required this.icon,
    required this.cardText,
    required this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fun,
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.colors.darkBlue.withOpacity(0.2),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.colors.darkBlue,
            ),
            horizontalSpace(width: 30),
            Text(
              cardText,
              style: TextStyle(
                color: AppColors.colors.darkBlue,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
