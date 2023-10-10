import 'dart:async';

import 'package:eshop/features/address/domain/entities/address_entity.dart';
import 'package:eshop/features/address/domain/usecases/get_addresses_usecase.dart';
import 'package:eshop/features/address/presentation/blocs/address_details_screen_bloc/address_details_screen_events.dart';
import 'package:eshop/features/address/presentation/blocs/address_details_screen_bloc/address_details_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDetailsScreenBloc
    extends Bloc<AddressDetailsScreenEvents, AddressDetailsScreenStates> {
  final GetAddressesUsecase getAddressesUsecase;

  AddressDetailsScreenBloc({required this.getAddressesUsecase})
      : super(AddressDetailsScreenInitialState()) {
    on<AddressDetailsFetchEvent>(fetchAddressDetails);
  }

  FutureOr<void> fetchAddressDetails(
    AddressDetailsFetchEvent event,
    Emitter<AddressDetailsScreenStates> emit,
  ) async {
    emit(AddressDetailsFetchingState());

    try {
      AddressesEntity? res = await getAddressesUsecase.getAddresses();

      if (res != null) {
        emit(
          AddressDetailsSuccessfulState(
            addressesEntity: res,
          ),
        );
      } else {
        emit(ADdressDetailsErrorState());
      }
    } catch (error) {
      print(
          "Error while fetching address details -- Address details screen bloc");
      emit(ADdressDetailsErrorState());
    }
  }
}
