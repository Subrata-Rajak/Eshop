import 'package:eshop/features/address/domain/entities/address_entity.dart';

abstract class AddressDetailsScreenStates {}

class AddressDetailsScreenInitialState extends AddressDetailsScreenStates {}

class AddressDetailsFetchingState extends AddressDetailsScreenStates {}

class AddressDetailsSuccessfulState extends AddressDetailsScreenStates {
  final AddressesEntity? addressesEntity;

  AddressDetailsSuccessfulState({required this.addressesEntity});
}

class ADdressDetailsErrorState extends AddressDetailsScreenStates {}
