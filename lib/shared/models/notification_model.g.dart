// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotificationModel _$AppNotificationModelFromJson(
  Map<String, dynamic> json,
) => _AppNotificationModel(
  id: json['id'] as String,
  title: json['title'] as String,
  message: json['message'] as String,
  category: json['category'] as String? ?? 'system',
  actionType: json['action_type'] as String?,
  actionId: json['action_id'] as String?,
  actionUrl: json['action_url'] as String?,
  readAt: json['read_at'] == null
      ? null
      : DateTime.parse(json['read_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$AppNotificationModelToJson(
  _AppNotificationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'message': instance.message,
  'category': instance.category,
  'action_type': instance.actionType,
  'action_id': instance.actionId,
  'action_url': instance.actionUrl,
  'read_at': instance.readAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
};
