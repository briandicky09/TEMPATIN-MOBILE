// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OwnerDashboardModel _$OwnerDashboardModelFromJson(
  Map<String, dynamic> json,
) => _OwnerDashboardModel(
  totalKos: json['total_kos'] == null ? 0 : intFromJson(json['total_kos']),
  activeKos: json['active_kos'] == null ? 0 : intFromJson(json['active_kos']),
  inactiveKos: json['inactive_kos'] == null
      ? 0
      : intFromJson(json['inactive_kos']),
  avgPrice: json['avg_price'] == null ? 0.0 : doubleFromJson(json['avg_price']),
  pendingBookingsCount: json['pending_bookings_count'] == null
      ? 0
      : intFromJson(json['pending_bookings_count']),
  pendingSurveysCount: json['pending_surveys_count'] == null
      ? 0
      : intFromJson(json['pending_surveys_count']),
  openMaintenanceCount: json['open_maintenance_count'] == null
      ? 0
      : intFromJson(json['open_maintenance_count']),
  recentKos:
      (json['recent_kos'] as List<dynamic>?)
          ?.map((e) => KosSummaryModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OwnerDashboardModelToJson(
  _OwnerDashboardModel instance,
) => <String, dynamic>{
  'total_kos': instance.totalKos,
  'active_kos': instance.activeKos,
  'inactive_kos': instance.inactiveKos,
  'avg_price': instance.avgPrice,
  'pending_bookings_count': instance.pendingBookingsCount,
  'pending_surveys_count': instance.pendingSurveysCount,
  'open_maintenance_count': instance.openMaintenanceCount,
  'recent_kos': instance.recentKos.map((e) => e.toJson()).toList(),
};

_OwnerBookingCountsModel _$OwnerBookingCountsModelFromJson(
  Map<String, dynamic> json,
) => _OwnerBookingCountsModel(
  all: json['all'] == null ? 0 : intFromJson(json['all']),
  pending: json['pending'] == null ? 0 : intFromJson(json['pending']),
  approved: json['approved'] == null ? 0 : intFromJson(json['approved']),
  confirmed: json['confirmed'] == null ? 0 : intFromJson(json['confirmed']),
  active: json['active'] == null ? 0 : intFromJson(json['active']),
  rejected: json['rejected'] == null ? 0 : intFromJson(json['rejected']),
);

Map<String, dynamic> _$OwnerBookingCountsModelToJson(
  _OwnerBookingCountsModel instance,
) => <String, dynamic>{
  'all': instance.all,
  'pending': instance.pending,
  'approved': instance.approved,
  'confirmed': instance.confirmed,
  'active': instance.active,
  'rejected': instance.rejected,
};

_OwnerBookingDetailData _$OwnerBookingDetailDataFromJson(
  Map<String, dynamic> json,
) => _OwnerBookingDetailData(
  booking: BookingModel.fromJson(json['booking'] as Map<String, dynamic>),
  availableRooms:
      (json['available_rooms'] as List<dynamic>?)
          ?.map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OwnerBookingDetailDataToJson(
  _OwnerBookingDetailData instance,
) => <String, dynamic>{
  'booking': instance.booking.toJson(),
  'available_rooms': instance.availableRooms.map((e) => e.toJson()).toList(),
};

_OwnerRatingSummaryModel _$OwnerRatingSummaryModelFromJson(
  Map<String, dynamic> json,
) => _OwnerRatingSummaryModel(
  totalReviews: json['total_reviews'] == null
      ? 0
      : intFromJson(json['total_reviews']),
  averageRating: json['average_rating'] == null
      ? 0.0
      : doubleFromJson(json['average_rating']),
);

Map<String, dynamic> _$OwnerRatingSummaryModelToJson(
  _OwnerRatingSummaryModel instance,
) => <String, dynamic>{
  'total_reviews': instance.totalReviews,
  'average_rating': instance.averageRating,
};

_MonthlyRevenuePoint _$MonthlyRevenuePointFromJson(Map<String, dynamic> json) =>
    _MonthlyRevenuePoint(
      month: json['month'] as String,
      value: json['value'] == null ? 0.0 : doubleFromJson(json['value']),
    );

Map<String, dynamic> _$MonthlyRevenuePointToJson(
  _MonthlyRevenuePoint instance,
) => <String, dynamic>{'month': instance.month, 'value': instance.value};

_KosPerformanceModel _$KosPerformanceModelFromJson(Map<String, dynamic> json) =>
    _KosPerformanceModel(
      title: json['title'] as String,
      occupancy: json['occupancy'] == null ? 0 : intFromJson(json['occupancy']),
      booking: json['booking'] == null ? 0 : intFromJson(json['booking']),
      revenue: json['revenue'] == null ? 0.0 : doubleFromJson(json['revenue']),
    );

Map<String, dynamic> _$KosPerformanceModelToJson(
  _KosPerformanceModel instance,
) => <String, dynamic>{
  'title': instance.title,
  'occupancy': instance.occupancy,
  'booking': instance.booking,
  'revenue': instance.revenue,
};

_OwnerAnalyticsModel _$OwnerAnalyticsModelFromJson(
  Map<String, dynamic> json,
) => _OwnerAnalyticsModel(
  totalRevenue: json['total_revenue'] == null
      ? 0.0
      : doubleFromJson(json['total_revenue']),
  totalBookings: json['total_bookings'] == null
      ? 0
      : intFromJson(json['total_bookings']),
  occupancyRate: json['occupancy_rate'] == null
      ? 0
      : intFromJson(json['occupancy_rate']),
  revenueGrowthPct: json['revenue_growth_pct'] == null
      ? 0.0
      : doubleFromJson(json['revenue_growth_pct']),
  monthlyRevenue:
      (json['monthly_revenue'] as List<dynamic>?)
          ?.map((e) => MonthlyRevenuePoint.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  kosPerformance:
      (json['kos_performance'] as List<dynamic>?)
          ?.map((e) => KosPerformanceModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OwnerAnalyticsModelToJson(
  _OwnerAnalyticsModel instance,
) => <String, dynamic>{
  'total_revenue': instance.totalRevenue,
  'total_bookings': instance.totalBookings,
  'occupancy_rate': instance.occupancyRate,
  'revenue_growth_pct': instance.revenueGrowthPct,
  'monthly_revenue': instance.monthlyRevenue.map((e) => e.toJson()).toList(),
  'kos_performance': instance.kosPerformance.map((e) => e.toJson()).toList(),
};
