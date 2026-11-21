import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/facility_model.dart';
import '../../../shared/models/kos_models.dart';
import '../domain/kos_filter.dart';

class PaginatedKosResult {
  const PaginatedKosResult({required this.items, required this.meta});

  final List<KosSummaryModel> items;
  final PaginationMeta meta;
}

class PaginatedReviewsResult {
  const PaginatedReviewsResult({required this.items, required this.meta});

  final List<ReviewModel> items;
  final PaginationMeta meta;
}

/// Repository for searching kos, fetching details, facilities, and reviews.
class PropertyRepository {
  const PropertyRepository(this._dio);

  final Dio _dio;

  Future<List<FacilityModel>> fetchFacilities() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.facilities,
      );
      final raw = response.data?['data'];
      if (raw is List) {
        return raw
            .whereType<Map<String, dynamic>>()
            .map(FacilityModel.fromJson)
            .toList();
      }
      return const [];
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<PaginatedKosResult> searchKos({
    required KosFilter filter,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kosList,
        queryParameters: filter.toQueryParams(page: page, perPage: perPage),
      );
      final rawList = response.data?['data'];
      final rawMeta = response.data?['meta'];
      final items = rawList is List
          ? rawList
                .whereType<Map<String, dynamic>>()
                .map(KosSummaryModel.fromJson)
                .toList()
          : <KosSummaryModel>[];
      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );
      return PaginatedKosResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<KosDetailModel> fetchKosDetail(String slug) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kosDetail(slug),
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return KosDetailModel.fromJson(raw);
      }
      throw const UnknownAppException('Format detail kos tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<PaginatedReviewsResult> fetchReviews({
    required String slug,
    int? rating,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.kosReviews(slug),
        queryParameters: {'page': page, 'per_page': perPage, 'rating': ?rating},
      );
      final rawList = response.data?['data'];
      final rawMeta = response.data?['meta'];
      final items = rawList is List
          ? rawList
                .whereType<Map<String, dynamic>>()
                .map(ReviewModel.fromJson)
                .toList()
          : <ReviewModel>[];
      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );
      return PaginatedReviewsResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final propertyRepositoryProvider = Provider<PropertyRepository>(
  (ref) => PropertyRepository(ref.watch(dioProvider)),
);
