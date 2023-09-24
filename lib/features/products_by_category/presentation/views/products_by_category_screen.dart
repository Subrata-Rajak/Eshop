import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/products_by_category/domain/entity/product_by_category_entity.dart';
import 'package:eshop/features/products_by_category/presentation/blocs/product_by_category_screen_bloc/product_by_category_screen_States.dart';
import 'package:eshop/features/products_by_category/presentation/blocs/product_by_category_screen_bloc/product_by_category_screen_bloc.dart';
import 'package:eshop/features/products_by_category/presentation/blocs/product_by_category_screen_bloc/product_by_category_screen_events.dart';
import 'package:eshop/features/products_by_category/presentation/widget/product_by_category_card.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryName;
  const ProductsByCategoryScreen({
    super.key,
    required this.categoryName,
  });

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen>
    with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<ProductByCategoryScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<ProductByCategoryScreenBloc,
            ProductByCategoryScreenStates>(
          builder: (context, state) {
            if (state is ProductByCategoryInitialState) {
              context.read<ProductByCategoryScreenBloc>().add(
                    FetchProductByCategoryDataEvent(
                      categoryName: widget.categoryName,
                    ),
                  );
            } else if (state is ProductByCategoryDataFetchingState) {
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      buildHeader(size),
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.colors.darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is ProductByCategoryFetchingSuccessfulState) {
              final productByCategoryData = state.productByCategory;
              return buildBody(
                size,
                productByCategoryData,
              );
            }
            return emptyBox();
          },
        ),
      ),
    );
  }

  buildBody(
    Size size,
    ProductByCategoryEntity? productByCategoryEntity,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            buildHeader(size),
            verticalSpace(height: 20),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ProductByCategoryCard(
                    size: size,
                    productByCategoryEntity:
                        productByCategoryEntity.productByCategory[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(height: 15);
                },
                itemCount: productByCategoryEntity!.productByCategory.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox buildHeader(Size size) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: AppColors.colors.darkBlue,
            ),
          ),
          horizontalSpace(width: 30),
          Text(
            widget.categoryName,
            style: TextStyle(
              color: AppColors.colors.darkBlue,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          )
        ],
      ),
    );
  }
}
