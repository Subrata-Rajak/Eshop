import 'dart:async';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:eshop/features/auth/domain/usecases/upload_image_url_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/select_profile_image_screen_bloc/select_profile_image_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/select_profile_image_screen_bloc/select_profile_image_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectProfileImageScreenBloc extends Bloc<SelectProfileImageScreenEvents,
    SelectProfileImageScreenStates> {
  final UploadImageUrlUsecase uploadImageUrlUsecase;
  SelectProfileImageScreenBloc({required this.uploadImageUrlUsecase})
      : super(SelectProfileImageScreenInitialState()) {
    on<UploadImageEvent>(uploadImage);
  }

  FutureOr<void> uploadImage(
    UploadImageEvent event,
    Emitter<SelectProfileImageScreenStates> emit,
  ) async {
    emit(UploadingImageState());

    try {
      final cloudinary = CloudinaryPublic("dpbolttxw", "mq7nhqwr");
      CloudinaryResponse cloudinaryRes = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(event.selectedImage!.path),
      );

      print(cloudinaryRes.secureUrl);

      var res = await uploadImageUrlUsecase.uploadProfileImageUrl(
        url: cloudinaryRes.secureUrl,
      );

      if (res) {
        emit(UploadingImageSuccessfulState());
      } else {
        emit(UploadingImageErrorState());
      }
    } catch (error) {
      print("Error while uploading image -- BLOC: $error");
      emit(UploadingImageErrorState());
    }
  }
}
