import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/json_converters.dart';
import 'kos_models.dart';
import 'transaction_models.dart';

part 'owner_models.freezed.dart';
part 'owner_models.g.dart';

@freezed
abstract class OwnerDashboardModel with _$OwnerDashboardModel {
  const factory OwnerDashboardModel({
    @JsonKey(fromJson: intFromJson) @Default(0) int totalKos,
    @JsonKey(fromJson: intFromJson) @Default(0) int activeKos,
    @JsonKey(fromJson: intFromJson) @Default(0) int inactiveKos,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double avgPrice,
    @JsonKey(fromJson: intFromJson) @Default(0) int pendingBookingsCount,
    @JsonKey(fromJson: intFromJson) @Default(0) int pendingSurveysCount,
    @JsonKey(fromJson: intFromJson) @Default(0) int openMaintenanceCount,
    @Default([]) List<KosSummaryModel> recentKos,
  }) = _OwnerDashboardModel;

  factory OwnerDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerDashboardModelFromJson(json);
}

@freezed
abstract class OwnerBookingCountsModel with _$OwnerBookingCountsModel {
  const factory OwnerBookingCountsModel({
    @JsonKey(fromJson: intFromJson) @Default(0) int all,
    @JsonKey(fromJson: intFromJson) @Default(0) int pending,
    @JsonKey(fromJson: intFromJson) @Default(0) int approved,
    @JsonKey(fromJson: intFromJson) @Default(0) int confirmed,
    @JsonKey(fromJson: intFromJson) @Default(0) int active,
    @JsonKey(fromJson: intFromJson) @Default(0) int rejected,
  }) = _OwnerBookingCountsModel;

  factory OwnerBookingCountsModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerBookingCountsModelFromJson(json);
}

@freezed
abstract class OwnerBookingDetailData with _$OwnerBookingDetailData {
  const factory OwnerBookingDetailData({
    required BookingModel booking,
    @Default([]) List<RoomModel> availableRooms,
  }) = _OwnerBookingDetailData;

  factory OwnerBookingDetailData.fromJson(Map<String, dynamic> json) =>
      _$OwnerBookingDetailDataFromJson(json);
}

@freezed
abstract class OwnerRatingSummaryModel with _$OwnerRatingSummaryModel {
  const factory OwnerRatingSummaryModel({
    @JsonKey(fromJson: intFromJson) @Default(0) int totalReviews,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double averageRating,
  }) = _OwnerRatingSummaryModel;

  factory OwnerRatingSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerRatingSummaryModelFromJson(json);
}

@freezed
abstract class MonthlyRevenuePoint with _$MonthlyRevenuePoint {
  const factory MonthlyRevenuePoint({
    required String month,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double value,
  }) = _MonthlyRevenuePoint;

  factory MonthlyRevenuePoint.fromJson(Map<String, dynamic> json) =>
      _$MonthlyRevenuePointFromJson(json);
}

@freezed
abstract class KosPerformanceModel with _$KosPerformanceModel {
  const factory KosPerformanceModel({
    required String title,
    @JsonKey(fromJson: intFromJson) @Default(0) int occupancy,
    @JsonKey(fromJson: intFromJson) @Default(0) int booking,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double revenue,
  }) = _KosPerformanceModel;

  factory KosPerformanceModel.fromJson(Map<String, dynamic> json) =>
      _$KosPerformanceModelFromJson(json);
}

@freezed
abstract class OwnerAnalyticsModel with _$OwnerAnalyticsModel {
  const factory OwnerAnalyticsModel({
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double totalRevenue,
    @JsonKey(fromJson: intFromJson) @Default(0) int totalBookings,
    @JsonKey(fromJson: intFromJson) @Default(0) int occupancyRate,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double revenueGrowthPct,
    @Default([]) List<MonthlyRevenuePoint> monthlyRevenue,
    @Default([]) List<KosPerformanceModel> kosPerformance,
  }) = _OwnerAnalyticsModel;

  factory OwnerAnalyticsModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerAnalyticsModelFromJson(json);
}
