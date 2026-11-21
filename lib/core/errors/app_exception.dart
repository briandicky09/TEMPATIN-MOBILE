/// Typed application exceptions normalized from network, auth, and validation errors.
sealed class AppException implements Exception {
  const AppException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

final class NetworkException extends AppException {
  const NetworkException([
    super.message =
        'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
  ]);
}

final class TimeoutException extends AppException {
  const TimeoutException([
    super.message = 'Koneksi ke server terlalu lama. Silakan coba lagi.',
  ]);
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException([
    super.message = 'Sesi Anda telah berakhir. Silakan masuk kembali.',
  ]) : super(statusCode: 401);
}

final class ForbiddenException extends AppException {
  const ForbiddenException([
    super.message = 'Anda tidak memiliki izin untuk mengakses fitur ini.',
  ]) : super(statusCode: 403);
}

final class NotFoundException extends AppException {
  const NotFoundException([
    super.message = 'Data yang diminta tidak ditemukan.',
  ]) : super(statusCode: 404);
}

final class ValidationException extends AppException {
  const ValidationException(super.message, {this.fieldErrors = const {}})
    : super(statusCode: 422);

  final Map<String, List<String>> fieldErrors;

  String? firstErrorFor(String field) {
    final errors = fieldErrors[field];
    return (errors != null && errors.isNotEmpty) ? errors.first : null;
  }
}

final class ServerException extends AppException {
  const ServerException([
    super.message =
        'Terjadi kesalahan pada server. Silakan coba beberapa saat lagi.',
    int? statusCode,
  ]) : super(statusCode: statusCode);
}

final class UnknownAppException extends AppException {
  const UnknownAppException([
    super.message = 'Terjadi kesalahan yang tidak terduga.',
  ]);
}
