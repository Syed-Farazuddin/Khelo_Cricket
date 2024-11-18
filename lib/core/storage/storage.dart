import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storageProvider = Provider<Storage>((ref) {
  return Storage();
});

class Storage {
  final _storage = const FlutterSecureStorage();

  void addItem({required String key, required String value}) {
    _storage.write(key: key, value: value);
  }

  void deleteAll() {
    _storage.deleteAll();
  }

  void deleteOne({required String key}) {
    _storage.delete(key: key);
  }

  void readAll() {
    _storage.readAll();
  }

  void read({required String key}) {
    _storage.read(key: key);
  }

  Future<bool> isLogin() async {
    String? token = await _storage.read(key: 'token');
    if (token != null) {
      return true;
    }
    return false;
  }
}
