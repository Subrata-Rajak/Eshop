import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WishlistCard extends StatelessWidget with CommonWidgets {
  final WishlistItemsProductEntity? product;
  final Size size;
  final void Function()? fun;
  const WishlistCard({
    super.key,
    required this.product,
    required this.size,
    required this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        border: Border.all(
          color: AppColors.colors.darkBlue,
        ),
      ),
      width: size.width,
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            child: Image(
              width: 100,
              height: 100,
              image: NetworkImage(
                product!.productImageUrl,
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product!.productName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(height: 10),
                Text(
                  product!.productDescription,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(height: 10),
                Text(
                  "₹ ${product!.productPrice.toString()}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: fun,
            child: Icon(
              FontAwesomeIcons.trash,
              color: AppColors.colors.orange,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
