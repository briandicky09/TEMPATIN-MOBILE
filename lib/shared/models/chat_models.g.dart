// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) =>
    _MessageModel(
      id: (json['id'] as num).toInt(),
      conversationId: (json['conversation_id'] as num).toInt(),
      senderId: (json['sender_id'] as num).toInt(),
      message: json['message'] as String,
      isRead: json['is_read'] as bool? ?? false,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'sender_id': instance.senderId,
      'message': instance.message,
      'is_read': instance.isRead,
      'created_at': instance.createdAt?.toIso8601String(),
    };

_ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) =>
    _ConversationModel(
      id: (json['id'] as num).toInt(),
      kos: json['kos'] == null
          ? null
          : KosSummaryModel.fromJson(json['kos'] as Map<String, dynamic>),
      counterpart: json['counterpart'] == null
          ? null
          : UserModel.fromJson(json['counterpart'] as Map<String, dynamic>),
      lastMessage: json['last_message'] == null
          ? null
          : MessageModel.fromJson(json['last_message'] as Map<String, dynamic>),
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ConversationModelToJson(_ConversationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kos': instance.kos?.toJson(),
      'counterpart': instance.counterpart?.toJson(),
      'last_message': instance.lastMessage?.toJson(),
      'unread_count': instance.unreadCount,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
