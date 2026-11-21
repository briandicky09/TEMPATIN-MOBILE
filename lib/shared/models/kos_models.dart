import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/utils/json_converters.dart';
import 'facility_model.dart';

part 'kos_models.freezed.dart';
part 'kos_models.g.dart';

@freezed
abstract class OwnerSummaryModel with _$OwnerSummaryModel {
  const factory OwnerSummaryModel({
    required int id,
    required String name,
    String? phone,
    String? avatarUrl,
  }) = _OwnerSummaryModel;

  factory OwnerSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerSummaryModelFromJson(json);
}

@freezed
abstract class KosPhotoModel with _$KosPhotoModel {
  const factory KosPhotoModel({
    required int id,
    required String photoUrl,
    @Default(0) int sortOrder,
  }) = _KosPhotoModel;

  factory KosPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$KosPhotoModelFromJson(json);
}

@freezed
abstract class RoomModel with _$RoomModel {
  const factory RoomModel({
    required int id,
    required String roomNumber,
    String? floor,
    String? roomType,
    @JsonKey(fromJson: nullableDoubleFromJson) double? priceOverride,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double effectivePrice,
    @Default('available') String status,
    String? notes,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}

@freezed
abstract class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required int id,
    required String reviewerName,
    @Default(false) bool isVerifiedTenant,
    @Default(5) int rating,
    required String comment,
    String? reply,
    String? userAvatarUrl,
    DateTime? createdAt,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}

@freezed
abstract class KosSummaryModel with _$KosSummaryModel {
  const factory KosSummaryModel({
    required int id,
    required String title,
    required String slug,
    @JsonKey(fromJson: doubleFromJson) required double price,
    required String type,
    required String city,
    String? address,
    required String thumbnailUrl,
    @Default('active') String status,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double rating,
    @JsonKey(fromJson: intFromJson) @Default(0) int reviewCount,
    @Default(false) bool isFavorited,
    int? availableRoomsCount,
    @Default([]) List<FacilityModel> facilities,
  }) = _KosSummaryModel;

  factory KosSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$KosSummaryModelFromJson(json);
}

@freezed
abstract class KosDetailModel with _$KosDetailModel {
  const factory KosDetailModel({
    required int id,
    required String title,
    required String slug,
    String? description,
    @JsonKey(fromJson: doubleFromJson) required double price,
    required String type,
    required String city,
    String? address,
    required String thumbnailUrl,
    @Default('active') String status,
    String? area,
    String? roomsSummary,
    String? bathrooms,
    String? bedrooms,
    String? garages,
    @JsonKey(fromJson: nullableDoubleFromJson) double? latitude,
    @JsonKey(fromJson: nullableDoubleFromJson) double? longitude,
    @JsonKey(fromJson: doubleFromJson) @Default(0.0) double rating,
    @JsonKey(fromJson: intFromJson) @Default(0) int reviewCount,
    @Default(false) bool isFavorited,
    @Default(false) bool canReview,
    OwnerSummaryModel? owner,
    @Default([]) List<KosPhotoModel> photos,
    @Default([]) List<FacilityModel> facilities,
    @Default([]) List<RoomModel> availableRooms,
    @Default([]) List<ReviewModel> reviews,
    @Default([]) List<KosSummaryModel> similarKos,
  }) = _KosDetailModel;

  factory KosDetailModel.fromJson(Map<String, dynamic> json) =>
      _$KosDetailModelFromJson(json);
}
