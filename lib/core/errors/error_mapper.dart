import 'package:dio/dio.dart';

import 'app_exception.dart';

/// Maps low-level DioException responses to typed, user-friendly Indonesian AppExceptions.
abstract final class ErrorMapper {
  static AppException fromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        return _fromResponse(error.response);
      case DioExceptionType.cancel:
        return const UnknownAppException('Permintaan dibatalkan.');
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const NetworkException();
    }
  }

  static AppException _fromResponse(Response<dynamic>? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;
    final serverMessage =
        data is Map<String, dynamic> && data['message'] is String
        ? data['message'] as String
        : null;

    switch (statusCode) {
      case 401:
        return UnauthorizedException(
          serverMessage ?? 'Sesi Anda telah berakhir. Silakan masuk kembali.',
        );
      case 403:
        return ForbiddenException(
          serverMessage ??
              'Anda tidak memiliki izin untuk mengakses fitur ini.',
        );
      case 404:
        return NotFoundException(
          serverMessage ?? 'Data yang diminta tidak ditemukan.',
        );
      case 422:
        final fieldErrors = <String, List<String>>{};
        if (data is Map<String, dynamic> && data['errors'] is Map) {
          final rawErrors = data['errors'] as Map<dynamic, dynamic>;
          for (final entry in rawErrors.entries) {
            if (entry.value is List) {
              fieldErrors[entry.key.toString()] = (entry.value as List)
                  .map((e) => e.toString())
                  .toList();
            }
          }
        }
        return ValidationException(
          serverMessage ?? 'Periksa kembali data yang Anda masukkan.',
          fieldErrors: fieldErrors,
        );
      default:
        return ServerException(
          serverMessage ??
              'Terjadi kesalahan pada server. Silakan coba beberapa saat lagi.',
          statusCode,
        );
    }
  }
}
