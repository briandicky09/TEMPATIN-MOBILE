import '../../../../shared/models/user_model.dart';

/// Authentication session state managed by Riverpod.
sealed class AuthState {
  const AuthState({
    this.unreadNotificationsCount = 0,
    this.unreadMessagesCount = 0,
  });

  final int unreadNotificationsCount;
  final int unreadMessagesCount;

  bool get isAuthenticated => this is AuthAuthenticated;
  UserModel? get user => switch (this) {
    AuthAuthenticated(user: final u) => u,
    _ => null,
  };
  UserRole? get role => user?.role;
}

final class AuthGuest extends AuthState {
  const AuthGuest() : super();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated({
    required this.user,
    required this.token,
    super.unreadNotificationsCount,
    super.unreadMessagesCount,
  });

  @override
  final UserModel user;
  final String token;

  AuthAuthenticated copyWith({
    UserModel? user,
    String? token,
    int? unreadNotificationsCount,
    int? unreadMessagesCount,
  }) {
    return AuthAuthenticated(
      user: user ?? this.user,
      token: token ?? this.token,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
      unreadMessagesCount: unreadMessagesCount ?? this.unreadMessagesCount,
    );
  }
}
