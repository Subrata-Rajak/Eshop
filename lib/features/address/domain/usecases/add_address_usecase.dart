import 'package:eshop/features/address/domain/repositories/address_details_repository.dart';

class AddAddressUsecase {
  final AddressDetailsRepository addressDetailsRepository;

  AddAddressUsecase({required this.addressDetailsRepository});

  Future<bool> addAddress({
    required String country,
    required String state,
    required String city,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  }) async {
    return addressDetailsRepository.addAddress(
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
