import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectedAddressCard extends StatelessWidget with CommonWidgets {
  final SelectedAddressEntity? selectedAddress;
  final Size size;
  const SelectedAddressCard({
    super.key,
    required this.selectedAddress,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.colors.darkBlue.withOpacity(0.3),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                FontAwesomeIcons.locationPin,
                color: AppColors.colors.orange,
              ),
            ),
          ),
          horizontalSpace(width: 30),
          SizedBox(
            width: size.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${selectedAddress!.selectedAddressClassEntity.area}, ${selectedAddress!.selectedAddressClassEntity.city}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(height: 6),
                Text(
                  selectedAddress!.selectedAddressClassEntity.state,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(height: 6),
                Text(
                  selectedAddress!.selectedAddressClassEntity.landmark,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(height: 6),
                Text(
                  selectedAddress!.selectedAddressClassEntity.pincode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   child: Text(
          //     "Change",
          //     style: TextStyle(
          //       color: AppColors.colors.orange,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
