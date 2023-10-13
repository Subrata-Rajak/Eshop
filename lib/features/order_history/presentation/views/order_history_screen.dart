import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/order_history/domain/entities/order_history_entity.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_screen_bloc/order_history_screen_bloc.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_screen_bloc/order_history_screen_events.dart';
import 'package:eshop/features/order_history/presentation/blocs/order_history_screen_bloc/order_history_screen_states.dart';
import 'package:eshop/features/order_history/presentation/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';
import '../../../../injection_container.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<OrderHistoryScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<OrderHistoryScreenBloc, OrderHistoryScreenStates>(
          builder: (context, state) {
            if (state is OrderHistoryScreenInitialState) {
              context
                  .read<OrderHistoryScreenBloc>()
                  .add(FetchOrderHistoryEvent());
            } else if (state is FetchingOrderHistoryState) {
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
                            color: AppColors.colors.darkBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is FetchingSuccessfulState) {
              final orderHistory = state.orderHistory;
              return buildBody(
                size: size,
                orderHistory: orderHistory,
                context: context,
              );
            } else if (state is FetchingErrorState) {
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
    required OrderHistoryEntity? orderHistory,
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
              child: orderHistory!.orders.isEmpty
                  ? const Center(
                      child: Text("You haven't ordered anything so far"),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return OrderCard(
                          size: size,
                          orderEntity: orderHistory.orders[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return verticalSpace(height: 30);
                      },
                      itemCount: orderHistory.orders.length,
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
            "Orders",
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
