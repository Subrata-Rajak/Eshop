import 'package:carousel_slider/carousel_slider.dart';
import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/product_details/domain/entities/product_entity.dart';
import 'package:eshop/features/product_details/presentation/blocs/carousel_bloc/carousel_bloc.dart';
import 'package:eshop/features/product_details/presentation/blocs/carousel_bloc/carousel_events.dart';
import 'package:eshop/features/product_details/presentation/blocs/product_details_screen_bloc/product_details_screen_bloc.dart';
import 'package:eshop/features/product_details/presentation/blocs/product_details_screen_bloc/product_details_screen_events.dart';
import 'package:eshop/features/product_details/presentation/blocs/product_details_screen_bloc/product_details_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../blocs/carousel_bloc/carousel_sates.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsScreenArgs args;
  const ProductDetailsScreen({
    super.key,
    required this.args,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<ProductDetailsScreenBloc>(
        create: (context) => sl(),
        child:
            BlocConsumer<ProductDetailsScreenBloc, ProductDetailsScreenStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProductDetailsScreenInitialState) {
              context.read<ProductDetailsScreenBloc>().add(
                    ProductDetailsFetchingEvent(
                      productId: widget.args.productId,
                    ),
                  );
            } else if (state is ProductDetailsScreenLoadingState) {
              return Center(
                child:
                    CircularProgressIndicator(color: AppColors.colors.darkBlue),
              );
            } else if (state is ProductDetailsFetchingSuccessState) {
              final productDetails = state.productDetailsEntity;
              final isInWishlist = state.isProductInWishlist;
              final isInCart = state.isProductInCart;
              return buildBody(
                size,
                productDetails,
                isInWishlist,
                isInCart,
              );
            } else if (state is ProductDetailsFetchingErrorState) {
              return const Center(
                child: Text("Something Wrong happened"),
              );
            }
            return emptyBox();
          },
        ),
      ),
    );
  }

  Widget buildBody(
    Size size,
    ProductDetailsEntity? productDetails,
    bool isInWishlist,
    bool isInCart,
  ) {
    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpace(height: 20),
              buildHeader(
                size,
                isInWishlist,
              ),
              verticalSpace(height: 20),
              buildImageCarousel(productDetails),
              verticalSpace(height: 30),
              buildName(size, productDetails),
              buildTypeList(size, productDetails),
              buildDescription(size, productDetails),
              buildPrice(size, productDetails),
              Row(
                children: [
                  buildBuyNowButton(
                    size,
                    productDetails,
                  ),
                  buildAddToCartButton(
                    size,
                    productDetails,
                    isInCart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildBuyNowButton(
    Size size,
    ProductDetailsEntity? productDetails,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 0.5,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colors.darkBlue,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () {
          context.push(
            AppRoutePaths.paths.orderSummaryPath,
            extra: OrderSummaryScreenArgs(
              cartDetails: null,
              productDetails: productDetails,
            ),
          );
        },
        child: Text(
          "Buy Now",
          style: TextStyle(
            color: AppColors.colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  buildAddToCartButton(
    Size size,
    ProductDetailsEntity? productDetails,
    bool isInCart,
  ) {
    return BlocProvider<ProductDetailsScreenBloc>(
      create: (context) => sl(),
      child: BlocBuilder<ProductDetailsScreenBloc, ProductDetailsScreenStates>(
        builder: (context, state) {
          if (state is AddingToCartState || state is RemovingFromCartState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width * 0.5,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colors.darkBlue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  disabledBackgroundColor: AppColors.colors.darkBlue,
                ),
                onPressed: null,
                child: CircularProgressIndicator(color: AppColors.colors.white),
              ),
            );
          } else if (state is AddedToCartSuccessfullyState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width * 0.5,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colors.darkBlue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  state.isAdded
                      ? context.read<ProductDetailsScreenBloc>().add(
                            RemoveFromCartEvent(
                              productId: productDetails!.id,
                            ),
                          )
                      : context.read<ProductDetailsScreenBloc>().add(
                            AddToCartEvent(
                              productId: productDetails!.id,
                            ),
                          );
                },
                child: Text(
                  state.isAdded ? "Remove from cart" : "Add to cart",
                  style: TextStyle(
                    color: AppColors.colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: state.isAdded ? 15 : 20,
                  ),
                ),
              ),
            );
          } else if (state is RemovedFromCartSuccessfulState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width * 0.5,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colors.darkBlue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  state.isRemoved
                      ? context.read<ProductDetailsScreenBloc>().add(
                            AddToCartEvent(
                              productId: productDetails!.id,
                            ),
                          )
                      : context.read<ProductDetailsScreenBloc>().add(
                            RemoveFromCartEvent(
                              productId: productDetails!.id,
                            ),
                          );
                },
                child: Text(
                  state.isRemoved ? "Add to cart" : "Remove from cart",
                  style: TextStyle(
                    color: AppColors.colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: state.isRemoved ? 20 : 15,
                  ),
                ),
              ),
            );
          } else if (state is RemovedFromCartErrorState ||
              state is AddedToCartErrorState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width * 0.5,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colors.darkBlue,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  isInCart
                      ? context.read<ProductDetailsScreenBloc>().add(
                            RemoveFromCartEvent(
                              productId: productDetails!.id,
                            ),
                          )
                      : context.read<ProductDetailsScreenBloc>().add(
                            AddToCartEvent(
                              productId: productDetails!.id,
                            ),
                          );
                },
                child: Text(
                  isInCart ? "Remove from cart" : "Add to cart",
                  style: TextStyle(
                    color: AppColors.colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isInCart ? 15 : 20,
                  ),
                ),
              ),
            );
          }
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: size.width * 0.5,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colors.darkBlue,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                isInCart
                    ? context.read<ProductDetailsScreenBloc>().add(
                          RemoveFromCartEvent(
                            productId: productDetails!.id,
                          ),
                        )
                    : context.read<ProductDetailsScreenBloc>().add(
                          AddToCartEvent(
                            productId: productDetails!.id,
                          ),
                        );
              },
              child: Text(
                isInCart ? "Remove from cart" : "Add to cart",
                style: TextStyle(
                  color: AppColors.colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: isInCart ? 15 : 20,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildPrice(Size size, ProductDetailsEntity? productDetails) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(20),
      child: Text(
        "₹ ${productDetails!.price.toString()}",
        style: TextStyle(
          color: AppColors.colors.darkBlue,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  Container buildDescription(Size size, ProductDetailsEntity? productDetails) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Text(
        productDetails!.description,
        style: TextStyle(
          color: AppColors.colors.darkBlue.withOpacity(0.7),
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }

  Container buildTypeList(Size size, ProductDetailsEntity? productDetails) {
    return Container(
      width: size.width,
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.colors.darkBlue,
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Center(
              child: Text(
                productDetails!.category,
                style: TextStyle(color: AppColors.colors.white),
              ),
            ),
          ),
          horizontalSpace(width: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.colors.darkBlue,
              borderRadius: const BorderRadius.all(
                Radius.circular(18),
              ),
            ),
            child: Center(
              child: Text(
                productDetails.subCategory,
                style: TextStyle(color: AppColors.colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildName(Size size, ProductDetailsEntity? productDetails) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(20),
      child: Text(
        productDetails!.name,
        style: TextStyle(
          color: AppColors.colors.darkBlue,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    );
  }

  BlocProvider<CarouselBloc> buildImageCarousel(
      ProductDetailsEntity? productDetails) {
    return BlocProvider<CarouselBloc>(
      create: (context) => CarouselBloc(),
      child: BlocBuilder<CarouselBloc, CarouselStates>(
        builder: (context, state) {
          final currentState = state as CarouselImagesChangeState;
          return Column(
            children: [
              CarouselSlider(
                items: productDetails!.imageUrl
                    .map((url) => Image.network(url))
                    .toList(),
                options: CarouselOptions(
                  height: 200,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    context.read<CarouselBloc>().add(
                          ChangeImageEvent(index: index),
                        );
                  },
                ),
              ),
              verticalSpace(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  3,
                  (index) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentState.currentIndex == index
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Container buildHeader(
    Size size,
    bool isInWishlist,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Text(
            "Product Details",
            style: TextStyle(
              color: AppColors.colors.darkBlue,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          BlocProvider<ProductDetailsScreenBloc>(
            create: (context) => sl(),
            child: BlocBuilder<ProductDetailsScreenBloc,
                ProductDetailsScreenStates>(
              builder: (context, state) {
                if (state is AddedToWishlistSuccessState) {
                  return GestureDetector(
                    onTap: () {
                      if (state.isAdded) {
                        context.read<ProductDetailsScreenBloc>().add(
                              RemoveFromWishlistEvent(
                                productId: widget.args.productId,
                              ),
                            );
                      } else {
                        context.read<ProductDetailsScreenBloc>().add(
                              AddToWishListEvent(
                                productId: widget.args.productId,
                              ),
                            );
                      }
                    },
                    child: Icon(
                      state.isAdded
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: AppColors.colors.darkBlue,
                    ),
                  );
                } else if (state is RemovedFromWishlistSuccessState) {
                  return GestureDetector(
                    onTap: () {
                      if (!state.isRemoved) {
                        context.read<ProductDetailsScreenBloc>().add(
                              RemoveFromWishlistEvent(
                                productId: widget.args.productId,
                              ),
                            );
                      } else {
                        context.read<ProductDetailsScreenBloc>().add(
                              AddToWishListEvent(
                                productId: widget.args.productId,
                              ),
                            );
                      }
                    },
                    child: Icon(
                      state.isRemoved
                          ? FontAwesomeIcons.heart
                          : FontAwesomeIcons.solidHeart,
                      color: AppColors.colors.darkBlue,
                    ),
                  );
                } else if (state is RemovedFromWishlistErrorState ||
                    state is AddedToWishlistErrorState) {
                  return GestureDetector(
                    onTap: () {
                      if (isInWishlist) {
                        context.read<ProductDetailsScreenBloc>().add(
                            RemoveFromWishlistEvent(
                                productId: widget.args.productId));
                      } else {
                        context.read<ProductDetailsScreenBloc>().add(
                            AddToWishListEvent(
                                productId: widget.args.productId));
                      }
                    },
                    child: Icon(
                      isInWishlist
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      color: AppColors.colors.darkBlue,
                    ),
                  );
                } else if (state is AddingToWishlistState ||
                    state is RemovingFromWishlistState) {
                  return SizedBox(
                    height: 23,
                    width: 23,
                    child: CircularProgressIndicator(
                      color: AppColors.colors.darkBlue,
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    if (isInWishlist) {
                      context.read<ProductDetailsScreenBloc>().add(
                          RemoveFromWishlistEvent(
                              productId: widget.args.productId));
                    } else {
                      context.read<ProductDetailsScreenBloc>().add(
                          AddToWishListEvent(productId: widget.args.productId));
                    }
                  },
                  child: Icon(
                    isInWishlist
                        ? FontAwesomeIcons.solidHeart
                        : FontAwesomeIcons.heart,
                    color: AppColors.colors.darkBlue,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
