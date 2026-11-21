import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/kos_models.dart';

class FavoriteToggleResult {
  const FavoriteToggleResult({
    required this.isFavorite,
    required this.favoritesCount,
  });

  final bool isFavorite;
  final int favoritesCount;
}

class PaginatedFavoritesResult {
  const PaginatedFavoritesResult({required this.items, required this.meta});

  final List<KosSummaryModel> items;
  final PaginationMeta meta;
}

/// Repository for customer saved wishlist (`GET /favorites`, `POST /favorites/toggle`).
class FavoritesRepository {
  const FavoritesRepository(this._dio);

  final Dio _dio;

  Future<PaginatedFavoritesResult> fetchFavorites({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.favorites,
        queryParameters: {'page': page, 'per_page': perPage},
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
      return PaginatedFavoritesResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<FavoriteToggleResult> toggleFavorite(String kosSlug) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.toggleFavorite,
        data: {'kos_slug': kosSlug},
      );
      final data = response.data?['data'] as Map<String, dynamic>? ?? const {};
      return FavoriteToggleResult(
        isFavorite: data['is_favorite'] as bool? ?? false,
        favoritesCount: (data['favorites_count'] as num?)?.toInt() ?? 0,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>(
  (ref) => FavoritesRepository(ref.watch(dioProvider)),
);
