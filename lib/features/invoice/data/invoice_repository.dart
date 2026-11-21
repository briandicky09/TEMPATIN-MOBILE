import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/transaction_models.dart';

class PaginatedInvoicesResult {
  const PaginatedInvoicesResult({required this.items, required this.meta});

  final List<InvoiceModel> items;
  final PaginationMeta meta;
}

class InvoiceRepository {
  const InvoiceRepository(this._dio);

  final Dio _dio;

  Future<PaginatedInvoicesResult> fetchInvoices({
    String? status,
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.invoices,
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
                .map(InvoiceModel.fromJson)
                .toList()
          : <InvoiceModel>[];
      final meta = rawMeta is Map<String, dynamic>
          ? PaginationMeta.fromJson(rawMeta)
          : PaginationMeta(
              currentPage: page,
              lastPage: page,
              perPage: perPage,
              total: items.length,
            );
      return PaginatedInvoicesResult(items: items, meta: meta);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<InvoiceModel> fetchInvoiceDetail(String invoiceNumber) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.invoiceDetail(invoiceNumber),
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return InvoiceModel.fromJson(raw);
      }
      throw const UnknownAppException('Format invoice tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final invoiceRepositoryProvider = Provider<InvoiceRepository>(
  (ref) => InvoiceRepository(ref.watch(dioProvider)),
);
