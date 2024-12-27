import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  final GetStorage storage = GetStorage();

  // Initialize GetStorage
  static Future<void> init() async {
    await GetStorage.init();
  }

  Future<void> write(String key, dynamic value) async {
    await storage.write(key, value);
  }

  T? read<T>(String key) {
    return storage.read<T>(key);
  }

  Future<void> remove(String key) async {
    await storage.remove(key);
  }

  Future<void> clear() async {
    await storage.erase();
  }

  bool hasKey(String key) {
    return
      storage.hasData(key);
  }
}
