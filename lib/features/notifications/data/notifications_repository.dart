import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/notification_model.dart';

class PaginatedNotificationsResult {
  const PaginatedNotificationsResult({
    required this.items,
    required this.unreadCount,
    required this.meta,
  });

  final List<AppNotificationModel> items;
  final int unreadCount;
  final PaginationMeta meta;
}

/// Repository for database notifications (`GET/POST /api/v1/notifications/*`).
class NotificationsRepository {
  const NotificationsRepository(this._dio);

  final Dio _dio;

  Future<PaginatedNotificationsResult> fetchNotifications({
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.notifications,
        queryParameters: {'page': page, 'per_page': perPage},
      );
      final rawData = response.data?['data'];
      final rawMeta = response.data?['meta'];

      List<dynamic> rawList = const [];
      int unreadCount = 0;

      if (rawData is Map<String, dynamic>) {
        rawList =
            (rawData['items'] as List?) ??
            (rawData['notifications'] as List?) ??
            const [];
        unreadCount = (rawData['unread_count'] as num?)?.toInt() ?? 0;
      } else if (rawData is List) {
        rawList = rawData;
      }

      final items = rawList
          .whereType<Map<String, dynamic>>()
          .map(AppNotificationModel.fromJson)
          .toList();

      if (rawData is List) {
        unreadCount = items.where((n) => n.readAt == null).length;
      }

      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );

      return PaginatedNotificationsResult(
        items: items,
        unreadCount: unreadCount,
        meta: meta,
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      await _dio.post<void>(ApiEndpoints.markNotificationRead(id));
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<void> markAllAsRead() async {
    try {
      await _dio.post<void>(ApiEndpoints.markAllNotificationsRead);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepository(ref.watch(dioProvider)),
);
