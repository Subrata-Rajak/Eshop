import 'dart:async';

import 'package:eshop/features/address/presentation/blocs/add_address_screen_bloc/add_address_screen_events.dart';
import 'package:eshop/features/address/presentation/blocs/add_address_screen_bloc/add_address_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/add_address_usecase.dart';

class AddAddressScreenBloc
    extends Bloc<AddAddressScreenEvents, AddAddressScreenStates> {
  final AddAddressUsecase addAddressUsecase;
  AddAddressScreenBloc({required this.addAddressUsecase})
      : super(AddAddressScreenInitialStates()) {
    on<AddAddressEvent>(addAddress);
  }

  FutureOr<void> addAddress(
    AddAddressEvent event,
    Emitter<AddAddressScreenStates> emit,
  ) async {
    emit(AddingAddressState());

    try {
      var res = await addAddressUsecase.addAddress(
        country: event.country,
        state: event.state,
        city: event.city,
        landmark: event.landmark,
        pincode: event.pincode,
        area: event.area,
        selected: event.selected,
      );

      if (res) {
        emit(AddingSuccessfulState());
      } else {
        emit(AddingErrorState());
      }
    } catch (error) {
      print("Error while adding address -- Bloc: $error");
      emit(AddingErrorState());
    }
  }
}
