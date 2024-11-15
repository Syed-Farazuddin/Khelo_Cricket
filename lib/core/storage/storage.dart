import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
}
