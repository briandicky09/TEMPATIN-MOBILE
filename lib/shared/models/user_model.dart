import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Supported mobile user roles (Superadmin remains web-first per approved scope).
enum UserRole {
  @JsonValue('customer')
  customer,
  @JsonValue('owner')
  owner;

  String get label => switch (this) {
    UserRole.customer => 'Pencari Kos',
    UserRole.owner => 'Pemilik Kos',
  };

  static UserRole fromApi(String? raw) {
    return switch (raw?.toLowerCase()) {
      'owner' => UserRole.owner,
      _ => UserRole.customer,
    };
  }
}

/// Canonical authenticated user entity matching Laravel `users` table & `/api/v1/auth/me`.
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    required String email,
    @Default(UserRole.customer) UserRole role,
    String? phone,
    String? avatarUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
