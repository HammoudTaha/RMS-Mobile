import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../errors/exceptions.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage;
  const SecureStorage(this._secureStorage);
  Future<String> get({required String key}) async {
    String? value = await _secureStorage.read(key: key);
    if (value != null) {
      return value;
    } else {
      throw CachException(message: 'Something went wrong. Please try again');
    }
  }

  void set({required String value, required String key}) {
    _secureStorage.write(key: key, value: value);
  }

  void clearCach(String key) async {
    await _secureStorage.delete(key: key);
  }
}
