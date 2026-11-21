import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/api_endpoints.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/network/dio_client.dart';

class PayInitResult {
  const PayInitResult({
    required this.paymentCode,
    required this.orderId,
    required this.amount,
    required this.snapToken,
    required this.snapRedirectUrl,
    required this.isProduction,
    this.clientKey,
  });

  final String paymentCode;
  final String orderId;
  final double amount;
  final String snapToken;
  final String snapRedirectUrl;
  final bool isProduction;
  final String? clientKey;

  factory PayInitResult.fromJson(Map<String, dynamic> json) {
    return PayInitResult(
      paymentCode: json['payment_code'] as String? ?? '',
      orderId: json['order_id'] as String? ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      snapToken: json['snap_token'] as String? ?? '',
      snapRedirectUrl: json['snap_redirect_url'] as String? ?? '',
      isProduction: json['is_production'] as bool? ?? false,
      clientKey: json['client_key'] as String?,
    );
  }
}

class PaymentSyncResult {
  const PaymentSyncResult({
    required this.paymentStatus,
    this.invoiceStatus,
    this.bookingStatus,
    this.paidAt,
    this.message = '',
  });

  final String paymentStatus;
  final String? invoiceStatus;
  final String? bookingStatus;
  final DateTime? paidAt;
  final String message;

  bool get isPaid => paymentStatus == 'success';
}

/// Repository initiating Midtrans Snap & syncing verified status from Laravel.
class PaymentRepository {
  const PaymentRepository(this._dio);

  final Dio _dio;

  Future<PayInitResult> initPayment(String bookingCode) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.payBooking(bookingCode),
      );
      final data = response.data?['data'] as Map<String, dynamic>? ?? const {};
      return PayInitResult.fromJson(data);
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }

  Future<PaymentSyncResult> syncPayment(String paymentCode) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        ApiEndpoints.syncPayment(paymentCode),
      );
      final data = response.data?['data'] as Map<String, dynamic>? ?? const {};
      return PaymentSyncResult(
        paymentStatus: data['payment_status'] as String? ?? 'pending',
        invoiceStatus: data['invoice_status'] as String?,
        bookingStatus: data['booking_status'] as String?,
        paidAt: data['paid_at'] is String
            ? DateTime.tryParse(data['paid_at'] as String)
            : null,
        message: response.data?['message'] as String? ?? '',
      );
    } on DioException catch (e) {
      throw ErrorMapper.fromDio(e);
    }
  }
}

final paymentRepositoryProvider = Provider<PaymentRepository>(
  (ref) => PaymentRepository(ref.watch(dioProvider)),
);
