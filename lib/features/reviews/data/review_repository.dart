import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/kos_models.dart';

class ReviewRepository {
  const ReviewRepository(this._dio);

  final Dio _dio;

  Future<ReviewModel> submitReview({
    required String kosSlug,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.kosReviews(kosSlug),
        data: {'rating': rating, 'comment': comment.trim()},
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return ReviewModel.fromJson(raw);
      }
      throw const UnknownAppException('Format ulasan tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final reviewRepositoryProvider = Provider<ReviewRepository>(
  (ref) => ReviewRepository(ref.watch(dioProvider)),
);
