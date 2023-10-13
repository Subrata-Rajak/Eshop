import 'dart:io';

import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/auth/presentation/blocs/select_profile_image_screen_bloc/select_profile_image_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/select_profile_image_screen_bloc/select_profile_image_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/select_profile_image_screen_bloc/select_profile_image_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../injection_container.dart';

class SelectProfileImageUrlScreen extends StatefulWidget {
  const SelectProfileImageUrlScreen({super.key});

  @override
  State<SelectProfileImageUrlScreen> createState() =>
      _SelectProfileImageUrlScreenState();
}

class _SelectProfileImageUrlScreenState
    extends State<SelectProfileImageUrlScreen> with CommonWidgets {
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Select Profile Image",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(height: 30),
            selectedImage == null
                ? const CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/pictures/default_user.png"),
                    radius: 100,
                  )
                : CircleAvatar(
                    backgroundImage: FileImage(
                      File(selectedImage!.path),
                    ),
                    radius: 100,
                  ),
            verticalSpace(height: 30),
            BlocProvider<SelectProfileImageScreenBloc>(
              create: (context) => sl(),
              child: BlocConsumer<SelectProfileImageScreenBloc,
                  SelectProfileImageScreenStates>(
                builder: (context, state) {
                  if (state is UploadingImageState) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colors.orange,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                      onPressed: () {},
                      child: CircularProgressIndicator(
                        color: AppColors.colors.white,
                      ),
                    );
                  } else if (state is UploadingImageErrorState) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colors.orange,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                      onPressed: () async {
                        var res = await pickImageFromGallery();
                        if (res) {
                          context.read<SelectProfileImageScreenBloc>().add(
                                UploadImageEvent(selectedImage: selectedImage),
                              );
                        }
                      },
                      child: Text(
                        "Retry",
                        style: TextStyle(
                          color: AppColors.colors.white,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colors.orange,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                    ),
                    onPressed: () async {
                      var res = await pickImageFromGallery();
                      if (res) {
                        context.read<SelectProfileImageScreenBloc>().add(
                              UploadImageEvent(selectedImage: selectedImage),
                            );
                      }
                    },
                    child: Text(
                      "Select",
                      style: TextStyle(
                        color: AppColors.colors.white,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
                listener: (context, state) {
                  if (state is UploadingImageSuccessfulState) {
                    context.push(AppRoutePaths.paths.collectUserDetailsPath);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage != null) {
      setState(() {
        selectedImage = File(returnedImage.path);
      });
      return true;
    }

    return false;
  }
}
