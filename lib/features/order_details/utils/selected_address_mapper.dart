import 'package:eshop/features/order_details/data/models/selected_address_model.dart';
import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';

class SelectedAddressMapper {
  static SelectedAddressEntity mapModelToEntity({
    required SelectedAddress selectedAddress,
  }) {
    return SelectedAddressEntity(
      selectedAddressClassEntity: SelectedAddressClassEntity(
        area: selectedAddress.selectedAddress.area,
        city: selectedAddress.selectedAddress.city,
        country: selectedAddress.selectedAddress.country,
        id: selectedAddress.selectedAddress.id,
        landmark: selectedAddress.selectedAddress.landmark,
        pincode: selectedAddress.selectedAddress.pincode,
        selected: selectedAddress.selectedAddress.selected,
        state: selectedAddress.selectedAddress.state,
      ),
    );
  }

  static SelectedAddress mapEntityToModel({
    required SelectedAddressEntity selectedAddressEntity,
  }) {
    return SelectedAddress(
      selectedAddress: SelectedAddressClass(
        area: selectedAddressEntity.selectedAddressClassEntity.area,
        city: selectedAddressEntity.selectedAddressClassEntity.city,
        country: selectedAddressEntity.selectedAddressClassEntity.country,
        id: selectedAddressEntity.selectedAddressClassEntity.id,
        landmark: selectedAddressEntity.selectedAddressClassEntity.landmark,
        pincode: selectedAddressEntity.selectedAddressClassEntity.pincode,
        selected: selectedAddressEntity.selectedAddressClassEntity.selected,
        state: selectedAddressEntity.selectedAddressClassEntity.state,
      ),
    );
  }
}
