// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/order_details/presentation/widgets/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../../../core/values/colors.dart';
import '../blocs/payment_method_screen_bloc/payment_method_screen_bloc.dart';

class PaymentMethodScreen extends StatefulWidget {
  final PaymentMethodScreenArgs args;
  const PaymentMethodScreen({
    super.key,
    required this.args,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen>
    with CommonWidgets {
  PaymentMethods? paymentMethod = PaymentMethods.payOnDelivery;
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildBody(
        size: size,
      ),
    );
  }

  buildBody({
    required Size size,
  }) {
    return SafeArea(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            buildHeader(size),
            buildPaymentMethodsSection(size),
            SizedBox(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colors.darkBlue,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                      ),
                      onPressed: () async {
                        if (paymentMethod == PaymentMethods.payWithStripe) {
                          await payOnline();
                        } else {
                          context.push(
                            AppRoutePaths.paths.orderPlacePath,
                            extra: OrderPlaceScreenArgs(
                              addressId: widget.args.selectedAddress!
                                  .selectedAddressClassEntity.id,
                              country: widget.args.selectedAddress!
                                  .selectedAddressClassEntity.country,
                              state: widget.args.selectedAddress!
                                  .selectedAddressClassEntity.state,
                              city: widget.args.selectedAddress!
                                  .selectedAddressClassEntity.city,
                              landmark: widget.args.selectedAddress!
                                  .selectedAddressClassEntity.landmark,
                              area: widget.args.selectedAddress!
                                  .selectedAddressClassEntity.area,
                              pincode: widget.args.selectedAddress!
                                  .selectedAddressClassEntity.pincode,
                              paymentMethod: paymentMethod!,
                              amount: widget.args.amount,
                              orderItemsFromCartDetails:
                                  widget.args.cartDetails,
                              orderItemsFromProductDetails:
                                  widget.args.productDetails,
                              totalAmount: widget.args.amount,
                              orderSubTotal: widget.args.orderSubTotal,
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Place Order",
                        style: TextStyle(
                          color: AppColors.colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> payOnline() async {
    try {
      paymentIntentData = await createPaymentIntent(widget.args.amount, "INR");

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: "Subrata",
        ),
      );
      displayPaymentSheet();
    } catch (e) {
      print("error while paying online: $e");
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      context.push(
        AppRoutePaths.paths.orderPlacePath,
        extra: OrderPlaceScreenArgs(
          addressId: widget.args.selectedAddress!.selectedAddressClassEntity.id,
          country:
              widget.args.selectedAddress!.selectedAddressClassEntity.country,
          state: widget.args.selectedAddress!.selectedAddressClassEntity.state,
          city: widget.args.selectedAddress!.selectedAddressClassEntity.city,
          landmark:
              widget.args.selectedAddress!.selectedAddressClassEntity.landmark,
          area: widget.args.selectedAddress!.selectedAddressClassEntity.area,
          pincode:
              widget.args.selectedAddress!.selectedAddressClassEntity.pincode,
          paymentMethod: paymentMethod!,
          amount: widget.args.amount,
          orderItemsFromCartDetails: widget.args.cartDetails,
          orderItemsFromProductDetails: widget.args.productDetails,
          totalAmount: widget.args.amount,
          orderSubTotal: widget.args.orderSubTotal,
        ),
      );
    } on StripeException catch (e) {
      print("Error while displaying payment sheet: $e");
    }
  }

  createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        "amount": amount,
        "currency": currency,
      };

      var response = await http.post(
        Uri.parse(
          'https://api.stripe.com/v1/payment_intents',
        ),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51NwIqrSFiGeroSBKhfbU9x0J5uzD9MrUQnfs8JvC1UpqrMxueTdDwrm8pfYQ2CoqRUCXcpkfDDcdgwuhwJy54XKO00euSmEVhN',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      print("Error while creating paymentIntentData: $e");
    }
  }

  SizedBox buildPaymentMethodsSection(Size size) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            PaymentMethodCard(
              size: size,
              methodName: "Pay on Delivery",
              methodDescription:
                  "Pay conveniently with physical currency for your purchases",
              icon: FontAwesomeIcons.wallet,
              radio: Radio<PaymentMethods>(
                value: PaymentMethods.payOnDelivery,
                groupValue: paymentMethod,
                onChanged: (val) {
                  setState(() {
                    paymentMethod = val!;
                  });
                },
              ),
            ),
            verticalSpace(height: 30),
            PaymentMethodCard(
              size: size,
              methodName: "Pay with Stripe",
              methodDescription:
                  "Pay conveniently with online currency for your purchases",
              icon: FontAwesomeIcons.creditCard,
              radio: Radio<PaymentMethods>(
                value: PaymentMethods.payWithStripe,
                groupValue: paymentMethod,
                onChanged: (val) {
                  setState(() {
                    paymentMethod = val!;
                  });
                },
              ),
            ),
          ],
        ),
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
            "Payment Method",
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
