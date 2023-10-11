import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/features/home/presentation/blocs/edit_profile_screen_bloc/edit_profile_screen_bloc.dart';
import 'package:eshop/features/home/presentation/blocs/edit_profile_screen_bloc/edit_profile_screen_events.dart';
import 'package:eshop/features/home/presentation/blocs/edit_profile_screen_bloc/edit_profile_screen_states.dart';
import 'package:eshop/features/home/presentation/widgets/custom_edit_profile_field.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../config/routes/route_names.dart';
import '../../../../config/routes/route_paths.dart';
import '../../../../core/values/colors.dart';

class EditProfileScreen extends StatefulWidget {
  final EditProfileScreenArgs args;
  const EditProfileScreen({
    super.key,
    required this.args,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with CommonWidgets {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.args.user!.name;
    bioController.text = widget.args.user!.bio;
    genderController.text = widget.args.user!.gender;
    phoneController.text = widget.args.user!.phone;
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    genderController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<EditProfileScreenBloc>(
        create: (context) => sl(),
        child: BlocConsumer<EditProfileScreenBloc, EditProfileScreenStates>(
          listener: (context, state) {
            if (state is ProfileInfoUpdatingSuccessfulState) {
              while (context.canPop()) {
                final currentRoute = ModalRoute.of(context);
                if (currentRoute?.settings.name ==
                    AppRouteNames.names.homeRouteName) {
                  break;
                }
                context.pop();
              }
              context.replace(AppRoutePaths.paths.homePath);
            }
          },
          builder: (context, state) {
            if (state is ProfileInfoUpdatingErrorState) {
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
            } else if (state is UpdatingProfileInfoState) {
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
              CustomEditProfileField(
                controller: nameController,
                labelName: "Name",
              ),
              verticalSpace(height: 15),
              CustomEditProfileField(
                controller: bioController,
                labelName: "Bio",
              ),
              verticalSpace(height: 15),
              CustomEditProfileField(
                controller: genderController,
                labelName: "Gender",
              ),
              verticalSpace(height: 15),
              CustomEditProfileField(
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
              GestureDetector(
                onTap: () {
                  if (nameController.text != widget.args.user!.name ||
                      bioController.text != widget.args.user!.bio ||
                      genderController.text != widget.args.user!.gender ||
                      phoneController.text != widget.args.user!.phone) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Are you sure?"),
                          content: const Text(
                            "You haven't saved the changes. Are you sure, you want to exit??",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.pop();
                                context.pop();
                              },
                              child: const Text("Exit"),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                                neededContext.read<EditProfileScreenBloc>().add(
                                      UpdateUserProfileInfoEvent(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        gender: genderController.text,
                                        phone: phoneController.text,
                                      ),
                                    );
                              },
                              child: const Text("Update"),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    context.pop();
                  }
                },
                child: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: AppColors.colors.darkBlue,
                ),
              ),
              horizontalSpace(width: 20),
              Text(
                "Edit Profile",
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
              neededContext.read<EditProfileScreenBloc>().add(
                    UpdateUserProfileInfoEvent(
                      name: nameController.text,
                      bio: bioController.text,
                      gender: genderController.text,
                      phone: phoneController.text,
                    ),
                  );
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
