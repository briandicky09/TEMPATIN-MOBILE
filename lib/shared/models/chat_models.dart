import 'package:freezed_annotation/freezed_annotation.dart';

import 'kos_models.dart';
import 'user_model.dart';

part 'chat_models.freezed.dart';
part 'chat_models.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  const factory MessageModel({
    required int id,
    required int conversationId,
    required int senderId,
    required String message,
    @Default(false) bool isRead,
    DateTime? createdAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

@freezed
abstract class ConversationModel with _$ConversationModel {
  const factory ConversationModel({
    required int id,
    KosSummaryModel? kos,
    UserModel? counterpart,
    MessageModel? lastMessage,
    @Default(0) int unreadCount,
    DateTime? updatedAt,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);
}
