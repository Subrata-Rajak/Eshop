import 'package:eshop/features/home/domain/repository/user_repository.dart';

class AddAddressUsecase {
  final UserRepoSitory userRepoSitory;

  AddAddressUsecase({required this.userRepoSitory});

  Future<bool> addAddress({
    required String email,
    required String country,
    required String state,
    required String city,
    required String landmark,
    required String pincode,
    required String area,
  }) {
    return userRepoSitory.addAddress(
      email: email,
      country: country,
      state: state,
      city: city,
      landmark: landmark,
      pincode: pincode,
      area: area,
    );
  }
}
