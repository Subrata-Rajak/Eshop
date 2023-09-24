import 'dart:async';

import 'package:eshop/features/home/domain/usecases/get_user_info_usecase.dart';
import 'package:eshop/features/home/presentation/blocs/profile_screen_bloc/profile_screen_events.dart';
import 'package:eshop/features/home/presentation/blocs/profile_screen_bloc/profile_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entity/user_entity.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvents, ProfileScreenStates> {
  GetUserInfoUsecase getUserInfoUsecase;
  ProfileScreenBloc({required this.getUserInfoUsecase})
      : super(ProfileScreenInitialState()) {
    on<ProfileScreenDataFetchingEvent>(fetchProfileData);
  }

  FutureOr<void> fetchProfileData(
    ProfileScreenDataFetchingEvent event,
    Emitter<ProfileScreenStates> emit,
  ) async {
    emit(ProfileScreenFetchingDataState());
    try {
      UserEntity? user = await getUserInfoUsecase.getUserInfo();
      if (user != null) {
        emit(ProfileScreenDataFetchingSuccessState(user: user));
      } else {
        emit(ProfileScreenSataFetchingErrorState());
      }
    } catch (error) {
      print(
          "Error while fetching user details in profile screen -- Bloc : $error");
      emit(ProfileScreenSataFetchingErrorState());
    }
  }
}
