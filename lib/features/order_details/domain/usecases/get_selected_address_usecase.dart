import 'package:eshop/features/order_details/domain/entities/selected_address_entity.dart';
import 'package:eshop/features/order_details/domain/repositories/selected_address_repository.dart';

class GetSelectedAddressUsecase {
  final SelectedAddressRepository selectedAddressRepository;

  GetSelectedAddressUsecase({required this.selectedAddressRepository});

  Future<SelectedAddressEntity?> getSElectedAddress() async {
    return await selectedAddressRepository.getSelectedAddress();
  }
}
