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
}
