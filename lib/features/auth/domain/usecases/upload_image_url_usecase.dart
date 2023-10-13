import 'package:eshop/features/auth/domain/repositories/upload_profile_image_url_repository.dart';

class UploadImageUrlUsecase {
  final UploadProfileImageUrlRepository uploadProfileImageUrlRepository;

  UploadImageUrlUsecase({required this.uploadProfileImageUrlRepository});

  Future<bool> uploadProfileImageUrl({required String url}) async {
    return await uploadProfileImageUrlRepository.updateImageUrl(url: url);
  }
}
