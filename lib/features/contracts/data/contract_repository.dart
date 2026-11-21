import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/app_exception.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/transaction_models.dart';

class ContractRepository {
  const ContractRepository(this._dio);

  final Dio _dio;

  Future<RentalContractModel> fetchForBooking(String bookingCode) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.bookingContract(bookingCode),
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return RentalContractModel.fromJson(raw);
      }
      throw const UnknownAppException('Format kontrak sewa tidak valid.');
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<RentalContractModel> signContract(String contractNumber) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.signContract(contractNumber),
        data: {'agree': true},
      );
      final raw = response.data?['data'];
      if (raw is Map<String, dynamic>) {
        return RentalContractModel.fromJson(raw);
      }
      throw const UnknownAppException(
        'Format respons tanda tangan tidak valid.',
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<Uint8List> downloadContractPdfBytes(String contractNumber) async {
    try {
      final response = await _dio.get<List<int>>(
        ApiEndpoints.contractPdf(contractNumber),
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

final contractRepositoryProvider = Provider<ContractRepository>(
  (ref) => ContractRepository(ref.watch(dioProvider)),
);
