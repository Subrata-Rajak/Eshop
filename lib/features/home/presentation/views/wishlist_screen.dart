import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/home/domain/entity/wishlist_items_entity.dart';
import 'package:eshop/features/home/presentation/blocs/wishlist_screen_bloc/wishlist_screen_bloc.dart';
import 'package:eshop/features/home/presentation/blocs/wishlist_screen_bloc/wishlist_screen_events.dart';
import 'package:eshop/features/home/presentation/blocs/wishlist_screen_bloc/wishlist_screen_states.dart';
import 'package:eshop/features/home/presentation/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';
import '../../../../injection_container.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<WishlistScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<WishlistScreenBloc, WishlistScreenStates>(
          builder: (context, state) {
            if (state is WishlistScreenInitialState) {
              context
                  .read<WishlistScreenBloc>()
                  .add(WishlistScreenFetchDataEvent());
            } else if (state is WishlistScreenDataFetchingState ||
                state is RemovingFromWishlistState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      verticalSpace(height: 20),
                      buildHeader(size),
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                              color: AppColors.colors.darkBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is WishlistScreenDataFetchingSuccessState) {
              final wishlist = state.wishlist;
              return buildBody(
                size: size,
                wishlist: wishlist,
                context: context,
              );
            } else if (state is WishlistScreenDataFetchingErrorState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      verticalSpace(height: 20),
                      buildHeader(size),
                      Expanded(
                        child: Center(
                          child: Text(
                            "You don't have any items in wishlist now",
                            style: TextStyle(color: AppColors.colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is RemovedSuccessfulState) {
              final wishlist = state.wishlist;
              return buildBody(
                size: size,
                wishlist: wishlist,
                context: context,
              );
            } else if (state is RemovedErrorState) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      verticalSpace(height: 20),
                      buildHeader(size),
                      const Expanded(
                        child: Center(
                          child: Text("Something wrong happened"),
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

  SafeArea buildBody({
    required Size size,
    required WishlistItemsEntity? wishlist,
    required BuildContext context,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            verticalSpace(height: 20),
            buildHeader(size),
            verticalSpace(height: 30),
            Expanded(
              child: wishlist!.products.isEmpty
                  ? Center(
                      child: Text(
                        "You don't have any items in wishlist now",
                        style: TextStyle(color: AppColors.colors.black),
                      ),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return WishlistCard(
                          product: wishlist.products[index],
                          size: size,
                          fun: () {
                            context.read<WishlistScreenBloc>().add(
                                  RemoveFromWishlistEvent(
                                    productId:
                                        wishlist.products[index].productId,
                                  ),
                                );
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return verticalSpace(height: 30);
                      },
                      itemCount: wishlist.products.length,
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
            "Wishlist",
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
