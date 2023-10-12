import 'package:eshop/features/address/domain/repositories/address_details_repository.dart';

class EditAddressUsecase {
  final AddressDetailsRepository addressDetailsRepository;

  EditAddressUsecase({required this.addressDetailsRepository});

  Future<bool> editAddress({
    required String country,
    required String city,
    required String state,
    required String area,
    required String landmark,
    required String pincode,
    required bool selected,
  }) async {
    return await addressDetailsRepository.editAddress(
      country: country,
      city: city,
      state: state,
      area: area,
      landmark: landmark,
      pincode: pincode,
      selected: selected,
    );
  }
}
