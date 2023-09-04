import 'package:get_storage/get_storage.dart';

class GetBox {
  static final GetBox getBox = GetBox();

  final box = GetStorage();

  writeToLocalDb({
    required String key,
    required value,
  }) {
    box.write(key, value);
  }

  readFromLocalDb({required String key}) {
    return box.read(key);
  }
}
