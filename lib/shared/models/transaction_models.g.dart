// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) =>
    _PaymentModel(
      id: (json['id'] as num).toInt(),
      paymentCode: json['payment_code'] as String,
      orderId: json['order_id'] as String?,
      paymentMethod: json['payment_method'] as String,
      paymentChannel: json['payment_channel'] as String?,
      transactionId: json['transaction_id'] as String?,
      amount: doubleFromJson(json['amount']),
      snapToken: json['snap_token'] as String?,
      snapRedirectUrl: json['snap_redirect_url'] as String?,
      status: json['status'] as String,
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PaymentModelToJson(_PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'payment_code': instance.paymentCode,
      'order_id': instance.orderId,
      'payment_method': instance.paymentMethod,
      'payment_channel': instance.paymentChannel,
      'transaction_id': instance.transactionId,
      'amount': instance.amount,
      'snap_token': instance.snapToken,
      'snap_redirect_url': instance.snapRedirectUrl,
      'status': instance.status,
      'paid_at': instance.paidAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

_InvoiceModel _$InvoiceModelFromJson(Map<String, dynamic> json) =>
    _InvoiceModel(
      id: (json['id'] as num).toInt(),
      invoiceNumber: json['invoice_number'] as String,
      bookingCode: json['booking_code'] as String?,
      kosTitle: json['kos_title'] as String?,
      kosSlug: json['kos_slug'] as String?,
      amount: doubleFromJson(json['amount']),
      adminFee: json['admin_fee'] == null
          ? 25000.0
          : doubleFromJson(json['admin_fee']),
      tax: json['tax'] == null ? 0.0 : doubleFromJson(json['tax']),
      totalAmount: doubleFromJson(json['total_amount']),
      dueDate: json['due_date'] as String?,
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
      status: json['status'] as String,
      statusLabel: json['status_label'] as String?,
      payments:
          (json['payments'] as List<dynamic>?)
              ?.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$InvoiceModelToJson(_InvoiceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_number': instance.invoiceNumber,
      'booking_code': instance.bookingCode,
      'kos_title': instance.kosTitle,
      'kos_slug': instance.kosSlug,
      'amount': instance.amount,
      'admin_fee': instance.adminFee,
      'tax': instance.tax,
      'total_amount': instance.totalAmount,
      'due_date': instance.dueDate,
      'paid_at': instance.paidAt?.toIso8601String(),
      'status': instance.status,
      'status_label': instance.statusLabel,
      'payments': instance.payments.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

_RentalContractModel _$RentalContractModelFromJson(Map<String, dynamic> json) =>
    _RentalContractModel(
      id: (json['id'] as num).toInt(),
      contractNumber: json['contract_number'] as String,
      bookingCode: json['booking_code'] as String?,
      terms: json['terms'] as String,
      status: json['status'] as String,
      isSigned: json['is_signed'] as bool? ?? false,
      signedAt: json['signed_at'] == null
          ? null
          : DateTime.parse(json['signed_at'] as String),
      signerIp: json['signer_ip'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RentalContractModelToJson(
  _RentalContractModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contract_number': instance.contractNumber,
  'booking_code': instance.bookingCode,
  'terms': instance.terms,
  'status': instance.status,
  'is_signed': instance.isSigned,
  'signed_at': instance.signedAt?.toIso8601String(),
  'signer_ip': instance.signerIp,
  'created_at': instance.createdAt?.toIso8601String(),
};

_BookingModel _$BookingModelFromJson(Map<String, dynamic> json) =>
    _BookingModel(
      id: (json['id'] as num).toInt(),
      bookingCode: json['booking_code'] as String,
      tenantName: json['tenant_name'] as String,
      tenantPhone: json['tenant_phone'] as String,
      tenantEmail: json['tenant_email'] as String,
      startDate: json['start_date'] as String,
      endDate: json['end_date'] as String,
      durationMonths: json['duration_months'] == null
          ? 1
          : intFromJson(json['duration_months']),
      kosPrice: doubleFromJson(json['kos_price']),
      subtotal: doubleFromJson(json['subtotal']),
      adminFee: json['admin_fee'] == null
          ? 25000.0
          : doubleFromJson(json['admin_fee']),
      totalAmount: doubleFromJson(json['total_amount']),
      notes: json['notes'] as String?,
      status: json['status'] as String,
      statusLabel: json['status_label'] as String?,
      rejectionReason: json['rejection_reason'] as String?,
      kos: json['kos'] == null
          ? null
          : KosSummaryModel.fromJson(json['kos'] as Map<String, dynamic>),
      room: json['room'] == null
          ? null
          : RoomModel.fromJson(json['room'] as Map<String, dynamic>),
      customer: json['customer'] == null
          ? null
          : UserModel.fromJson(json['customer'] as Map<String, dynamic>),
      invoice: json['invoice'] == null
          ? null
          : InvoiceModel.fromJson(json['invoice'] as Map<String, dynamic>),
      contract: json['contract'] == null
          ? null
          : RentalContractModel.fromJson(
              json['contract'] as Map<String, dynamic>,
            ),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$BookingModelToJson(_BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'booking_code': instance.bookingCode,
      'tenant_name': instance.tenantName,
      'tenant_phone': instance.tenantPhone,
      'tenant_email': instance.tenantEmail,
      'start_date': instance.startDate,
      'end_date': instance.endDate,
      'duration_months': instance.durationMonths,
      'kos_price': instance.kosPrice,
      'subtotal': instance.subtotal,
      'admin_fee': instance.adminFee,
      'total_amount': instance.totalAmount,
      'notes': instance.notes,
      'status': instance.status,
      'status_label': instance.statusLabel,
      'rejection_reason': instance.rejectionReason,
      'kos': instance.kos?.toJson(),
      'room': instance.room?.toJson(),
      'customer': instance.customer?.toJson(),
      'invoice': instance.invoice?.toJson(),
      'contract': instance.contract?.toJson(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

_SurveyModel _$SurveyModelFromJson(Map<String, dynamic> json) => _SurveyModel(
  id: (json['id'] as num).toInt(),
  surveyDate: json['survey_date'] as String,
  surveyTime: json['survey_time'] as String,
  notes: json['notes'] as String?,
  status: json['status'] as String,
  statusLabel: json['status_label'] as String?,
  rejectionReason: json['rejection_reason'] as String?,
  kos: json['kos'] == null
      ? null
      : KosSummaryModel.fromJson(json['kos'] as Map<String, dynamic>),
  customer: json['customer'] == null
      ? null
      : UserModel.fromJson(json['customer'] as Map<String, dynamic>),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$SurveyModelToJson(_SurveyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_date': instance.surveyDate,
      'survey_time': instance.surveyTime,
      'notes': instance.notes,
      'status': instance.status,
      'status_label': instance.statusLabel,
      'rejection_reason': instance.rejectionReason,
      'kos': instance.kos?.toJson(),
      'customer': instance.customer?.toJson(),
      'created_at': instance.createdAt?.toIso8601String(),
    };

_MaintenanceReportModel _$MaintenanceReportModelFromJson(
  Map<String, dynamic> json,
) => _MaintenanceReportModel(
  id: (json['id'] as num).toInt(),
  bookingId: (json['booking_id'] as num).toInt(),
  bookingCode: json['booking_code'] as String?,
  title: json['title'] as String,
  description: json['description'] as String,
  photoUrl: json['photo_url'] as String?,
  status: json['status'] as String,
  statusLabel: json['status_label'] as String?,
  ownerNotes: json['owner_notes'] as String?,
  kos: json['kos'] == null
      ? null
      : KosSummaryModel.fromJson(json['kos'] as Map<String, dynamic>),
  room: json['room'] == null
      ? null
      : RoomModel.fromJson(json['room'] as Map<String, dynamic>),
  customer: json['customer'] == null
      ? null
      : UserModel.fromJson(json['customer'] as Map<String, dynamic>),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$MaintenanceReportModelToJson(
  _MaintenanceReportModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'booking_id': instance.bookingId,
  'booking_code': instance.bookingCode,
  'title': instance.title,
  'description': instance.description,
  'photo_url': instance.photoUrl,
  'status': instance.status,
  'status_label': instance.statusLabel,
  'owner_notes': instance.ownerNotes,
  'kos': instance.kos?.toJson(),
  'room': instance.room?.toJson(),
  'customer': instance.customer?.toJson(),
  'created_at': instance.createdAt?.toIso8601String(),
};
