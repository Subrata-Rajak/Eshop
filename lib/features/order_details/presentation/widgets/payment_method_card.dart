import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget with CommonWidgets {
  final Size size;
  final String methodName;
  final String methodDescription;
  final IconData icon;
  final Widget radio;

  const PaymentMethodCard({
    super.key,
    required this.size,
    required this.methodName,
    required this.icon,
    required this.methodDescription,
    required this.radio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colors.grey.withOpacity(0.3),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Icon(
                    icon,
                    color: AppColors.colors.orange,
                  ),
                ),
              ),
              horizontalSpace(width: 15),
              SizedBox(
                width: size.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      methodName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(height: 6),
                    Text(
                      methodDescription,
                      style: TextStyle(
                        color: AppColors.colors.grey.withOpacity(0.7),
                      ),
                    ),
                    verticalSpace(height: 6),
                  ],
                ),
              ),
            ],
          ),
          radio,
        ],
      ),
    );
  }
}
