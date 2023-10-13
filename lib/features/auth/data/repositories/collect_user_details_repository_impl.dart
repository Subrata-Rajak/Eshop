import 'package:eshop/features/auth/data/data_source/remote/collect_user_details_service.dart';
import 'package:eshop/features/auth/domain/repositories/collect_user_details_repository.dart';

class CollectUserDetailsRepositoryImpl implements CollectUserDetailsRepository {
  final CollectUserDetailsService collectUserDetailsService;

  CollectUserDetailsRepositoryImpl({required this.collectUserDetailsService});

  @override
  Future<bool> updateUserDetails({
    required String country,
    required String state,
    required String city,
    required String area,
    required String pincode,
    required String landmark,
    required String bio,
    required String gender,
    required String phone,
  }) async {
    return await collectUserDetailsService.updateUserDetails(
      country: country,
      state: state,
      city: city,
      area: area,
      pincode: pincode,
      landmark: landmark,
      bio: bio,
      gender: gender,
      phone: phone,
    );
  }
}
