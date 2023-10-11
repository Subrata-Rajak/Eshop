import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_bloc.dart';
import 'package:eshop/features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_events.dart';
import 'package:eshop/features/order_details/presentation/blocs/payment_method_screen_bloc/payment_method_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../injection_container.dart';

class OrderPlaceScreen extends StatefulWidget {
  final OrderPlaceScreenArgs args;
  const OrderPlaceScreen({
    super.key,
    required this.args,
  });

  @override
  State<OrderPlaceScreen> createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen>
    with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<PaymentMethodScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<PaymentMethodScreenBloc, PaymentMethodScreenStates>(
          builder: (context, state) {
            if (state is PaymentMethodScreenInitialState) {
              context.read<PaymentMethodScreenBloc>().add(
                    PlaceOrderEvent(
                      addressId: widget.args.addressId,
                      country: widget.args.country,
                      state: widget.args.state,
                      city: widget.args.city,
                      landmark: widget.args.landmark,
                      area: widget.args.area,
                      pincode: widget.args.pincode,
                      paymentMethod: widget.args.paymentMethod,
                      amount: widget.args.amount,
                      orderItemsFromCartDetails:
                          widget.args.orderItemsFromCartDetails,
                      orderItemsFromProductDetails:
                          widget.args.orderItemsFromProductDetails,
                      totalAmount: widget.args.totalAmount,
                      orderSubTotal: widget.args.orderSubTotal,
                    ),
                  );
            } else if (state is PlacingOrderState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/anim/loading_anim.json",
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      "Placing Your Order",
                      style: TextStyle(
                        color: AppColors.colors.darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is OrderPlacedSuccessfullyState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/anim/successful.json",
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      "Order Placed SuccessFully",
                      style: TextStyle(
                        color: AppColors.colors.darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colors.red,
                      ),
                      onPressed: () {
                        while (context.canPop()) {
                          final currentRoute = ModalRoute.of(context);
                          if (currentRoute?.settings.name ==
                              AppRouteNames.names.homeRouteName) {
                            break;
                          }
                          context.pop();
                        }
                        context.replace(AppRoutePaths.paths.homePath);
                      },
                      child: Text(
                        "Back to home",
                        style: TextStyle(
                          color: AppColors.colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is OrderPlacingErrorState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/anim/error.json",
                      height: 100,
                      width: 100,
                    ),
                    Text(
                      "Something Wrong happened",
                      style: TextStyle(
                        color: AppColors.colors.darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpace(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colors.red,
                      ),
                      onPressed: () {
                        context.read<PaymentMethodScreenBloc>().add(
                              PlaceOrderEvent(
                                addressId: widget.args.addressId,
                                country: widget.args.country,
                                state: widget.args.state,
                                city: widget.args.city,
                                landmark: widget.args.landmark,
                                area: widget.args.area,
                                pincode: widget.args.pincode,
                                paymentMethod: widget.args.paymentMethod,
                                amount: widget.args.amount,
                                orderItemsFromCartDetails:
                                    widget.args.orderItemsFromCartDetails,
                                orderItemsFromProductDetails:
                                    widget.args.orderItemsFromProductDetails,
                                totalAmount: widget.args.totalAmount,
                                orderSubTotal: widget.args.orderSubTotal,
                              ),
                            );
                      },
                      child: Text(
                        "Retry",
                        style: TextStyle(
                          color: AppColors.colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return emptyBox();
          },
        ),
      ),
    );
  }
}
