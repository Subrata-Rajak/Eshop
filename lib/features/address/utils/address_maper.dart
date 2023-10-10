import 'package:eshop/features/address/data/models/address_model.dart';
import 'package:eshop/features/address/domain/entities/address_entity.dart';

class AddressMapper {
  static AddressesModel mapEntityToModel({
    required AddressesEntity addressesEntity,
  }) {
    var addressList = addressesEntity.addresses
        .map(
          (address) => Address(
            country: address.country,
            state: address.state,
            city: address.city,
            area: address.area,
            landmark: address.landmark,
            pincode: address.pincode,
            selected: address.selected,
            id: address.id,
          ),
        )
        .toList();

    return AddressesModel(addresses: addressList);
  }

  static AddressesEntity mapModelToEntity(
      {required AddressesModel addressesModel}) {
    var addressList = addressesModel.addresses
        .map(
          (address) => AddressEntity(
            country: address.country,
            state: address.state,
            city: address.city,
            area: address.area,
            landmark: address.landmark,
            pincode: address.pincode,
            selected: address.selected,
            id: address.id,
          ),
        )
        .toList();

    return AddressesEntity(addresses: addressList);
  }
}
