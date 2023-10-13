import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/auth/presentation/blocs/collect_user_info_screen_bloc/collect_user_info_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/collect_user_info_screen_bloc/collect_user_info_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/collect_user_info_screen_bloc/collect_user_info_screen_states.dart';
import 'package:eshop/features/auth/presentation/widgets/user_details_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/values/colors.dart';
import '../../../../injection_container.dart';

class CollectUserDetailsScreen extends StatefulWidget {
  const CollectUserDetailsScreen({super.key});

  @override
  State<CollectUserDetailsScreen> createState() =>
      _CollectUserDetailsScreenState();
}

class _CollectUserDetailsScreenState extends State<CollectUserDetailsScreen>
    with CommonWidgets {
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  @override
  void dispose() {
    bioController.dispose();
    genderController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    stateController.dispose();
    landmarkController.dispose();
    pincodeController.dispose();
    areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<CollectUserInfoScreenBloc>(
        create: (context) => sl(),
        child: BlocConsumer<CollectUserInfoScreenBloc,
            CollectUserInfoScreenStates>(
          listener: (context, state) {
            if (state is CollectingSuccessfulState) {
              context.push(AppRoutePaths.paths.homePath);
            }
          },
          builder: (context, state) {
            if (state is CollectingErrorState) {
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
                        context.read<CollectUserInfoScreenBloc>().add(
                              CollectUserInfoEvent(
                                country: countryController.text,
                                state: stateController.text,
                                city: cityController.text,
                                area: areaController.text,
                                landmark: landmarkController.text,
                                pincode: pincodeController.text,
                                gender: genderController.text,
                                bio: bioController.text,
                                phone: phoneController.text,
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
            } else if (state is CollectingUserInfoState) {
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
            return buildBody(size, context);
          },
        ),
      ),
    );
  }

  SafeArea buildBody(
    Size size,
    BuildContext neededContext,
  ) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildHeader(size, neededContext),
              verticalSpace(height: 30),
              UserDetailsField(
                controller: countryController,
                labelName: "Country",
              ),
              verticalSpace(height: 30),
              UserDetailsField(
                controller: cityController,
                labelName: "City",
              ),
              verticalSpace(height: 30),
              UserDetailsField(
                controller: stateController,
                labelName: "State",
              ),
              verticalSpace(height: 30),
              UserDetailsField(
                controller: areaController,
                labelName: "Area",
              ),
              verticalSpace(height: 30),
              UserDetailsField(
                controller: landmarkController,
                labelName: "Landmark",
              ),
              verticalSpace(height: 30),
              UserDetailsField(
                controller: pincodeController,
                labelName: "Pincode",
              ),
              verticalSpace(height: 15),
              UserDetailsField(
                controller: bioController,
                labelName: "Bio",
              ),
              verticalSpace(height: 15),
              UserDetailsField(
                controller: genderController,
                labelName: "Gender",
              ),
              verticalSpace(height: 15),
              UserDetailsField(
                controller: phoneController,
                labelName: "Phone",
              ),
            ],
          ),
        ),
      ),
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
              Text(
                "User Details",
                style: TextStyle(
                  color: AppColors.colors.darkBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.colors.orange,
            ),
            onPressed: () {
              if (countryController.text.isNotEmpty &&
                  stateController.text.isNotEmpty &&
                  cityController.text.isNotEmpty &&
                  areaController.text.isNotEmpty &&
                  landmarkController.text.isNotEmpty &&
                  pincodeController.text.isNotEmpty &&
                  genderController.text.isNotEmpty &&
                  bioController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty) {
                neededContext.read<CollectUserInfoScreenBloc>().add(
                      CollectUserInfoEvent(
                        country: countryController.text,
                        state: stateController.text,
                        city: cityController.text,
                        area: areaController.text,
                        landmark: landmarkController.text,
                        pincode: pincodeController.text,
                        gender: genderController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                      ),
                    );
              }
            },
            child: Text(
              "Update",
              style: TextStyle(
                color: AppColors.colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
