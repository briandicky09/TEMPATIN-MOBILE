import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/transaction_models.dart';

class PaginatedSurveysResult {
  const PaginatedSurveysResult({required this.items, required this.meta});

  final List<SurveyModel> items;
  final PaginationMeta meta;
}

class SurveyRepository {
  const SurveyRepository(this._dio);

  final Dio _dio;

  Future<PaginatedSurveysResult> fetchSurveys({
    String? status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.surveys,
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
                .map(SurveyModel.fromJson)
                .toList()
          : <SurveyModel>[];
      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );
      return PaginatedSurveysResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<SurveyModel> scheduleSurvey({
    required String kosSlug,
    required String surveyDate,
    required String surveyTime,
    String? notes,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.scheduleSurvey(kosSlug),
        data: {
          'survey_date': surveyDate,
          'survey_time': surveyTime,
          if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
        },
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return SurveyModel.fromJson(raw);
      }
      throw const UnknownAppException('Format survei tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<SurveyModel> cancelSurvey(int id) async {
    try {
      final response = await _dio.patch<Map<String, dynamic>>(
        ApiEndpoints.cancelSurvey(id),
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return SurveyModel.fromJson(raw);
      }
      throw const UnknownAppException('Format pembatalan survei tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final surveyRepositoryProvider = Provider<SurveyRepository>(
  (ref) => SurveyRepository(ref.watch(dioProvider)),
);
