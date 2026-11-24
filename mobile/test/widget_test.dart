import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tempatin_offline/core/theme/app_theme.dart';
import 'package:tempatin_offline/core/providers/app_providers.dart';
import 'package:tempatin_offline/data/database/app_database.dart';
import 'package:tempatin_offline/data/database/database_seeder.dart';
import 'package:tempatin_offline/features/entry/presentation/entry_screens.dart';
import 'package:tempatin_offline/features/member/presentation/home_and_explore_screens.dart';
import 'package:tempatin_offline/features/member/presentation/kos_detail_and_booking_screens.dart';
import 'package:tempatin_offline/features/owner/presentation/owner_screens.dart';
import 'package:tempatin_offline/main.dart';

void main() {
  late AppDatabase db;
  late SharedPreferences prefs;

  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({'offline_onboarding_seen': true});
    prefs = await SharedPreferences.getInstance();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await DatabaseSeeder(db).seedIfEmpty();
  });

  tearDown(() async {
    await db.close();
  });

  Widget wrap(Widget child) {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        databaseProvider.overrideWithValue(db),
      ],
      child: MaterialApp(theme: AppTheme.light, home: child),
    );
  }

  testWidgets('App boots from SplashScreen smoothly into HomeScreen offline', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          databaseProvider.overrideWithValue(db),
        ],
        child: const TempatinOfflineApp(),
      ),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1100));
    await tester.pumpAndSettle();

    expect(find.text('Rekomendasi Pilihan'), findsOneWidget);
    expect(find.text('Kos Putri Melati'), findsAtLeastNWidgets(1));
  });

  testWidgets('HomeScreen renders local bundled images and kos list offline', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const HomeScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Rekomendasi Pilihan'), findsOneWidget);
    expect(find.byType(Image), findsAtLeastNWidgets(2));
  });

  testWidgets('LoginScreen fills demo credentials and logs in Member & Owner', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const LoginScreen()));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Demo Member'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Demo Member'));
    await tester.pump();
    expect(find.text('dewi@email.com'), findsOneWidget);

    await tester.tap(find.text('Demo Owner'));
    await tester.pump();
    expect(find.text('owner@tempatin.id'), findsOneWidget);
  });

  testWidgets(
    'KosDetailScreen displays local gallery, facilities, and Booking CTA',
    (tester) async {
      await tester.pumpWidget(wrap(const KosDetailScreen(kosId: 1)));
      await tester.pumpAndSettle();

      expect(find.text('Kos Putri Melati'), findsAtLeastNWidgets(1));
      expect(find.text('Ajukan Sewa'), findsOneWidget);
    },
  );

  testWidgets('BookingFormScreen calculates subtotal + Rp 25.000 admin fee', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(const BookingFormScreen(kosId: 1)));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Rp 875.000'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Rp 25.000'), findsOneWidget);
    expect(find.text('Rp 875.000'), findsOneWidget);
  });

  testWidgets(
    'OwnerDashboardScreen renders KPI cards when authenticated as Owner',
    (tester) async {
      await prefs.setInt('offline_session_user_id', 1);
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          databaseProvider.overrideWithValue(db),
        ],
      );
      addTearDown(container.dispose);
      await container.read(sessionProvider.notifier).initializeApp();

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppTheme.light,
            home: const OwnerDashboardScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Total Properti'), findsOneWidget);
      expect(find.text('Pendapatan Demo'), findsOneWidget);
    },
  );
}
