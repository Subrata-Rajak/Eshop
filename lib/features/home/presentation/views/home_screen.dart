import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/home/domain/entity/all_product_categories_entity.dart';
import 'package:eshop/features/home/domain/entity/all_products_entity.dart';
import 'package:eshop/features/home/presentation/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:eshop/features/home/presentation/blocs/home_screen_bloc/home_screen_events.dart';
import 'package:eshop/features/home/presentation/widgets/product_card.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entity/user_entity.dart';
import '../blocs/home_screen_bloc/home_screen_states.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<HomeBloc>(
        create: (context) => sl(),
        child: BlocConsumer<HomeBloc, HomeScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeInitialState) {
              context.read<HomeBloc>().add(HomeInitialDataFetchingEvent());
              return emptyBox();
            } else if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.colors.darkBlue,
                ),
              );
            } else if (state is HomeInitialDataFetchingSuccessState) {
              final user = state.user;
              final allProductCategories = state.allProductsCategories;
              final allProducts = state.allProducts;
              return SafeArea(
                child: Container(
                  width: size.width,
                  height: size.height,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      buildHeader(size, user),
                      verticalSpace(height: 20),
                      buildCategoryListView(size, allProductCategories),
                      verticalSpace(height: 30),
                      buildProductList(allProducts: allProducts),
                    ],
                  ),
                ),
              );
            } else if (state is HomeInitialDataFetchingErrorState) {
              return const Center(
                child: Text("Something wrong happened"),
              );
            }
            return emptyBox();
          },
        ),
      ),
    );
  }

  Expanded buildProductList({required AllProductsEntity? allProducts}) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 250,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: allProducts!.products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: allProducts.products[index],
          );
        },
      ),
    );
  }

  SizedBox buildCategoryListView(
    Size size,
    AllProductsCategoryEntity? allProductsCategories,
  ) {
    return SizedBox(
      width: size.width,
      height: 50,
      child: ListView.separated(
        itemCount: allProductsCategories!.allProductCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.push(
                AppRoutePaths.paths.productByCategoryPath,
                extra: ProductByCategoryScreenArgs(
                  categoryName: allProductsCategories
                      .allProductCategories[index].categoryName,
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                allProductsCategories
                    .allProductCategories[index].categoryImageUrl,
              ),
              radius: 25,
            ),
          );
        },
        separatorBuilder: (context, index) {
          return horizontalSpace(width: 10);
        },
      ),
    );
  }

  Row buildHeader(Size size, UserEntity? user) {
    final addresses = user!.addresses;
    Address? selectedAddress;

    for (int i = 0; i < addresses.length; i++) {
      if (addresses[i].selected) {
        selectedAddress = addresses[i];
        break;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.push(AppRoutePaths.paths.profilePath);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.profileImageUrl),
                radius: 22,
              ),
            ),
            horizontalSpace(width: 10),
            SizedBox(
              width: size.width * 0.5,
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    child: Text(
                      "${selectedAddress!.area}, ${selectedAddress.city}, ${selectedAddress.state}, near ${selectedAddress.landmark} ${selectedAddress.pincode}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  horizontalSpace(width: 10),
                  GestureDetector(
                    onTap: () {
                      context.push(AppRoutePaths.paths.addressPath);
                    },
                    child: Icon(
                      FontAwesomeIcons.caretDown,
                      color: AppColors.colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.push(AppRoutePaths.paths.searchPath);
              },
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: AppColors.colors.black,
              ),
            ),
            horizontalSpace(width: 15),
            GestureDetector(
              onTap: () {
                context.push(AppRoutePaths.paths.cartPath);
              },
              child: Icon(
                FontAwesomeIcons.cartShopping,
                color: AppColors.colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
