import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderCard extends StatelessWidget with CommonWidgets {
  final Size size;
  final OrderEntity orderEntity;
  const OrderCard({
    super.key,
    required this.size,
    required this.orderEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderEntity.id,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(
                    AppRoutePaths.paths.orderHistoryDetailsPath,
                    extra: OrderHistoryDetailsScreenArgs(
                      orderEntity: orderEntity,
                    ),
                  );
                },
                child: const Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(height: 20),
          Text(
            "Status: ${orderEntity.orderInfo.orderStatus}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          verticalSpace(height: 20),
          ListView.separated(
            shrinkWrap: true,
            itemCount: orderEntity.orderItems.length,
            itemBuilder: (context, index) {
              return ProductCard(
                orderItem: orderEntity.orderItems[index],
                size: size,
              );
            },
            separatorBuilder: (context, index) {
              return verticalSpace(height: 15);
            },
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget with CommonWidgets {
  final OrderItemEntity orderItem;
  final Size size;
  const ProductCard({
    super.key,
    required this.orderItem,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Image(
              image: NetworkImage(
                orderItem.productImageUrl,
              ),
            ),
          ),
          horizontalSpace(width: 20),
          SizedBox(
            width: size.width - 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  orderItem.productName,
                ),
                verticalSpace(height: 10),
                Text(
                  "${orderItem.cartQuantity} | ₹ ${orderItem.productPrice}",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
