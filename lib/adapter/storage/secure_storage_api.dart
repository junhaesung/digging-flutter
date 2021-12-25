import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  const TokenStorage();

  final _storage = const FlutterSecureStorage();
  final _key = 'DIGGING_API_ACCESS_TOKEN';

  Future<String?> read() async {
    final value = await _storage.read(
      key: _key,
      aOptions: _getAndroidOptions(),
    );
    return value;
  }

  Future<void> write(String accessToken) async {
    await _storage.write(
      key: _key,
      value: accessToken,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<void> delete() async {
    await _storage.delete(
      key: _key,
      aOptions: _getAndroidOptions(),
    );
  }

  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }
}
