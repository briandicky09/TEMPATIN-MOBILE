import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/transaction_models.dart';

class PaginatedBookingsResult {
  const PaginatedBookingsResult({required this.items, required this.meta});

  final List<BookingModel> items;
  final PaginationMeta meta;
}

/// Customer booking repository (`GET/POST /api/v1/bookings`, cancel, nota PDF).
class BookingRepository {
  const BookingRepository(this._dio);

  final Dio _dio;

  Future<PaginatedBookingsResult> fetchBookings({
    String? status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.bookings,
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
                .map(BookingModel.fromJson)
                .toList()
          : <BookingModel>[];
      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );
      return PaginatedBookingsResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<BookingModel> createBooking({
    required String kosSlug,
    int? roomId,
    required String tenantName,
    required String tenantPhone,
    required String tenantEmail,
    required String startDate,
    required int durationMonths,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.bookings,
        data: {
          'kos_slug': kosSlug,
          'room_id': ?roomId,
          'tenant_name': tenantName.trim(),
          'tenant_phone': tenantPhone.trim(),
          'tenant_email': tenantEmail.trim(),
          'start_date': startDate,
          'duration_months': durationMonths,
          if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
        },
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return BookingModel.fromJson(raw);
      }
      throw const UnknownAppException('Format respons booking tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<BookingModel> fetchBookingDetail(String bookingCode) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.bookingDetail(bookingCode),
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return BookingModel.fromJson(raw);
      }
      throw const UnknownAppException('Format detail booking tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<BookingModel> cancelBooking(String bookingCode) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        ApiEndpoints.cancelBooking(bookingCode),
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return BookingModel.fromJson(raw);
      }
      throw const UnknownAppException('Format respons pembatalan tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<Uint8List> downloadNotaPdfBytes(String bookingCode) async {
    try {
      final response = await _dio.get<List<int>>(
        ApiEndpoints.bookingNotaPdf(bookingCode),
        options: Options(
          responseType: ResponseType.bytes,
          headers: const {'Accept': 'application/pdf'},
        ),
      );
      return Uint8List.fromList(response.data ?? const []);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => BookingRepository(ref.watch(dioProvider)),
);
