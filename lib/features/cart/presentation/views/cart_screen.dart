import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_bloc.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_events.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_states.dart';
import 'package:eshop/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CartDetailsScreen extends StatefulWidget {
  const CartDetailsScreen({super.key});

  @override
  State<CartDetailsScreen> createState() => _CartDetailsScreenState();
}

class _CartDetailsScreenState extends State<CartDetailsScreen>
    with CommonWidgets {
  CartDetailsEntity? globalCartDetails;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider<CartDetailsScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<CartDetailsScreenBloc, CartDetailsScreenStates>(
          builder: (context, state) {
            if (state is CartDetailsScreenInitialState) {
              context
                  .read<CartDetailsScreenBloc>()
                  .add(FetchCartDetailsEvent());
            } else if (state is CartDetailsFetchingState) {
              return SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      buildHeader(size, context, false),
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
            } else if (state is CartDetailsFetchingSuccessfulState) {
              final cartDetails = state.cartDetails;
              globalCartDetails = cartDetails;
              return buildBody(size, cartDetails);
            } else if (state is CartDetailsFetchingErrorState) {
              return SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      buildHeader(size, context, false),
                      const Expanded(
                        child: Center(
                          child: Text("You don't have anything in your cart"),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return emptyBox();
          },
        ),
      ),
    );
  }

  SizedBox buildHeader(
    Size size,
    BuildContext context,
    bool error,
  ) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
              horizontalSpace(width: 20),
              Text(
                "Cart",
                style: TextStyle(
                  color: AppColors.colors.darkBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          error
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.colors.orange,
                    elevation: 0,
                  ),
                  onPressed: () {
                    context.push(
                      AppRoutePaths.paths.orderSummaryPath,
                      extra: OrderSummaryScreenArgs(
                        cartDetails: globalCartDetails,
                        productDetails: null,
                      ),
                    );
                  },
                  child: Text(
                    "Checkout",
                    style: TextStyle(
                      color: AppColors.colors.white,
                    ),
                  ),
                )
              : emptyBox(),
        ],
      ),
    );
  }

  SafeArea buildBody(Size size, CartDetailsEntity? cartDetails) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            buildHeader(
              size,
              context,
              true,
            ),
            verticalSpace(height: 20),
            BlocProvider<CartDetailsScreenBloc>(
              create: (cartDetailsScreenContext) => sl(),
              child:
                  BlocBuilder<CartDetailsScreenBloc, CartDetailsScreenStates>(
                builder: (context, state) {
                  if (state is RemovingFromCartSuccessfulState) {
                    final cartDetails = state.cartDetails;
                    globalCartDetails = cartDetails;
                    return Expanded(
                      child: cartDetails!.products.isEmpty
                          ? const Center(
                              child:
                                  Text("You don't have anything in your cart"),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                return CartItemCard(
                                  size: size,
                                  product: cartDetails.products[index],
                                  index: index,
                                  cartDetailsScreenContext: context,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return verticalSpace(height: 18);
                              },
                              itemCount: cartDetails.products.length,
                            ),
                    );
                  } else if (state is RemovingFromCartState) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.colors.darkBlue,
                        ),
                      ),
                    );
                  } else if (state is RemovingFromCartErrorState) {
                    return const Expanded(
                      child: Center(
                        child: Text("Something wrong happened"),
                      ),
                    );
                  }
                  return Expanded(
                    child: cartDetails!.products.isEmpty
                        ? const Center(
                            child: Text("You don't have anything in your cart"),
                          )
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return CartItemCard(
                                size: size,
                                product: cartDetails.products[index],
                                index: index,
                                cartDetailsScreenContext: context,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return verticalSpace(height: 18);
                            },
                            itemCount: cartDetails.products.length,
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
