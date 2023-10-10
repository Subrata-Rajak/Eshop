import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';

abstract class SelectedAddressRepository {
  Future<SelectedAddressEntity?> getSelectedAddress();
}
