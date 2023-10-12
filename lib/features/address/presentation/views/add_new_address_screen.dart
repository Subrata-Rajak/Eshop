import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/address/presentation/blocs/add_address_screen_bloc/add_address_screen_bloc.dart';
import 'package:eshop/features/address/presentation/blocs/add_address_screen_bloc/add_address_screen_events.dart';
import 'package:eshop/features/address/presentation/blocs/add_address_screen_bloc/add_address_screen_states.dart';
import 'package:eshop/features/address/presentation/widgets/custom_address_fields.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/values/colors.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen>
    with CommonWidgets {
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();

  bool isSelected = false;

  @override
  void dispose() {
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    landmarkController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: buildBody(size: size),
    );
  }

  SafeArea buildBody({
    required Size size,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocProvider<AddAddressScreenBloc>(
          create: (context) => sl(),
          child: BlocConsumer<AddAddressScreenBloc, AddAddressScreenStates>(
            listener: (context, state) {
              if (state is AddingSuccessfulState) {
                context.pop();
                context.pop();
              }
            },
            builder: (context, state) {
              if (state is AddingAddressState) {
                return Column(
                  children: [
                    verticalSpace(height: 20),
                    buildHeader(size, context),
                    Expanded(
                      child: Center(
                        child: Lottie.asset(
                          "assets/anim/loading_anim.json",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is AddingErrorState) {
                return Column(
                  children: [
                    verticalSpace(height: 20),
                    buildHeader(size, context),
                    Expanded(
                      child: Center(
                        child: Lottie.asset(
                          "assets/anim/error.json",
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  verticalSpace(height: 20),
                  buildHeader(size, context),
                  verticalSpace(height: 10),
                  buildSelectedOrNotSection(),
                  verticalSpace(height: 10),
                  buildForm(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Expanded buildForm() {
    return Expanded(
      child: ListView(
        children: [
          CustomAddressField(
            labelName: "Country",
            controller: countryController,
          ),
          verticalSpace(height: 20),
          CustomAddressField(
            labelName: "State",
            controller: stateController,
          ),
          verticalSpace(height: 20),
          CustomAddressField(
            labelName: "City",
            controller: cityController,
          ),
          verticalSpace(height: 20),
          CustomAddressField(
            labelName: "Landmark",
            controller: landmarkController,
          ),
          verticalSpace(height: 20),
          CustomAddressField(
            labelName: "Area",
            controller: areaController,
          ),
          verticalSpace(height: 20),
          CustomAddressField(
            labelName: "Pincode",
            controller: pincodeController,
          ),
        ],
      ),
    );
  }

  Row buildSelectedOrNotSection() {
    return Row(
      children: [
        Text(
          "Selected",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.colors.darkBlue,
          ),
        ),
        Checkbox(
          value: isSelected,
          onChanged: (value) => setState(
            () {
              isSelected = !isSelected;
            },
          ),
        ),
      ],
    );
  }

  SizedBox buildHeader(
    Size size,
    BuildContext neededContext,
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
                "Add address",
                style: TextStyle(
                  color: AppColors.colors.darkBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              neededContext.read<AddAddressScreenBloc>().add(
                    AddAddressEvent(
                      area: areaController.text,
                      city: cityController.text,
                      country: countryController.text,
                      landmark: landmarkController.text,
                      pincode: pincodeController.text,
                      selected: isSelected,
                      state: stateController.text,
                    ),
                  );
            },
            child: Text(
              "Add",
              style: TextStyle(
                color: AppColors.colors.orange,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
