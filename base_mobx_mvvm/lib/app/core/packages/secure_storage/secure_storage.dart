import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AppSecureStorage {
  Future<String> read(String key);

  Future<Map<String, String>> readAll(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);

  Future<void> deleteAll(String key);
}
class AppSecureStorageImpl implements AppSecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future<String> read(String key) async => await _storage.read(key: key) ?? "";

  @override
  Future<Map<String, String>> readAll(String key) async => await _storage.readAll();

  @override
  Future<void> write(String key, String value) async => await _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) async => await _storage.delete(key: key);

  @override
  Future<void> deleteAll(String key) async => await _storage.deleteAll();
}
