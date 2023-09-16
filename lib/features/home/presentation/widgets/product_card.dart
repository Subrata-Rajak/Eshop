import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';
import '../../domain/entity/all_products_entity.dart';

class ProductCard extends StatelessWidget with CommonWidgets {
  final Product product;
  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutePaths.paths.productDetailsPath,
          extra: ProductDetailsScreenArgs(
            productId: product.id,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                border: Border.all(
                  color: AppColors.colors.darkBlue,
                ),
              ),
              padding: const EdgeInsets.all(3),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                child: Image(
                  image: NetworkImage(
                    product.imageUrl[0],
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          verticalSpace(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              product.price.toString(),
              style: TextStyle(
                color: AppColors.colors.darkBlue,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
