import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/chat_models.dart';

/// Repository for internal Customer <-> Owner messaging (`/api/v1/conversations`).
class ChatRepository {
  const ChatRepository(this._dio);

  final Dio _dio;

  Future<({List<ConversationModel> items, PaginationMeta meta})>
  fetchConversations({int page = 1, int perPage = 25}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.conversations,
        queryParameters: {'page': page, 'per_page': perPage},
      );
      final raw = response.data?['data'];
      final items = raw is List
          ? raw
                .whereType<Map<String, dynamic>>()
                .map(ConversationModel.fromJson)
                .toList()
          : <ConversationModel>[];
      final rawMeta = response.data?['meta'];
      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );
      return (items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<ConversationModel> startConversation(
    String kosSlug, {
    String? initialMessage,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.startConversation(kosSlug),
        data: {
          if (initialMessage != null && initialMessage.trim().isNotEmpty)
            'message': initialMessage.trim(),
        },
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return ConversationModel.fromJson(data);
      }
      throw const UnknownAppException('Gagal memulai percakapan.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<List<MessageModel>> fetchMessages(
    int conversationId, {
    int? afterId,
    int perPage = 30,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.conversationMessages(conversationId),
        queryParameters: {
          if (afterId != null) 'after_id': afterId else 'per_page': perPage,
        },
      );
      final raw = response.data?['data'];
      if (raw is! List) return const [];
      final messages = raw
          .whereType<Map<String, dynamic>>()
          .map(MessageModel.fromJson)
          .toList();
      // Backend returns latest desc when no after_id; sort ascending chronologically.
      messages.sort((a, b) => a.id.compareTo(b.id));
      return messages;
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<MessageModel> sendMessage(int conversationId, String message) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.conversationMessages(conversationId),
        data: {'message': message.trim()},
      );
      final data = response.data?['data'];
      if (data is Map<String, dynamic>) {
        return MessageModel.fromJson(data);
      }
      throw const UnknownAppException('Gagal mengirim pesan.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepository(ref.watch(dioProvider)),
);
