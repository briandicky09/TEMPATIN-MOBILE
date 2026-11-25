import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:tempatin_mobile/app/app.dart';
import 'package:tempatin_mobile/core/offline/offline_demo_database.dart';
import 'package:tempatin_mobile/core/offline/offline_demo_interceptor.dart';
import 'package:tempatin_mobile/core/storage/prefs_storage.dart';
import 'package:tempatin_mobile/features/authentication/presentation/screens/login_screen.dart';
import 'package:tempatin_mobile/features/home/data/home_repository.dart';
import 'package:tempatin_mobile/features/payment/presentation/screens/payment_screens.dart';
import 'package:tempatin_mobile/shared/models/facility_model.dart';
import 'package:tempatin_mobile/shared/models/home_data_model.dart';
import 'package:tempatin_mobile/shared/models/kos_models.dart';
import 'package:tempatin_mobile/shared/models/transaction_models.dart';
import 'package:tempatin_mobile/shared/widgets/app_smart_image.dart';

class _MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  setUpAll(() {
    sqfliteFfiInit();
  });

  group('Offline Demo SQLite & Interceptor E2E', () {
    late OfflineDemoDatabase db;
    late Dio dio;

    setUp(() {
      db = OfflineDemoDatabase(
        factoryOverride: databaseFactoryFfi,
        dbPathOverride: inMemoryDatabasePath,
      );
      dio = Dio(BaseOptions(baseUrl: 'http://offline.local/api/v1'))
        ..interceptors.add(
          OfflineDemoInterceptor(db: db, isOfflineDemo: () => true),
        );
    });

    tearDown(() async {
      await db.close();
    });

    test('Home, filtering, favorite toggle, booking -> approve -> pay -> PDF -> reset work offline', () async {
      // 1. Guest home & bundled local kos asset paths
      final homeRes = await dio.get<Map<String, dynamic>>('/home');
      final homeData = homeRes.data!['data'] as Map<String, dynamic>;
      final featured = homeData['featured_kos'] as List<dynamic>;
      expect(featured.length, 6);
      final firstKos = featured.first as Map<String, dynamic>;
      expect(
        (firstKos['thumbnail_url'] as String).startsWith('assets/images/kos/'),
        isTrue,
      );

      // 2. Customer login
      final custLogin = await dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': 'dewi@email.com', 'password': 'password123'},
      );
      final custToken =
          (custLogin.data!['data'] as Map<String, dynamic>)['token'] as String;
      final custAuth = Options(headers: {'Authorization': 'Bearer $custToken'});

      // 3. Filter & toggle favorite
      final filteredKos = await dio.get<Map<String, dynamic>>(
        '/kos',
        queryParameters: {'type': 'Putri', 'sort': 'price_asc'},
        options: custAuth,
      );
      final putriList = filteredKos.data!['data'] as List<dynamic>;
      expect(putriList.isNotEmpty, isTrue);

      final toggleRes = await dio.post<Map<String, dynamic>>(
        '/favorites/toggle',
        data: {'kos_slug': 'kos-harmoni-kemang-residence'},
        options: custAuth,
      );
      expect(
        (toggleRes.data!['data'] as Map<String, dynamic>)['is_favorite'],
        isTrue,
      );

      // 4. Customer creates new booking
      final createBooking = await dio.post<Map<String, dynamic>>(
        '/bookings',
        data: {
          'kos_slug': 'kos-harmoni-kemang-residence',
          'tenant_name': 'Dewi Lestari',
          'tenant_phone': '+62 813-4567-8901',
          'tenant_email': 'dewi@email.com',
          'start_date': '2026-12-01',
          'duration_months': 2,
        },
        options: custAuth,
      );
      final newBookingCode =
          (createBooking.data!['data'] as Map<String, dynamic>)['booking_code']
              as String;

      // 5. Owner login & approve booking
      final ownerLogin = await dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': 'owner@tempatin.id', 'password': 'password123'},
      );
      final ownerToken =
          (ownerLogin.data!['data'] as Map<String, dynamic>)['token'] as String;
      final ownerAuth = Options(
        headers: {'Authorization': 'Bearer $ownerToken'},
      );

      final ownerDash = await dio.get<Map<String, dynamic>>(
        '/owner/dashboard',
        options: ownerAuth,
      );
      expect(
        (ownerDash.data!['data'] as Map<String, dynamic>)['total_kos'],
        7,
      );

      final approved = await dio.post<Map<String, dynamic>>(
        '/owner/bookings/$newBookingCode/approve',
        data: {},
        options: ownerAuth,
      );
      expect(
        (approved.data!['data'] as Map<String, dynamic>)['status'],
        'approved',
      );

      // 6. Customer demo payment + sync -> confirmed + Nota & Contract PDFs
      final payInit = await dio.post<Map<String, dynamic>>(
        '/bookings/$newBookingCode/pay',
        options: custAuth,
      );
      final paymentCode =
          (payInit.data!['data'] as Map<String, dynamic>)['payment_code']
              as String;

      final paySync = await dio.get<Map<String, dynamic>>(
        '/payments/$paymentCode/sync',
        options: custAuth,
      );
      final syncData = paySync.data!['data'] as Map<String, dynamic>;
      expect(syncData['payment_status'], 'success');
      expect(syncData['booking_status'], 'confirmed');

      final notaPdf = await dio.get<List<int>>(
        '/bookings/$newBookingCode/nota-pdf',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Authorization': 'Bearer $custToken'},
        ),
      );
      final notaBytes = Uint8List.fromList(notaPdf.data!);
      expect(notaBytes.length, greaterThan(500));
      expect(String.fromCharCodes(notaBytes.take(4)), '%PDF');

      final contractRes = await dio.get<Map<String, dynamic>>(
        '/bookings/$newBookingCode/contract',
        options: custAuth,
      );
      final contractNumber =
          (contractRes.data!['data']
                  as Map<String, dynamic>)['contract_number']
              as String;

      final signedRes = await dio.post<Map<String, dynamic>>(
        '/contracts/$contractNumber/sign',
        data: {'agree': true},
        options: custAuth,
      );
      expect(
        (signedRes.data!['data'] as Map<String, dynamic>)['is_signed'],
        isTrue,
      );

      final contractPdf = await dio.get<List<int>>(
        '/contracts/$contractNumber/pdf',
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Authorization': 'Bearer $custToken'},
        ),
      );
      expect(String.fromCharCodes(contractPdf.data!.take(4)), '%PDF');

      // 7. Chat & reset
      final sentMsg = await dio.post<Map<String, dynamic>>(
        '/conversations/1/messages',
        data: {'message': 'Terima kasih Pak Budi.'},
        options: custAuth,
      );
      expect(
        (sentMsg.data!['data'] as Map<String, dynamic>)['message'],
        'Terima kasih Pak Budi.',
      );

      await db.resetDemoData();
      final ownerAfterReset = await dio.post<Map<String, dynamic>>(
        '/auth/login',
        data: {'email': 'owner@tempatin.id', 'password': 'password123'},
      );
      final ownerResetToken =
          (ownerAfterReset.data!['data'] as Map<String, dynamic>)['token']
              as String;
      final dashAfterReset = await dio.get<Map<String, dynamic>>(
        '/owner/dashboard',
        options: Options(headers: {'Authorization': 'Bearer $ownerResetToken'}),
      );
      // Pending bookings count returns to initial seeded 1
      expect(
        (dashAfterReset.data!['data']
            as Map<String, dynamic>)['pending_bookings_count'],
        1,
      );
    });
  });

  group('Final Polish UI & Offline Safety Widgets', () {
    testWidgets('SplashScreen animates & transitions smoothly into HomeScreen', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final mockHomeRepo = _MockHomeRepository();
      when(mockHomeRepo.fetchHomeData).thenAnswer(
        (_) async => const HomeDataModel(
          featuredKos: [
            KosSummaryModel(
              id: 1,
              title: 'Kos Mentari Eksklusif Pogung',
              slug: 'kos-mentari-eksklusif-pogung',
              price: 1850000,
              type: 'Campur',
              city: 'Yogyakarta',
              thumbnailUrl: 'assets/images/kos/kos_001.png',
            ),
          ],
          popularCities: [CityStatModel(city: 'Yogyakarta', kosCount: 2)],
          facilities: [FacilityModel(id: 1, name: 'Wi-Fi 100 Mbps', slug: 'wifi')],
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            homeRepositoryProvider.overrideWithValue(mockHomeRepo),
          ],
          child: const TempatinApp(),
        ),
      );

      // Pump briefly on SplashScreen before transition completes
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('TEMPATIN'), findsOneWidget);
      expect(find.text('Offline-First Demo Ready'), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.text('Kota Populer'), findsOneWidget);
    });

    testWidgets('AppSmartImage renders asset and empty fallback cleanly', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppSmartImage(
                  source: 'assets/images/kos/kos_001.png',
                  width: 80,
                  height: 80,
                ),
                AppSmartImage(source: '', width: 80, height: 80),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsNWidgets(2));
    });

    testWidgets('PaymentSummaryScreen shows Offline Demo confirmation instead of Midtrans WebView', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({'tempatin_offline_demo_mode': true});
      final prefs = await SharedPreferences.getInstance();
      const booking = BookingModel(
        id: 2,
        bookingCode: 'BOOK-2026-0002',
        tenantName: 'Dewi Lestari',
        tenantPhone: '+62 813-4567-8901',
        tenantEmail: 'dewi@email.com',
        startDate: '2026-12-01',
        endDate: '2027-03-01',
        durationMonths: 3,
        kosPrice: 2100000,
        subtotal: 6300000,
        adminFee: 25000,
        totalAmount: 6325000,
        status: 'approved',
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
          child: const MaterialApp(
            home: PaymentSummaryScreen(
              bookingCode: 'BOOK-2026-0002',
              booking: booking,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Konfirmasi Pembayaran Demo Offline'),
        findsOneWidget,
      );
      expect(find.text('Lanjut ke Midtrans Snap'), findsNothing);
    });

    testWidgets('LoginScreen shows 1-tap Offline Demo credentials filler', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({'tempatin_offline_demo_mode': true});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
          child: const MaterialApp(home: LoginScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Akun Demo Offline'), findsOneWidget);
      await tester.ensureVisible(find.text('Customer (Dewi)'));
      await tester.tap(find.text('Customer (Dewi)'));
      await tester.pump();
      expect(find.text('dewi@email.com'), findsOneWidget);
    });
  });
}
