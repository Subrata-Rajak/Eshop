import '../../home/data/models/user_model.dart' as usermodel;
import '../../home/domain/entity/user_entity.dart' as userentity;

class UserMapper {
  static userentity.UserEntity mapUserModelToEntity({
    required usermodel.User user,
  }) {
    return userentity.UserEntity(
      id: user.user.id,
      name: user.user.name,
      email: user.user.email,
      password: user.user.password,
      bio: user.user.bio,
      gender: user.user.gender,
      phone: user.user.phone,
      profileImageUrl: user.user.profileImageUrl,
      v: user.user.v,
      addresses: user.user.address
          .map(
            (address) => userentity.Address(
              country: address.country,
              state: address.state,
              city: address.city,
              area: address.area,
              landmark: address.landmark,
              pincode: address.pincode,
              id: address.id,
              selected: address.selected,
            ),
          )
          .toList(),
      reviewsAndRatings: user.user.reviewsAndRatings,
    );
  }

  static usermodel.User mapUserEntityToModel({
    required userentity.UserEntity entity,
  }) {
    return usermodel.User(
        user: usermodel.UserClass(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      password: entity.password,
      reviewsAndRatings: entity.reviewsAndRatings,
      bio: entity.bio,
      gender: entity.gender,
      phone: entity.phone,
      address: entity.addresses
          .map(
            (address) => usermodel.Address(
              country: address.country,
              state: address.state,
              city: address.city,
              area: address.area,
              landmark: address.landmark,
              id: address.id,
              pincode: address.pincode,
              selected: address.selected,
            ),
          )
          .toList(),
      v: entity.v,
      profileImageUrl: entity.profileImageUrl,
    ));
  }
}
