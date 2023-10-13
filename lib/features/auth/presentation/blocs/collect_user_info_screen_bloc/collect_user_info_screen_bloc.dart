import 'dart:async';

import 'package:eshop/features/auth/domain/usecases/collect_user_details_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/collect_user_info_screen_bloc/collect_user_info_screen_events.dart';
import 'package:eshop/features/auth/presentation/blocs/collect_user_info_screen_bloc/collect_user_info_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectUserInfoScreenBloc
    extends Bloc<CollectUserInfoScreenEvents, CollectUserInfoScreenStates> {
  final CollectUserDetailsUsecase collectUserDetailsUsecase;

  CollectUserInfoScreenBloc({required this.collectUserDetailsUsecase})
      : super(CollectUserInfoScreenInitialState()) {
    on<CollectUserInfoEvent>(collectUserDetails);
  }

  FutureOr<void> collectUserDetails(
    CollectUserInfoEvent event,
    Emitter<CollectUserInfoScreenStates> emit,
  ) async {
    emit(CollectingUserInfoState());

    try {
      var res = await collectUserDetailsUsecase.updateUserDetails(
        country: event.country,
        state: event.state,
        city: event.city,
        area: event.area,
        pincode: event.pincode,
        landmark: event.landmark,
        bio: event.bio,
        gender: event.gender,
        phone: event.phone,
      );

      if (res) {
        emit(CollectingSuccessfulState());
      } else {
        emit(CollectingErrorState());
      }
    } catch (error) {
      print("Error while collecting user info -- BLOC: $error");
      emit(CollectingErrorState());
    }
  }
}
