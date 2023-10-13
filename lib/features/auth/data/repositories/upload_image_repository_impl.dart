import 'package:eshop/features/auth/data/data_source/remote/upload_image_url_service.dart';
import 'package:eshop/features/auth/domain/repositories/upload_profile_image_url_repository.dart';

class UploadImageRepositoryImpl implements UploadProfileImageUrlRepository {
  final UploadImageService uploadImageService;

  UploadImageRepositoryImpl({required this.uploadImageService});

  @override
  Future<bool> updateImageUrl({required String url}) async {
    return await uploadImageService.uploadImageUrl(imageUrl: url);
  }
}
