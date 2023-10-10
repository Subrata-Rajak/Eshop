import 'package:eshop/features/order_details/data/data_source/remote/selected_address_service.dart';
import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';
import 'package:eshop/features/order_details/domain/repositories/selected_address_repository.dart';

class SelectedADdressRepositoryImpl implements SelectedAddressRepository {
  final SelectedAddressService selectedAddressService;

  SelectedADdressRepositoryImpl({required this.selectedAddressService});

  @override
  Future<SelectedAddressEntity?> getSelectedAddress() async {
    return await selectedAddressService.getSelectedAddress();
  }
}
