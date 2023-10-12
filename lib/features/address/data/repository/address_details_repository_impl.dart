import 'package:eshop/features/address/data/data_source/remote/address_details_service.dart';
import 'package:eshop/features/address/domain/entities/address_entity.dart';
import 'package:eshop/features/address/domain/repositories/address_details_repository.dart';

class AddressDetailsRepositoryImpl implements AddressDetailsRepository {
  final AddressDetailsService addressDetailsService;

  AddressDetailsRepositoryImpl({required this.addressDetailsService});

  @override
  Future<AddressesEntity?> getAddresses() async {
    return await addressDetailsService.getAddresses();
  }

  @override
  Future<bool> addAddress({
    required String country,
    required String state,
    required String city,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  }) async {
    return await addressDetailsService.addAddress(
      country: country,
      state: state,
      city: city,
      area: area,
      landmark: landmark,
      pincode: pincode,
      selected: selected,
    );
  }

  @override
  Future<bool> editAddress({
    required String country,
    required String city,
    required String state,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  }) async {
    return await addressDetailsService.editAddress(
      country: country,
      state: state,
      city: city,
      area: area,
      landmark: landmark,
      pincode: pincode,
      selected: selected,
    );
  }
}
