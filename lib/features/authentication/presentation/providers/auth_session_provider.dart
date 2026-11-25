import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/storage/secure_storage.dart';
import '../../../../shared/models/user_model.dart';
import '../../data/auth_repository.dart';
import '../../domain/auth_state.dart';

/// Central Riverpod session controller integrated with Sanctum `/api/v1/auth/*`.
class AuthSessionNotifier extends Notifier<AuthState> {
  Future<void>? _restoreFuture;

  @override
  AuthState build() => const AuthGuest();

  Future<void> restoreSession() {
    return _restoreFuture ??= _performRestoreSession();
  }

  Future<void> _performRestoreSession() async {
    final storage = ref.read(secureStorageProvider);
    String? token;
    try {
      token = await storage.readToken().timeout(
        const Duration(milliseconds: 500),
        onTimeout: () => null,
      );
    } catch (_) {
      return;
    }
    if (token == null || token.isEmpty) return;

    try {
      final me = await ref.read(authRepositoryProvider).getMe();
      state = AuthAuthenticated(
        user: me.user,
        token: token,
        unreadNotificationsCount: me.unreadNotificationsCount,
        unreadMessagesCount: me.unreadMessagesCount,
      );
    } on UnauthorizedException {
      await storage.clearToken();
      state = const AuthGuest();
    } catch (_) {
      // Preserve token if offline; session can be retried on user action.
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final result = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    await setAuthenticated(user: result.user, token: result.token);
    await refreshCounts();
    return result.user;
  }

  Future<UserModel> register({
    required String name,
    required String phone,
    required String email,
    required UserRole role,
    required String password,
    required String passwordConfirmation,
  }) async {
    final result = await ref
        .read(authRepositoryProvider)
        .register(
          name: name,
          phone: phone,
          email: email,
          role: role,
          password: password,
          passwordConfirmation: passwordConfirmation,
        );
    await setAuthenticated(user: result.user, token: result.token);
    return result.user;
  }

  Future<void> setAuthenticated({
    required UserModel user,
    required String token,
  }) async {
    await ref.read(secureStorageProvider).writeToken(token);
    state = AuthAuthenticated(user: user, token: token);
  }

  Future<void> refreshCounts() async {
    final current = state;
    if (current is! AuthAuthenticated) return;
    try {
      final me = await ref.read(authRepositoryProvider).getMe();
      state = current.copyWith(
        user: me.user,
        unreadNotificationsCount: me.unreadNotificationsCount,
        unreadMessagesCount: me.unreadMessagesCount,
      );
    } catch (_) {
      // Ignore silent background badge refresh errors.
    }
  }

  void updateUser(UserModel user) {
    final current = state;
    if (current is AuthAuthenticated) {
      state = current.copyWith(user: user);
    }
  }

  void decrementUnreadNotifications() {
    final current = state;
    if (current is AuthAuthenticated && current.unreadNotificationsCount > 0) {
      state = current.copyWith(
        unreadNotificationsCount: current.unreadNotificationsCount - 1,
      );
    }
  }

  void clearUnreadNotifications() {
    final current = state;
    if (current is AuthAuthenticated) {
      state = current.copyWith(unreadNotificationsCount: 0);
    }
  }

  Future<void> signOut({bool notifyServer = true}) async {
    if (notifyServer && state.isAuthenticated) {
      try {
        await ref.read(authRepositoryProvider).logout();
      } catch (_) {
        // Always proceed with local token removal on logout.
      }
    }
    await ref.read(secureStorageProvider).clearToken();
    state = const AuthGuest();
  }
}

final authSessionProvider = NotifierProvider<AuthSessionNotifier, AuthState>(
  AuthSessionNotifier.new,
);
