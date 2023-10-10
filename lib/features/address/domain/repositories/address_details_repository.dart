import 'package:eshop/features/address/domain/entities/address_entity.dart';

abstract class AddressDetailsRepository {
  Future<AddressesEntity?> getAddresses();
}
