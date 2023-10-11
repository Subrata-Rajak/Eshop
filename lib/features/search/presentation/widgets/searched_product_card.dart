import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/search/domain/entities/search_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';

class SearchedProductCard extends StatelessWidget with CommonWidgets {
  final SearchedProductEntity? searchedProduct;
  final Size size;
  const SearchedProductCard({
    super.key,
    required this.searchedProduct,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutePaths.paths.productDetailsPath,
          extra: ProductDetailsScreenArgs(productId: searchedProduct!.id),
        );
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
          color: AppColors.colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                searchedProduct!.imageUrl[0],
              ),
              width: 50,
              height: 50,
            ),
            horizontalSpace(width: 20),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchedProduct!.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  verticalSpace(height: 10),
                  Text(
                    searchedProduct!.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(height: 10),
                  Text(
                    "₹ ${searchedProduct!.price}",
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
      ),
    );
  }
}
