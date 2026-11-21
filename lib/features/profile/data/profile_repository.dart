import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/user_model.dart';

/// Repository for viewing and updating user profile (`GET/POST /api/v1/profile`).
class ProfileRepository {
  const ProfileRepository(this._dio);

  final Dio _dio;

  Future<UserModel> fetchProfile() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.profile,
      );
      final data = response.data?['data'] as Map<String, dynamic>? ?? const {};
      final userJson = data['user'] ?? data;
      if (userJson is Map<String, dynamic>) {
        return UserModel.fromJson(userJson);
      }
      throw const UnknownAppException('Format profil tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<UserModel> updateProfile({
    required String name,
    String? phone,
    File? avatarFile,
    String? currentPassword,
    String? password,
    String? passwordConfirmation,
  }) async {
    try {
      File? uploadFile = avatarFile;
      if (avatarFile != null) {
        uploadFile = await _compressAvatar(avatarFile);
      }

      final formMap = <String, dynamic>{
        'name': name.trim(),
        if (phone != null) 'phone': phone.trim(),
        if (currentPassword != null && currentPassword.isNotEmpty)
          'current_password': currentPassword,
        if (password != null && password.isNotEmpty) ...{
          'password': password,
          'password_confirmation': passwordConfirmation ?? '',
        },
        if (uploadFile != null)
          'avatar': await MultipartFile.fromFile(
            uploadFile.path,
            filename: 'avatar.jpg',
          ),
      };

      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.profile,
        data: FormData.fromMap(formMap),
        options: Options(contentType: 'multipart/form-data'),
      );

      final data = response.data?['data'] as Map<String, dynamic>? ?? const {};
      final userJson = data['user'] ?? data;
      if (userJson is Map<String, dynamic>) {
        return UserModel.fromJson(userJson);
      }
      throw const UnknownAppException(
        'Format respons pembaruan profil tidak valid.',
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<File> _compressAvatar(File file) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath =
          '${tempDir.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 82,
        minWidth: 800,
        minHeight: 800,
        format: CompressFormat.jpeg,
      );
      if (result != null) return File(result.path);
    } catch (_) {
      // Fallback to original file if platform compressor is unavailable (e.g. unit test).
    }
    return file;
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(dioProvider)),
);
