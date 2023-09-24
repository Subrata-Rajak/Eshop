import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/values/colors.dart';

class ProductByCategoryCard extends StatelessWidget with CommonWidgets {
  final Size size;
  final ProductByCategoryProductEntity? productByCategoryEntity;
  const ProductByCategoryCard({
    super.key,
    required this.size,
    required this.productByCategoryEntity,
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
                productByCategoryEntity!.imageUrl[0],
              ),
            ),
          ),
          SizedBox(
            width: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productByCategoryEntity!.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace(height: 10),
                Text(
                  productByCategoryEntity!.description,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(height: 10),
                Text(
                  "₹ ${productByCategoryEntity!.price.toString()}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
