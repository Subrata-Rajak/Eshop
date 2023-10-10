import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/product_details/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class OrderItemCard extends StatelessWidget with CommonWidgets {
  final CartDetailsProductEntity? product;
  final ProductDetailsEntity? productDetails;
  final Size size;
  const OrderItemCard({
    super.key,
    required this.product,
    required this.size,
    required this.productDetails,
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
                    image: NetworkImage(
                      product != null
                          ? product!.productImageUrl
                          : productDetails!.imageUrl[0],
                    ),
                  ),
                ),
              ),
              horizontalSpace(width: 15),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  product != null ? product!.productName : productDetails!.name,
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
            product != null ? product!.cartQuantity.toString() : "1",
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
