import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Database notification item matching `TempatinNotification` payload & `/api/v1/notifications`.
@freezed
abstract class AppNotificationModel with _$AppNotificationModel {
  const factory AppNotificationModel({
    required String id,
    required String title,
    required String message,
    @Default('system') String category,
    String? actionType,
    String? actionId,
    String? actionUrl,
    DateTime? readAt,
    DateTime? createdAt,
  }) = _AppNotificationModel;

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationModelFromJson(json);
}
