import 'package:get_storage/get_storage.dart';

class GetBox {
  static final GetBox getBox = GetBox();

  final box = GetStorage();

  Future<void> writeToLocalDb({
    required String key,
    required value,
  }) async {
    await box.write(key, value);
  }

  dynamic readFromLocalDb({required String key}) {
    return box.read(key);
  }
}
