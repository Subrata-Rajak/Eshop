import 'dart:io';

abstract class SelectProfileImageScreenEvents {}

class UploadImageEvent extends SelectProfileImageScreenEvents {
  File? selectedImage;

  UploadImageEvent({required this.selectedImage});
}
