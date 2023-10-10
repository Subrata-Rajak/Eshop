import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/address/domain/entities/address_entity.dart';
import 'package:eshop/features/address/presentation/blocs/address_details_screen_bloc/address_details_screen_bloc.dart';
import 'package:eshop/features/address/presentation/blocs/address_details_screen_bloc/address_details_screen_events.dart';
import 'package:eshop/features/address/presentation/blocs/address_details_screen_bloc/address_details_screen_states.dart';
import 'package:eshop/features/address/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/values/colors.dart';
import '../../../../injection_container.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({super.key});

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen>
    with CommonWidgets {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocProvider<AddressDetailsScreenBloc>(
        create: (context) => sl(),
        child:
            BlocBuilder<AddressDetailsScreenBloc, AddressDetailsScreenStates>(
          builder: (context, state) {
            if (state is AddressDetailsScreenInitialState) {
              context
                  .read<AddressDetailsScreenBloc>()
                  .add(AddressDetailsFetchEvent());
            } else if (state is AddressDetailsFetchingState) {
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
            } else if (state is AddressDetailsSuccessfulState) {
              final addresses = state.addressesEntity;
              return buildBody(
                size: size,
                addresses: addresses,
                context: context,
              );
            } else if (state is ADdressDetailsErrorState) {
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

  SafeArea buildBody({
    required Size size,
    required AddressesEntity? addresses,
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
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return AddressCard(
                    address: addresses.addresses[index],
                    size: size,
                  );
                },
                separatorBuilder: (context, index) {
                  return verticalSpace(height: 30);
                },
                itemCount: addresses!.addresses.length,
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
              horizontalSpace(width: 30),
              Text(
                "Address",
                style: TextStyle(
                  color: AppColors.colors.darkBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          GestureDetector(
            child: Icon(
              FontAwesomeIcons.plus,
              color: AppColors.colors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}
