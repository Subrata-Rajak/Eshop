import 'package:eshop/features/address/domain/entities/address_entity.dart';

abstract class AddressDetailsRepository {
  Future<AddressesEntity?> getAddresses();
  Future<bool> addAddress({
    required String country,
    required String state,
    required String city,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  });
  Future<bool> editAddress({
    required String country,
    required String city,
    required String state,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  });
}
