import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_details_screen_bloc/order_history_details_screen_bloc.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_details_screen_bloc/order_history_details_screen_events.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_details_screen_bloc/order_history_details_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/values/colors.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/order_history_entity.dart';
import '../widgets/order_history_item_card.dart';

class OrderHistoryDetailsScreen extends StatefulWidget {
  final OrderHistoryDetailsScreenArgs args;
  const OrderHistoryDetailsScreen({
    super.key,
    required this.args,
  });

  @override
  State<OrderHistoryDetailsScreen> createState() =>
      _OrderHistoryDetailsScreenState();
}

class _OrderHistoryDetailsScreenState extends State<OrderHistoryDetailsScreen>
    with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<OrderHistoryDetailsScreenBloc>(
        create: (context) => sl(),
        child: BlocConsumer<OrderHistoryDetailsScreenBloc,
            OrderHistoryDetailsScreenStates>(
          listener: (context, state) {
            if (state is CancellationSuccessfulState) {
              context.pop();
              context.pop();
            }
          },
          builder: (context, state) {
            if (state is CancellationErrorState) {
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
                      onPressed: () {},
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
            } else if (state is CancellingOrderState) {
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
                      "Updating your profile",
                      style: TextStyle(
                        color: AppColors.colors.darkBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
            return buildBody(
              size: size,
              orderEntity: widget.args.orderEntity,
              neededContext: context,
            );
          },
        ),
      ),
    );
  }

  SafeArea buildBody({
    required Size size,
    required OrderEntity orderEntity,
    required neededContext,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace(height: 20),
            buildHeader(
              size,
              neededContext,
              widget.args.orderEntity.id,
            ),
            verticalSpace(height: 30),
            buildTopSection(orderEntity),
            verticalSpace(height: 30),
            buildShippingInfoSection(size, orderEntity),
            verticalSpace(height: 30),
            buildPaymentDetailsSection(orderEntity),
            verticalSpace(height: 30),
            buildOrderItemsSection(size, orderEntity),
          ],
        ),
      ),
    );
  }

  SizedBox buildOrderItemsSection(Size size, OrderEntity orderEntity) {
    return SizedBox(
      width: size.width,
      child: Column(
        children: List.generate(
          orderEntity.orderItems.length,
          (index) => OrderHistoryItemCard(
            orderItemEntity: orderEntity.orderItems[index],
            size: size,
          ),
        ),
      ),
    );
  }

  SizedBox buildPaymentDetailsSection(OrderEntity orderEntity) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment info",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Method: ${orderEntity.paymentInfo.paymentMethod}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Staus: ${orderEntity.orderInfo.paymentStatus}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          verticalSpace(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Order Items price"),
              Text(orderEntity.orderTotals.subtotal),
            ],
          ),
          verticalSpace(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("GST"),
              Text("12 %"),
            ],
          ),
          verticalSpace(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total Amount"),
              Text(
                (int.parse(orderEntity.orderTotals.totalAmount) / 100)
                    .toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox buildShippingInfoSection(Size size, OrderEntity orderEntity) {
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Shipping info",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpace(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.locationPin,
                    color: AppColors.colors.orange,
                  ),
                ),
              ),
              horizontalSpace(width: 20),
              SizedBox(
                width: size.width * 0.55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${orderEntity.orderInfo.shippingAddress.area}, ${orderEntity.orderInfo.shippingAddress.city}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(height: 6),
                    Text(
                      orderEntity.orderInfo.shippingAddress.state,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(height: 6),
                    Text(
                      orderEntity.orderInfo.shippingAddress.landmark,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    verticalSpace(height: 6),
                    Text(
                      orderEntity.orderInfo.shippingAddress.pincode,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              horizontalSpace(width: 20),
              Text(
                "₹ ${orderEntity.shippingInfo.shippingCost}",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildTopSection(OrderEntity orderEntity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          orderEntity.id,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        Text(
          orderEntity.orderInfo.orderStatus,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  SizedBox buildHeader(Size size, BuildContext neededContext, String orderId) {
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
                "Order Details",
                style: TextStyle(
                  color: AppColors.colors.darkBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          widget.args.orderEntity.orderInfo.orderStatus == "Cancelled"
              ? emptyBox()
              : GestureDetector(
                  onTap: () {
                    neededContext.read<OrderHistoryDetailsScreenBloc>().add(
                          CancelOrderEvent(
                            orderId: orderId,
                          ),
                        );
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: AppColors.colors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
