import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/json_converters.dart';
import 'kos_models.dart';
import 'user_model.dart';

part 'transaction_models.freezed.dart';
part 'transaction_models.g.dart';

@freezed
abstract class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    required int id,
    required String paymentCode,
    String? orderId,
    required String paymentMethod,
    String? paymentChannel,
    String? transactionId,
    @JsonKey(fromJson: doubleFromJson) required double amount,
    String? snapToken,
    String? snapRedirectUrl,
    required String status,
    DateTime? paidAt,
    DateTime? createdAt,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}

@freezed
abstract class InvoiceModel with _$InvoiceModel {
  const factory InvoiceModel({
    required int id,
    required String invoiceNumber,
    String? bookingCode,
    String? kosTitle,
    String? kosSlug,
    @JsonKey(fromJson: doubleFromJson) required double amount,
    @JsonKey(fromJson: doubleFromJson) @Default(25000.0) double adminFee,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double tax,
    @JsonKey(fromJson: doubleFromJson) required double totalAmount,
    String? dueDate,
    DateTime? paidAt,
    required String status,
    String? statusLabel,
    @Default([]) List<PaymentModel> payments,
    DateTime? createdAt,
  }) = _InvoiceModel;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InvoiceModelFromJson(json);
}

@freezed
abstract class RentalContractModel with _$RentalContractModel {
  const factory RentalContractModel({
    required int id,
    required String contractNumber,
    String? bookingCode,
    required String terms,
    required String status,
    @Default(false) bool isSigned,
    DateTime? signedAt,
    String? signerIp,
    DateTime? createdAt,
  }) = _RentalContractModel;

  factory RentalContractModel.fromJson(Map<String, dynamic> json) =>
      _$RentalContractModelFromJson(json);
}

@freezed
abstract class BookingModel with _$BookingModel {
  const factory BookingModel({
    required int id,
    required String bookingCode,
    required String tenantName,
    required String tenantPhone,
    required String tenantEmail,
    required String startDate,
    required String endDate,
    @JsonKey(fromJson: intFromJson) @Default(1) int durationMonths,
    @JsonKey(fromJson: doubleFromJson) required double kosPrice,
    @JsonKey(fromJson: doubleFromJson) required double subtotal,
    @JsonKey(fromJson: doubleFromJson) @Default(25000.0) double adminFee,
    @JsonKey(fromJson: doubleFromJson) required double totalAmount,
    String? notes,
    required String status,
    String? statusLabel,
    String? rejectionReason,
    KosSummaryModel? kos,
    RoomModel? room,
    UserModel? customer,
    InvoiceModel? invoice,
    RentalContractModel? contract,
    DateTime? createdAt,
  }) = _BookingModel;

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);
}

@freezed
abstract class SurveyModel with _$SurveyModel {
  const factory SurveyModel({
    required int id,
    required String surveyDate,
    required String surveyTime,
    String? notes,
    required String status,
    String? statusLabel,
    String? rejectionReason,
    KosSummaryModel? kos,
    UserModel? customer,
    DateTime? createdAt,
  }) = _SurveyModel;

  factory SurveyModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyModelFromJson(json);
}

@freezed
abstract class MaintenanceReportModel with _$MaintenanceReportModel {
  const factory MaintenanceReportModel({
    required int id,
    required int bookingId,
    String? bookingCode,
    required String title,
    required String description,
    String? photoUrl,
    required String status,
    String? statusLabel,
    String? ownerNotes,
    KosSummaryModel? kos,
    RoomModel? room,
    UserModel? customer,
    DateTime? createdAt,
  }) = _MaintenanceReportModel;

  factory MaintenanceReportModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceReportModelFromJson(json);
}
