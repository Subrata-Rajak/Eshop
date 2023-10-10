import 'package:eshop/features/address/domain/entities/address_entity.dart';
import 'package:eshop/features/address/domain/repositories/address_details_repository.dart';

class GetAddressesUsecase {
  final AddressDetailsRepository addressDetailsRepository;

  GetAddressesUsecase({required this.addressDetailsRepository});

  Future<AddressesEntity?> getAddresses() async {
    return await addressDetailsRepository.getAddresses();
  }
}
