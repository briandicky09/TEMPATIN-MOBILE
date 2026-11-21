import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/user_model.dart';

class AuthResult {
  const AuthResult({required this.token, required this.user});

  final String token;
  final UserModel user;
}

class AuthMeResult {
  const AuthMeResult({
    required this.user,
    required this.unreadNotificationsCount,
    required this.unreadMessagesCount,
  });

  final UserModel user;
  final int unreadNotificationsCount;
  final int unreadMessagesCount;
}

/// Repository communicating with Laravel Sanctum `/api/v1/auth/*` endpoints.
class AuthRepository {
  const AuthRepository(this._dio);

  final Dio _dio;

  Future<AuthResult> login({
    required String email,
    required String password,
    String deviceName = 'tempatin-mobile',
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.login,
        data: {
          'email': email.trim(),
          'password': password,
          'device_name': deviceName,
        },
      );
      final data = _extractMap(response.data?['data']);
      return AuthResult(
        token: data['token'] as String? ?? '',
        user: UserModel.fromJson(_extractMap(data['user'])),
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<AuthResult> register({
    required String name,
    required String phone,
    required String email,
    required UserRole role,
    required String password,
    required String passwordConfirmation,
    bool agree = true,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.register,
        data: {
          'name': name.trim(),
          'phone': phone.trim(),
          'email': email.trim(),
          'role': role.name,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'agree': agree,
        },
      );
      final data = _extractMap(response.data?['data']);
      return AuthResult(
        token: data['token'] as String? ?? '',
        user: UserModel.fromJson(_extractMap(data['user'])),
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<String> forgotPassword({required String email}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.forgotPassword,
        data: {'email': email.trim()},
      );
      return response.data?['message'] as String? ??
          'Tautan reset kata sandi telah dikirim ke email Anda.';
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<String> resetPassword({
    required String token,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.resetPassword,
        data: {
          'token': token.trim(),
          'email': email.trim(),
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      return response.data?['message'] as String? ??
          'Kata sandi berhasil diperbarui. Silakan masuk.';
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<AuthMeResult> getMe() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(ApiEndpoints.me);
      final data = _extractMap(response.data?['data']);
      return AuthMeResult(
        user: UserModel.fromJson(_extractMap(data['user'])),
        unreadNotificationsCount:
            (data['unread_notifications_count'] as num?)?.toInt() ?? 0,
        unreadMessagesCount:
            (data['unread_messages_count'] as num?)?.toInt() ?? 0,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dio.post<void>(ApiEndpoints.logout);
    } on DioException catch (e) {
      // Ignore 401 when token is already invalidated.
      if (e.response?.statusCode != 401) {
        throw ErrorMapper.fromDio(e);
      }
    }
  }

  Map<String, dynamic> _extractMap(Object? raw) {
    if (raw is Map<String, dynamic>) return raw;
    throw const UnknownAppException('Format respons autentikasi tidak valid.');
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(ref.watch(dioProvider)),
);
