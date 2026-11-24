import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/database/app_database.dart';
import '../../data/database/database_seeder.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/booking_repository.dart';
import '../../data/repositories/engagement_repository.dart';
import '../../data/repositories/kos_repository.dart';
import '../../data/repositories/models.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.watch(databaseProvider),
    ref.watch(sharedPreferencesProvider),
  ),
);

final kosRepositoryProvider = Provider<KosRepository>(
  (ref) => KosRepository(ref.watch(databaseProvider)),
);

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => BookingRepository(ref.watch(databaseProvider)),
);

final engagementRepositoryProvider = Provider<EngagementRepository>(
  (ref) => EngagementRepository(ref.watch(databaseProvider)),
);

class SessionNotifier extends Notifier<AuthenticatedUser?> {
  @override
  AuthenticatedUser? build() => null;

  /// Seeds local SQLite if empty and restores any saved user session off the UI thread.
  Future<bool> initializeApp() async {
    final db = ref.read(databaseProvider);
    await DatabaseSeeder(db).seedIfEmpty();
    final restored = await ref.read(authRepositoryProvider).restoreSession();
    state = restored;
    return ref
            .read(sharedPreferencesProvider)
            .getBool(AuthRepository.onboardingSeenKey) ??
        false;
  }

  Future<void> markOnboardingSeen() async {
    await ref
        .read(sharedPreferencesProvider)
        .setBool(AuthRepository.onboardingSeenKey, true);
  }

  Future<AuthenticatedUser> login({
    required String email,
    required String password,
  }) async {
    final user = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    state = user;
    return user;
  }

  Future<AuthenticatedUser> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    String role = 'member',
  }) async {
    final user = await ref
        .read(authRepositoryProvider)
        .register(
          name: name,
          email: email,
          password: password,
          phone: phone,
          role: role,
        );
    state = user;
    return user;
  }

  Future<void> updateProfile({
    required String name,
    String? phone,
    String? address,
    String? bio,
  }) async {
    final current = state;
    if (current == null) return;
    final updated = await ref
        .read(authRepositoryProvider)
        .updateProfile(
          userId: current.user.id,
          name: name,
          phone: phone,
          address: address,
          bio: bio,
        );
    state = updated;
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = null;
  }
}

final sessionProvider = NotifierProvider<SessionNotifier, AuthenticatedUser?>(
  SessionNotifier.new,
);

final allFacilitiesProvider = FutureProvider<List<Facility>>((ref) {
  return ref.watch(kosRepositoryProvider).getAllFacilities();
});

final featuredKosProvider = FutureProvider<List<KosCardData>>((ref) {
  final userId = ref.watch(sessionProvider)?.user.id;
  return ref.watch(kosRepositoryProvider).getFeatured(memberId: userId);
});

final latestKosProvider = FutureProvider<List<KosCardData>>((ref) {
  final userId = ref.watch(sessionProvider)?.user.id;
  return ref
      .watch(kosRepositoryProvider)
      .searchKos(const KosFilterParams(), memberId: userId);
});

class ExploreFilterNotifier extends Notifier<KosFilterParams> {
  @override
  KosFilterParams build() => const KosFilterParams();

  void update(KosFilterParams next) => state = next;
  void setQuery(String q) => state = state.copyWith(query: q);
  void setType(String? t) => state = state.copyWith(type: () => t);
  void reset() => state = const KosFilterParams();
}

final exploreFilterProvider =
    NotifierProvider<ExploreFilterNotifier, KosFilterParams>(
      ExploreFilterNotifier.new,
    );

final exploreKosProvider = FutureProvider<List<KosCardData>>((ref) {
  final filter = ref.watch(exploreFilterProvider);
  final userId = ref.watch(sessionProvider)?.user.id;
  return ref.watch(kosRepositoryProvider).searchKos(filter, memberId: userId);
});

final kosDetailProvider = FutureProvider.family
    .autoDispose<KosDetailData?, int>((ref, kosId) {
      final userId = ref.watch(sessionProvider)?.user.id;
      return ref
          .watch(kosRepositoryProvider)
          .getKosDetail(kosId, memberId: userId);
    });

final favoritesProvider = FutureProvider<List<KosCardData>>((ref) async {
  final user = ref.watch(sessionProvider);
  if (user == null) return const [];
  return ref.watch(engagementRepositoryProvider).getFavoriteKos(user.user.id);
});

final memberBookingsProvider = FutureProvider<List<BookingWithDetails>>((
  ref,
) async {
  final user = ref.watch(sessionProvider);
  if (user == null) return const [];
  return ref.watch(bookingRepositoryProvider).getMemberBookings(user.user.id);
});

final memberInvoicesProvider = FutureProvider<List<InvoiceWithDetails>>((
  ref,
) async {
  final user = ref.watch(sessionProvider);
  if (user == null) return const [];
  return ref.watch(bookingRepositoryProvider).getMemberInvoices(user.user.id);
});

final invoiceDetailProvider = FutureProvider.family
    .autoDispose<InvoiceWithDetails?, int>((ref, id) {
      return ref.watch(bookingRepositoryProvider).getInvoiceDetail(id);
    });

final notificationsProvider = FutureProvider<List<AppNotification>>((
  ref,
) async {
  final user = ref.watch(sessionProvider);
  if (user == null) return const [];
  return ref.watch(engagementRepositoryProvider).getNotifications(user.user.id);
});

final unreadNotificationCountProvider = FutureProvider<int>((ref) async {
  final user = ref.watch(sessionProvider);
  if (user == null) return 0;
  return ref.watch(engagementRepositoryProvider).getUnreadCount(user.user.id);
});

final ownerStatsProvider = FutureProvider<OwnerDashboardStats?>((ref) async {
  final user = ref.watch(sessionProvider);
  if (user == null || !user.isOwner) return null;
  return ref.watch(bookingRepositoryProvider).getOwnerStats(user.user.id);
});

final ownerBookingsProvider = FutureProvider.family
    .autoDispose<List<BookingWithDetails>, String>((ref, status) async {
      final user = ref.watch(sessionProvider);
      if (user == null || !user.isOwner) return const [];
      return ref
          .watch(bookingRepositoryProvider)
          .getOwnerBookings(user.user.id, status: status);
    });
