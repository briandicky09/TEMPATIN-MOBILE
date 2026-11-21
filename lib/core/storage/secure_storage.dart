import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/storage_keys.dart';

/// Encrypted local storage wrapper for sensitive credentials (Sanctum tokens).
class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> readToken() => _storage.read(key: StorageKeys.authToken);

  Future<void> writeToken(String token) =>
      _storage.write(key: StorageKeys.authToken, value: token);

  Future<void> clearToken() => _storage.delete(key: StorageKeys.authToken);
}

final secureStorageProvider = Provider<SecureStorageService>(
  (ref) => const SecureStorageService(FlutterSecureStorage()),
);
