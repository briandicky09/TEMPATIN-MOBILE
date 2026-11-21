import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/kos_models.dart';
import '../../../shared/models/owner_models.dart';
import '../../../shared/models/transaction_models.dart';

class OwnerKosPageResult {
  const OwnerKosPageResult({required this.items, required this.meta});

  final List<KosSummaryModel> items;
  final PaginationMeta meta;
}

class OwnerBookingsPageResult {
  const OwnerBookingsPageResult({
    required this.items,
    required this.counts,
    required this.meta,
  });

  final List<BookingModel> items;
  final OwnerBookingCountsModel counts;
  final PaginationMeta meta;
}

class OwnerReviewsPageResult {
  const OwnerReviewsPageResult({
    required this.items,
    required this.summary,
    required this.meta,
  });

  final List<ReviewModel> items;
  final OwnerRatingSummaryModel summary;
  final PaginationMeta meta;
}

/// Repository handling all Property Owner REST endpoints (`/api/v1/owner/*`).
class OwnerRepository {
  const OwnerRepository(this._dio);

  final Dio _dio;

  Future<OwnerDashboardModel> fetchDashboard() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerDashboard,
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return OwnerDashboardModel.fromJson(data);
      }
      throw const UnknownAppException('Format data dashboard tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<OwnerKosPageResult> fetchKosList({
    String? status,
    String? search,
    int page = 1,
    int perPage = 15,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerKos,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
          if (search != null && search.trim().isNotEmpty)
            'search': search.trim(),
        },
      );
      final items = _parseList(
        response.data?['data'],
        KosSummaryModel.fromJson,
      );
      final meta = _parseMeta(
        response.data?['meta'],
        page,
        perPage,
        items.length,
      );
      return OwnerKosPageResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<KosDetailModel> fetchKosDetail(String slug) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerKosDetail(slug),
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return KosDetailModel.fromJson(data);
      }
      throw const UnknownAppException('Format detail properti tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<KosDetailModel> saveKos({
    String? existingSlug,
    required String title,
    required String type,
    required String city,
    required double price,
    String? address,
    String? area,
    String? roomsSummary,
    String? bathrooms,
    String? bedrooms,
    String? garages,
    double? latitude,
    double? longitude,
    String? description,
    String? status,
    List<int> facilityIds = const [],
    File? thumbnailFile,
    List<File> photoFiles = const [],
    List<int> deletePhotoIds = const [],
  }) async {
    try {
      final map = <String, dynamic>{
        'title': title.trim(),
        'type': type,
        'city': city.trim(),
        'price': price.toStringAsFixed(0),
        if (address != null) 'address': address.trim(),
        if (area != null) 'area': area.trim(),
        if (roomsSummary != null) 'rooms': roomsSummary.trim(),
        if (bathrooms != null) 'bathrooms': bathrooms.trim(),
        if (bedrooms != null) 'bedrooms': bedrooms.trim(),
        if (garages != null) 'garages': garages.trim(),
        if (latitude != null) 'latitude': latitude.toString(),
        if (longitude != null) 'longitude': longitude.toString(),
        if (description != null) 'description': description.trim(),
        if (existingSlug != null && status != null) 'status': status,
      };

      if (facilityIds.isNotEmpty) {
        map['facilities[]'] = facilityIds;
      }
      if (deletePhotoIds.isNotEmpty) {
        map['delete_photos[]'] = deletePhotoIds;
      }
      if (thumbnailFile != null) {
        map['thumbnail'] = await MultipartFile.fromFile(thumbnailFile.path);
      }
      if (photoFiles.isNotEmpty) {
        map['photos[]'] = await Future.wait(
          photoFiles.map((file) => MultipartFile.fromFile(file.path)),
        );
      }

      final url = existingSlug == null
          ? ApiEndpoints.ownerKos
          : ApiEndpoints.ownerKosDetail(existingSlug);

      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: FormData.fromMap(map),
      );

      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return KosDetailModel.fromJson(data);
      }
      throw const UnknownAppException('Gagal menyimpan properti kos.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<void> deleteKos(String slug) async {
    try {
      await _dio.delete<Map<String, dynamic>>(
        ApiEndpoints.ownerKosDetail(slug),
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<List<RoomModel>> fetchRooms(String slug) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerKosRooms(slug),
      );
      return _parseList(response.data?['data'], RoomModel.fromJson);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<RoomModel> saveRoom({
    required String kosSlug,
    int? roomId,
    required String roomNumber,
    String? floor,
    String? roomType,
    double? priceOverride,
    required String status,
    String? notes,
  }) async {
    try {
      final payload = <String, dynamic>{
        'room_number': roomNumber.trim(),
        'floor': floor?.trim().isEmpty ?? true ? null : floor!.trim(),
        'room_type': roomType?.trim().isEmpty ?? true ? null : roomType!.trim(),
        'price_override': priceOverride,
        'status': status,
        'notes': notes?.trim().isEmpty ?? true ? null : notes!.trim(),
      };

      final response = roomId == null
          ? await _dio.post<Map<String, dynamic>>(
              ApiEndpoints.ownerKosRooms(kosSlug),
              data: payload,
            )
          : await _dio.put<Map<String, dynamic>>(
              ApiEndpoints.ownerKosRoom(kosSlug, roomId),
              data: payload,
            );

      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return RoomModel.fromJson(data);
      }
      throw const UnknownAppException('Gagal menyimpan data kamar.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<void> deleteRoom(String kosSlug, int roomId) async {
    try {
      await _dio.delete<Map<String, dynamic>>(
        ApiEndpoints.ownerKosRoom(kosSlug, roomId),
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<OwnerBookingsPageResult> fetchBookings({
    String? status,
    String? search,
    int page = 1,
    int perPage = 15,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerBookings,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
          if (search != null && search.trim().isNotEmpty)
            'search': search.trim(),
        },
      );
      final items = _parseList(response.data?['data'], BookingModel.fromJson);
      final rawCounts = response.data?['counts'];
      final counts = rawCounts is Map<String, dynamic>
          ? OwnerBookingCountsModel.fromJson(rawCounts)
          : const OwnerBookingCountsModel();
      final meta = _parseMeta(
        response.data?['meta'],
        page,
        perPage,
        items.length,
      );
      return OwnerBookingsPageResult(items: items, counts: counts, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<OwnerBookingDetailData> fetchBookingDetail(String code) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerBookingDetail(code),
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return OwnerBookingDetailData.fromJson(data);
      }
      throw const UnknownAppException(
        'Format detail booking owner tidak valid.',
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<BookingModel> approveBooking(String code, {int? roomId}) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.ownerBookingApprove(code),
        data: {'room_id': ?roomId},
      );
      return BookingModel.fromJson(
        response.data?['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<BookingModel> rejectBooking(String code, String reason) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.ownerBookingReject(code),
        data: {'rejection_reason': reason.trim()},
      );
      return BookingModel.fromJson(
        response.data?['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<BookingModel> checkInBooking(String code) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.ownerBookingCheckIn(code),
      );
      return BookingModel.fromJson(
        response.data?['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<BookingModel> checkOutBooking(String code) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.ownerBookingCheckOut(code),
      );
      return BookingModel.fromJson(
        response.data?['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<({List<BookingModel> items, PaginationMeta meta})> fetchTenants({
    String status = 'active',
    int page = 1,
    int perPage = 15,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerTenants,
        queryParameters: {'status': status, 'page': page, 'per_page': perPage},
      );
      final items = _parseList(response.data?['data'], BookingModel.fromJson);
      final meta = _parseMeta(
        response.data?['meta'],
        page,
        perPage,
        items.length,
      );
      return (items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<({List<SurveyModel> items, PaginationMeta meta})> fetchSurveys({
    String? status,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerSurveys,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
        },
      );
      final items = _parseList(response.data?['data'], SurveyModel.fromJson);
      final meta = _parseMeta(
        response.data?['meta'],
        page,
        perPage,
        items.length,
      );
      return (items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<SurveyModel> updateSurveyStatus(
    int id, {
    required String status,
    String? rejectionReason,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        ApiEndpoints.ownerSurveyStatus(id),
        data: {
          'status': status,
          if (rejectionReason != null && rejectionReason.trim().isNotEmpty)
            'rejection_reason': rejectionReason.trim(),
        },
      );
      return SurveyModel.fromJson(
        response.data?['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<({List<MaintenanceReportModel> items, PaginationMeta meta})>
  fetchMaintenance({String? status, int page = 1, int perPage = 20}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerMaintenance,
        queryParameters: {
          'page': page,
          'per_page': perPage,
          if (status != null && status.isNotEmpty && status != 'all')
            'status': status,
        },
      );
      final items = _parseList(
        response.data?['data'],
        MaintenanceReportModel.fromJson,
      );
      final meta = _parseMeta(
        response.data?['meta'],
        page,
        perPage,
        items.length,
      );
      return (items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<MaintenanceReportModel> updateMaintenanceStatus(
    int id, {
    required String status,
    String? ownerNotes,
  }) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        ApiEndpoints.ownerMaintenanceStatus(id),
        data: {
          'status': status,
          if (ownerNotes != null && ownerNotes.trim().isNotEmpty)
            'owner_notes': ownerNotes.trim(),
        },
      );
      return MaintenanceReportModel.fromJson(
        response.data?['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<OwnerReviewsPageResult> fetchReviews({
    int? kosId,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerReviews,
        queryParameters: {'page': page, 'per_page': perPage, 'kos_id': ?kosId},
      );
      final items = _parseList(response.data?['data'], ReviewModel.fromJson);
      final rawSummary = response.data?['rating_summary'];
      final summary = rawSummary is Map<String, dynamic>
          ? OwnerRatingSummaryModel.fromJson(rawSummary)
          : const OwnerRatingSummaryModel();
      final meta = _parseMeta(
        response.data?['meta'],
        page,
        perPage,
        items.length,
      );
      return OwnerReviewsPageResult(items: items, summary: summary, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<ReviewModel> replyReview(int reviewId, String reply) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.ownerReplyReview(reviewId),
        data: {'reply': reply.trim()},
      );
      return ReviewModel.fromJson(
        response.data?['data'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<OwnerAnalyticsModel> fetchAnalytics() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.ownerAnalytics,
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return OwnerAnalyticsModel.fromJson(data);
      }
      throw const UnknownAppException('Format analitik tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  List<T> _parseList<T>(
    dynamic raw,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (raw is! List) return const [];
    return raw.whereType<Map<String, dynamic>>().map(fromJson).toList();
  }

  PaginationMeta _parseMeta(dynamic rawMeta, int page, int perPage, int count) {
    return rawMeta is Map<String, dynamic>
        ? PaginationMeta.fromJson(rawMeta)
        : PaginationMeta(
            currentPage: page,
            lastPage: page,
            perPage: perPage,
            total: count,
          );
  }
}

final ownerRepositoryProvider = Provider<OwnerRepository>(
  (ref) => OwnerRepository(ref.watch(dioProvider)),
);
