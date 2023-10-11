import 'dart:async';

import 'package:eshop/features/home/domain/usecases/update_profile_info_usecase.dart';
import 'package:eshop/features/home/presentation/blocs/edit_profile_screen_bloc/edit_profile_screen_events.dart';
import 'package:eshop/features/home/presentation/blocs/edit_profile_screen_bloc/edit_profile_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreenBloc
    extends Bloc<EditProfileScreenEvents, EditProfileScreenStates> {
  final UpdateProfileInfoUsecase updateProfileInfoUsecase;

  EditProfileScreenBloc({
    required this.updateProfileInfoUsecase,
  }) : super(EditProfileScreenInitialState()) {
    on<UpdateUserProfileInfoEvent>(updateUserProfileInfo);
  }

  FutureOr<void> updateUserProfileInfo(
    UpdateUserProfileInfoEvent event,
    Emitter<EditProfileScreenStates> emit,
  ) async {
    emit(UpdatingProfileInfoState());

    try {
      var res = await updateProfileInfoUsecase.updateProfileInfo(
        name: event.name,
        bio: event.bio,
        gender: event.gender,
        phone: event.phone,
      );

      if (res) {
        emit(ProfileInfoUpdatingSuccessfulState());
      } else {
        emit(ProfileInfoUpdatingErrorState());
      }
    } catch (error) {
      print("Error while updating profile info -- Bloc: $error");
      emit(ProfileInfoUpdatingErrorState());
    }
  }
}
