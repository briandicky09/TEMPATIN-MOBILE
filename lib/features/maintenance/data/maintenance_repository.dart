import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/transaction_models.dart';

class PaginatedMaintenanceResult {
  const PaginatedMaintenanceResult({required this.items, required this.meta});

  final List<MaintenanceReportModel> items;
  final PaginationMeta meta;
}

class MaintenanceRepository {
  const MaintenanceRepository(this._dio);

  final Dio _dio;

  Future<PaginatedMaintenanceResult> fetchReports({
    String? status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.maintenanceReports,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty) 'status': status,
        },
      );
      final rawList = response.data?['data'];
      final rawMeta = response.data?['meta'];
      final items = rawList is List
          ? rawList
                .whereType<Map<String, dynamic>>()
                .map(MaintenanceReportModel.fromJson)
                .toList()
          : <MaintenanceReportModel>[];
      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );
      return PaginatedMaintenanceResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<MaintenanceReportModel> submitReport({
    required int bookingId,
    required String title,
    required String description,
    File? photoFile,
  }) async {
    try {
      File? uploadFile = photoFile;
      if (photoFile != null) {
        uploadFile = await _compressPhoto(photoFile);
      }

      final formData = FormData.fromMap({
        'booking_id': bookingId,
        'title': title.trim(),
        'description': description.trim(),
        if (uploadFile != null)
          'photo': await MultipartFile.fromFile(
            uploadFile.path,
            filename: 'maintenance.jpg',
          ),
      });

      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.maintenanceReports,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return MaintenanceReportModel.fromJson(raw);
      }
      throw const UnknownAppException('Format laporan kerusakan tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<File> _compressPhoto(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final outPath =
          '${dir.path}/maint_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final compressed = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        outPath,
        quality: 80,
        minWidth: 1200,
        minHeight: 1200,
        format: CompressFormat.jpeg,
      );
      if (compressed != null) return File(compressed.path);
    } catch (_) {
      // Fallback to original file if platform compressor unavailable.
    }
    return file;
  }
}

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>(
  (ref) => MaintenanceRepository(ref.watch(dioProvider)),
);
