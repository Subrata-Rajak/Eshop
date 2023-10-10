import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/cart/domain/entities/cart_details_entity.dart';
import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';
import 'package:eshop/features/order_details/presentation/blocs/order_summary_bloc/order_summary_bloc.dart';
import 'package:eshop/features/order_details/presentation/blocs/order_summary_bloc/order_summary_events.dart';
import 'package:eshop/features/order_details/presentation/blocs/order_summary_bloc/order_summary_states.dart';
import 'package:eshop/features/order_details/presentation/widgets/order_item_card.dart';
import 'package:eshop/features/order_details/presentation/widgets/selected_address_card.dart';
import 'package:eshop/features/order_details/utils/calculate_total_price.dart';
import 'package:eshop/features/product_details/domain/entities/product_entity.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';

class OrderSummaryScreen extends StatefulWidget {
  final OrderSummaryScreenArgs args;
  const OrderSummaryScreen({
    super.key,
    required this.args,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen>
    with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    CartDetailsEntity? cartDetails = widget.args.cartDetails;
    ProductDetailsEntity? productDetails = widget.args.productDetails;
    double totalPrice = cartDetails != null
        ? calculateTotalPrice(cartDetails: widget.args.cartDetails)
        : productDetails!.price.toDouble();
    double priceAfterGst = calculatePriceAfterGst(totalPrice: totalPrice);

    return Scaffold(
      body: BlocProvider<OrderSummaryScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<OrderSummaryScreenBloc, OrderSummaryScreenStates>(
          builder: (context, state) {
            if (state is OrderSummaryInitialState) {
              context
                  .read<OrderSummaryScreenBloc>()
                  .add(FetchInitialDataEvent());
            } else if (state is FetchingInitialDataState) {
              return SafeArea(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      buildHeader(size),
                      Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is InitialDataFetchingSuccessState) {
              final selectedAddress = state.selectedAddress;
              return buildBody(
                size: size,
                selectedAddress: selectedAddress,
                context: context,
                totalPrice: totalPrice,
                cartDetails: cartDetails,
                priceAfterGst: priceAfterGst,
                productDetails: productDetails,
              );
            } else if (state is InitialDataFetchingErrorState) {
              return const Center(
                child: Text(
                  "Something wrong happened",
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
    required SelectedAddressEntity? selectedAddress,
    required BuildContext context,
    required double totalPrice,
    required double priceAfterGst,
    required CartDetailsEntity? cartDetails,
    required ProductDetailsEntity? productDetails,
  }) {
    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            buildHeader(size),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SelectedAddressCard(
                      selectedAddress: selectedAddress,
                      size: size,
                    ),
                  ),
                  verticalSpace(height: 20),
                  buildOrderItemsSection(
                    cartDetails,
                    productDetails,
                    size,
                  ),
                  verticalSpace(height: 20),
                  buildPaymentDetailsSection(totalPrice, priceAfterGst)
                ],
              ),
            ),
            buildBottomSection(
              size,
              priceAfterGst,
              selectedAddress,
              cartDetails,
              productDetails,
              totalPrice,
            ),
          ],
        ),
      ),
    );
  }

  Container buildPaymentDetailsSection(
    double totalPrice,
    double priceAfterGst,
  ) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.colors.black.withOpacity(0.3),
          ),
          bottom: BorderSide(
            color: AppColors.colors.black.withOpacity(0.3),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Order Items price"),
              Text(totalPrice.toString()),
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
                priceAfterGst.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildOrderItemsSection(
    CartDetailsEntity? cartDetails,
    ProductDetailsEntity? productDetails,
    Size size,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: List.generate(
          cartDetails != null ? cartDetails.products.length : 1,
          (index) => OrderItemCard(
            product: cartDetails != null ? cartDetails.products[index] : null,
            productDetails: cartDetails == null ? productDetails : null,
            size: size,
          ),
        ),
      ),
    );
  }

  Container buildBottomSection(
    Size size,
    double priceAfterGst,
    SelectedAddressEntity? selectedAddress,
    CartDetailsEntity? cartDetails,
    ProductDetailsEntity? productDetails,
    double totalPrice,
  ) {
    return Container(
      width: size.width,
      height: 70,
      decoration: BoxDecoration(color: AppColors.colors.orange),
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total price - ₹$priceAfterGst",
            style: TextStyle(
              color: AppColors.colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.colors.white,
            ),
            onPressed: () {
              int finalAmount = (priceAfterGst * 100).round();
              context.push(
                AppRoutePaths.paths.paymentMethodPath,
                extra: PaymentMethodScreenArgs(
                  amount: finalAmount.toString(),
                  selectedAddress: selectedAddress,
                  cartDetails: cartDetails,
                  productDetails: productDetails,
                  orderSubTotal: totalPrice.toString(),
                ),
              );
            },
            child: Text(
              "Order",
              style: TextStyle(
                color: AppColors.colors.darkBlue,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHeader(Size size) {
    return Container(
      padding: const EdgeInsets.all(20),
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
            "Order Summary",
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
