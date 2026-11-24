import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/security/password_hasher.dart';
import '../database/app_database.dart';
import 'models.dart';

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// Offline authentication and profile repository backed by Drift SQLite + SharedPreferences.
class AuthRepository {
  const AuthRepository(this.db, this.prefs);

  final AppDatabase db;
  final SharedPreferences prefs;

  static const _sessionUserIdKey = 'offline_session_user_id';
  static const onboardingSeenKey = 'offline_onboarding_seen';

  Future<AuthenticatedUser?> restoreSession() async {
    final userId = prefs.getInt(_sessionUserIdKey);
    if (userId == null) return null;
    return getUserById(userId);
  }

  Future<AuthenticatedUser?> getUserById(int userId) async {
    final user = await (db.select(
      db.users,
    )..where((u) => u.id.equals(userId))).getSingleOrNull();
    if (user == null) return null;

    final profile = await (db.select(
      db.userProfiles,
    )..where((p) => p.userId.equals(userId))).getSingleOrNull();
    return AuthenticatedUser(user: user, profile: profile);
  }

  Future<AuthenticatedUser> login({
    required String email,
    required String password,
  }) async {
    final normalized = email.trim().toLowerCase();
    final user = await (db.select(
      db.users,
    )..where((u) => u.email.equals(normalized))).getSingleOrNull();

    if (user == null ||
        !PasswordHasher.verify(
          password,
          user.passwordSalt,
          user.passwordHash,
        )) {
      throw const AuthException('Email atau password tidak sesuai.');
    }

    await prefs.setInt(_sessionUserIdKey, user.id);
    final profile = await (db.select(
      db.userProfiles,
    )..where((p) => p.userId.equals(user.id))).getSingleOrNull();
    return AuthenticatedUser(user: user, profile: profile);
  }

  Future<AuthenticatedUser> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String role = 'member',
  }) async {
    final normalized = email.trim().toLowerCase();
    final existing = await (db.select(
      db.users,
    )..where((u) => u.email.equals(normalized))).getSingleOrNull();
    if (existing != null) {
      throw const AuthException('Email sudah terdaftar secara lokal.');
    }

    final salt = PasswordHasher.generateSalt();
    final hash = PasswordHasher.hashPassword(password, salt);

    final userId = await db.transaction(() async {
      final newId = await db
          .into(db.users)
          .insert(
            UsersCompanion.insert(
              name: name.trim(),
              email: normalized,
              passwordHash: hash,
              passwordSalt: salt,
              role: Value(role == 'owner' ? 'owner' : 'member'),
            ),
          );

      await db
          .into(db.userProfiles)
          .insert(
            UserProfilesCompanion.insert(
              userId: newId,
              phone: Value(phone.trim()),
              avatarAsset: const Value('assets/images/logo-symbol.png'),
            ),
          );

      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: newId,
              title: 'Selamat Datang di TEMPATIN Offline',
              message: 'Akun lokal Anda siap digunakan sepenuhnya tanpa koneksi internet.',
              category: const Value('system'),
            ),
          );

      return newId;
    });

    await prefs.setInt(_sessionUserIdKey, userId);
    return (await getUserById(userId))!;
  }

  Future<AuthenticatedUser> updateProfile({
    required int userId,
    required String name,
    String? phone,
    String? address,
    String? bio,
  }) async {
    await db.transaction(() async {
      await (db.update(db.users)..where((u) => u.id.equals(userId))).write(
        UsersCompanion(name: Value(name.trim())),
      );

      final existingProfile = await (db.select(
        db.userProfiles,
      )..where((p) => p.userId.equals(userId))).getSingleOrNull();

      if (existingProfile == null) {
        await db
            .into(db.userProfiles)
            .insert(
              UserProfilesCompanion.insert(
                userId: userId,
                phone: Value(phone?.trim()),
                address: Value(address?.trim()),
                bio: Value(bio?.trim()),
              ),
            );
      } else {
        await (db.update(
          db.userProfiles,
        )..where((p) => p.userId.equals(userId))).write(
          UserProfilesCompanion(
            phone: Value(phone?.trim()),
            address: Value(address?.trim()),
            bio: Value(bio?.trim()),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }
    });

    return (await getUserById(userId))!;
  }

  Future<void> logout() async {
    await prefs.remove(_sessionUserIdKey);
  }
}
