import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/values/colors.dart';

class OrderHistoryItemCard extends StatelessWidget with CommonWidgets {
  final OrderItemEntity orderItemEntity;
  final Size size;
  const OrderHistoryItemCard({
    super.key,
    required this.orderItemEntity,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.colors.orange),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: Image(
                    image: NetworkImage(orderItemEntity.productImageUrl),
                  ),
                ),
              ),
              horizontalSpace(width: 15),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  orderItemEntity.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            orderItemEntity.cartQuantity.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
