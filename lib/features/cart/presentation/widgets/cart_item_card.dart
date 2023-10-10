import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_bloc.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_events.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_states.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/values/colors.dart';

class CartItemCard extends StatelessWidget with CommonWidgets {
  final Size size;
  final CartDetailsProductEntity? product;
  final int index;
  final BuildContext cartDetailsScreenContext;
  const CartItemCard({
    super.key,
    required this.size,
    required this.product,
    required this.index,
    required this.cartDetailsScreenContext,
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
          BlocProvider<CartDetailsScreenBloc>(
            create: (context) => sl(),
            child: BlocBuilder<CartDetailsScreenBloc, CartDetailsScreenStates>(
              builder: (context, state) {
                if (state is IncreasingCartQuantityState ||
                    state is DecreasingCartQuantityState ||
                    state is RemovingFromCartErrorState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<CartDetailsScreenBloc>().add(
                              IncreaseCartQuantityEvent(
                                productId: product!.productId,
                              ),
                            ),
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: AppColors.colors.orange,
                          size: 20,
                        ),
                      ),
                      verticalSpace(height: 15),
                      SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: AppColors.colors.darkBlue,
                        ),
                      ),
                      verticalSpace(height: 15),
                      GestureDetector(
                        onTap: () => context.read<CartDetailsScreenBloc>().add(
                              DecreaseCartQuantityEvent(
                                productId: product!.productId,
                              ),
                            ),
                        child: Icon(
                          FontAwesomeIcons.minus,
                          color: AppColors.colors.orange,
                          size: 20,
                        ),
                      ),
                    ],
                  );
                } else if (state is IncreasingCartQuantitySuccessfulState) {
                  final cartDetails = state.cartDetails;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<CartDetailsScreenBloc>().add(
                              IncreaseCartQuantityEvent(
                                productId: product!.productId,
                              ),
                            ),
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: AppColors.colors.orange,
                          size: 20,
                        ),
                      ),
                      verticalSpace(height: 15),
                      Text(
                        cartDetails!.products[index].cartQuantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      verticalSpace(height: 15),
                      GestureDetector(
                        onTap: () => context.read<CartDetailsScreenBloc>().add(
                              DecreaseCartQuantityEvent(
                                productId: product!.productId,
                              ),
                            ),
                        child: Icon(
                          FontAwesomeIcons.minus,
                          color: AppColors.colors.orange,
                          size: 20,
                        ),
                      ),
                    ],
                  );
                } else if (state is DecreasingCartQuantitySuccessfulState) {
                  final cartDetails = state.cartDetails;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.read<CartDetailsScreenBloc>().add(
                              IncreaseCartQuantityEvent(
                                productId: product!.productId,
                              ),
                            ),
                        child: Icon(
                          FontAwesomeIcons.plus,
                          color: AppColors.colors.orange,
                          size: 20,
                        ),
                      ),
                      verticalSpace(height: 15),
                      Text(
                        cartDetails!.products[index].cartQuantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      verticalSpace(height: 15),
                      GestureDetector(
                        onTap: () {
                          if (cartDetails.products[index].cartQuantity == 1) {
                            print("Hawle");
                            cartDetailsScreenContext
                                .read<CartDetailsScreenBloc>()
                                .add(
                                  RemoveFromCartEvent(
                                    productId: product!.productId,
                                  ),
                                );
                          } else {
                            print("hawle 2");
                            context.read<CartDetailsScreenBloc>().add(
                                  DecreaseCartQuantityEvent(
                                    productId: product!.productId,
                                  ),
                                );
                          }
                        },
                        child: Icon(
                          FontAwesomeIcons.minus,
                          color: AppColors.colors.orange,
                          size: 20,
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.read<CartDetailsScreenBloc>().add(
                            IncreaseCartQuantityEvent(
                              productId: product!.productId,
                            ),
                          ),
                      child: Icon(
                        FontAwesomeIcons.plus,
                        color: AppColors.colors.orange,
                        size: 20,
                      ),
                    ),
                    verticalSpace(height: 15),
                    Text(
                      product!.cartQuantity.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(height: 15),
                    GestureDetector(
                      onTap: () {
                        if (product!.cartQuantity == 1) {
                          print("Hawle");
                          cartDetailsScreenContext
                              .read<CartDetailsScreenBloc>()
                              .add(
                                RemoveFromCartEvent(
                                  productId: product!.productId,
                                ),
                              );
                        } else {
                          print("hawle 2");
                          context.read<CartDetailsScreenBloc>().add(
                                DecreaseCartQuantityEvent(
                                  productId: product!.productId,
                                ),
                              );
                        }
                      },
                      child: Icon(
                        FontAwesomeIcons.minus,
                        color: AppColors.colors.orange,
                        size: 20,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
