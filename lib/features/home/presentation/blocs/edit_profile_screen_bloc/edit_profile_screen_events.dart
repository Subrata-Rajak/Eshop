abstract class EditProfileScreenEvents {}

class UpdateUserProfileInfoEvent extends EditProfileScreenEvents {
  final String name;
  final String bio;
  final String gender;
  final String phone;

  UpdateUserProfileInfoEvent({
    required this.name,
    required this.bio,
    required this.gender,
    required this.phone,
  });
}
