import 'dart:async';

import 'package:eshop/features/address/domain/usecases/edit_address_usecase.dart';
import 'package:eshop/features/address/presentation/blocs/edit_address_screen_bloc/edit_address_screen_events.dart';
import 'package:eshop/features/address/presentation/blocs/edit_address_screen_bloc/edit_address_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditAddressScreenBloc
    extends Bloc<EditAddressScreenEvents, EditAddressScreenStates> {
  final EditAddressUsecase editAddressUsecase;

  EditAddressScreenBloc({required this.editAddressUsecase})
      : super(EditAddressScreenInitialState()) {
    on<EditAddressEvent>(editAddress);
  }

  FutureOr<void> editAddress(
    EditAddressEvent event,
    Emitter<EditAddressScreenStates> emit,
  ) async {
    emit(EditingAddressState());

    try {
      var res = await editAddressUsecase.editAddress(
        country: event.country,
        city: event.city,
        state: event.state,
        area: event.area,
        landmark: event.landmark,
        pincode: event.pincode,
        selected: event.selected,
      );

      if (res) {
        emit(EditingSuccessfulState());
      } else {
        emit(EditingErrorState());
      }
    } catch (error) {
      print("Error while editing address -- Bloc: $error");
      emit(EditingErrorState());
    }
  }
}
