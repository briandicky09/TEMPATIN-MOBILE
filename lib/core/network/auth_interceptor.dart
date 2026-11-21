import 'package:dio/dio.dart';

import '../storage/secure_storage.dart';

/// Injects the Sanctum Bearer token and handles 401 session expiration cleanly.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.storage, required this.onUnauthorized});

  final SecureStorageService storage;
  final void Function() onUnauthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await storage.readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await storage.clearToken();
      onUnauthorized();
    }
    handler.next(err);
  }
}
