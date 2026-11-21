import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tempatin_mobile/app/theme/app_theme.dart';
import 'package:tempatin_mobile/core/errors/app_exception.dart';
import 'package:tempatin_mobile/core/errors/error_mapper.dart';
import 'package:tempatin_mobile/core/network/api_response.dart';
import 'package:tempatin_mobile/core/storage/prefs_storage.dart';
import 'package:tempatin_mobile/core/storage/secure_storage.dart';
import 'package:tempatin_mobile/features/authentication/data/auth_repository.dart';
import 'package:tempatin_mobile/features/authentication/presentation/providers/auth_session_provider.dart';
import 'package:tempatin_mobile/features/authentication/presentation/screens/login_screen.dart';
import 'package:tempatin_mobile/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:tempatin_mobile/features/home/data/home_repository.dart';
import 'package:tempatin_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:tempatin_mobile/features/property/data/property_repository.dart';
import 'package:tempatin_mobile/features/property/domain/kos_filter.dart';
import 'package:tempatin_mobile/features/property/presentation/screens/explore_screen.dart';
import 'package:tempatin_mobile/features/property/presentation/screens/kos_detail_screen.dart';
import 'package:tempatin_mobile/shared/models/facility_model.dart';
import 'package:tempatin_mobile/shared/models/home_data_model.dart';
import 'package:tempatin_mobile/shared/models/kos_models.dart';
import 'package:tempatin_mobile/shared/models/user_model.dart';

class MockDio extends Mock implements Dio {}

class MockHomeRepo extends Mock implements HomeRepository {}

class MockPropertyRepo extends Mock implements PropertyRepository {}

class MockSecureStorage extends Mock implements SecureStorageService {}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
    registerFallbackValue(const KosFilter());
  });

  group('Phase 5 Domain, Error Mapping & Repositories', () {
    test('KosFilter builds accurate Laravel query parameters', () {
      const filter = KosFilter(
        keyword: 'melati',
        type: 'Putri',
        city: 'Surabaya',
        minPrice: 500000,
        maxPrice: 1500000,
        facilityIds: [1, 3],
        sort: KosSortOption.priceAsc,
      );

      final query = filter.toQueryParams(page: 2, perPage: 10);
      expect(query['page'], 2);
      expect(query['keyword'], 'melati');
      expect(query['type'], 'Putri');
      expect(query['city'], 'Surabaya');
      expect(query['min_price'], 500000);
      expect(query['max_price'], 1500000);
      expect(query['facilities[]'], [1, 3]);
      expect(query['sort'], 'price_asc');
      expect(filter.activeFilterCount, 6);
    });

    test('ErrorMapper parses 422 ValidationException fieldErrors', () {
      final err = DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: '/auth/login'),
          statusCode: 422,
          data: {
            'message': 'Validasi gagal.',
            'errors': {
              'email': ['Email tidak ditemukan.'],
            },
          },
        ),
      );

      final mapped = ErrorMapper.fromDio(err);
      expect(mapped, isA<ValidationException>());
      final valErr = mapped as ValidationException;
      expect(valErr.firstErrorFor('email'), 'Email tidak ditemukan.');
    });

    test('AuthRepository parses Sanctum login JSON contract', () async {
      final dio = MockDio();
      when(
        () => dio.post<Map<String, dynamic>>(any(), data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/auth/login'),
          statusCode: 200,
          data: {
            'success': true,
            'message': 'Login berhasil.',
            'data': {
              'token': '1|sanctum-test-token',
              'user': {
                'id': 2,
                'name': 'Dewi Sartika',
                'email': 'dewi@email.com',
                'role': 'customer',
                'phone': '081234567890',
                'avatar_url': null,
              },
            },
          },
        ),
      );

      final repo = AuthRepository(dio);
      final res = await repo.login(
        email: 'dewi@email.com',
        password: 'password123',
      );
      expect(res.token, '1|sanctum-test-token');
      expect(res.user.name, 'Dewi Sartika');
      expect(res.user.role, UserRole.customer);
    });
  });

  group('Phase 5 Customer Screens Widget Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    testWidgets('HomeScreen renders featured kos items from repository', (
      tester,
    ) async {
      final mockHome = MockHomeRepo();
      when(() => mockHome.fetchHomeData()).thenAnswer(
        (_) async => const HomeDataModel(
          popularCities: [CityStatModel(city: 'Surabaya', kosCount: 3)],
          featuredKos: [
            KosSummaryModel(
              id: 1,
              title: 'Kos Putri Melati',
              slug: 'kos-putri-melati',
              price: 850000,
              type: 'Putri',
              city: 'Surabaya',
              address: 'Jl. Melati No. 12',
              thumbnailUrl: '',
              rating: 4.9,
              reviewCount: 12,
              availableRoomsCount: 3,
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            homeRepositoryProvider.overrideWithValue(mockHome),
          ],
          child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Kos Putri Melati'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Kos Putri Melati'), findsOneWidget);
      expect(find.text('Rp 850.000 / bln'), findsOneWidget);
      expect(find.text('3 kamar tersedia'), findsOneWidget);
    });

    testWidgets('ExploreScreen shows empty state when search returns 0 items', (
      tester,
    ) async {
      final mockProp = MockPropertyRepo();
      when(
        () => mockProp.searchKos(
          filter: any(named: 'filter'),
          page: any(named: 'page'),
          perPage: any(named: 'perPage'),
        ),
      ).thenAnswer(
        (_) async => const PaginatedKosResult(
          items: [],
          meta: PaginationMeta(
            currentPage: 1,
            lastPage: 1,
            perPage: 10,
            total: 0,
          ),
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            propertyRepositoryProvider.overrideWithValue(mockProp),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const ExploreScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Kos Tidak Ditemukan'), findsOneWidget);
    });

    testWidgets('KosDetailScreen displays facilities, owner, and reviews', (
      tester,
    ) async {
      final mockProp = MockPropertyRepo();
      when(() => mockProp.fetchKosDetail('kos-putri-melati')).thenAnswer(
        (_) async => const KosDetailModel(
          id: 1,
          title: 'Kos Putri Melati',
          slug: 'kos-putri-melati',
          description: 'Kos nyaman dekat kampus dengan lingkungan aman.',
          price: 850000,
          type: 'Putri',
          city: 'Surabaya',
          address: 'Jl. Melati No. 12',
          thumbnailUrl: '',
          area: '3x4 m',
          roomsSummary: '10 Kamar',
          rating: 5.0,
          reviewCount: 1,
          owner: OwnerSummaryModel(id: 1, name: 'Rokhim Wicaksono'),
          facilities: [
            FacilityModel(id: 1, name: 'WiFi', slug: 'wifi'),
            FacilityModel(id: 2, name: 'AC', slug: 'ac'),
          ],
          reviews: [
            ReviewModel(
              id: 1,
              reviewerName: 'Dewi Sartika',
              isVerifiedTenant: true,
              rating: 5,
              comment: 'Lingkungan bersih dan pemilik ramah.',
              reply: 'Terima kasih banyak Mbak Dewi!',
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            propertyRepositoryProvider.overrideWithValue(mockProp),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const KosDetailScreen(slug: 'kos-putri-melati'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Kos Putri Melati'), findsOneWidget);
      expect(find.text('Ajukan Sewa'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('WiFi'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('WiFi'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.text('Rokhim Wicaksono'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Rokhim Wicaksono'), findsOneWidget);
    });

    testWidgets('FavoritesScreen shows GuestAuthPrompt when unauthenticated', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const FavoritesScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Simpan Kos Pilihan Anda'), findsOneWidget);
      expect(find.text('Masuk / Daftar'), findsOneWidget);
    });

    testWidgets('LoginScreen validates empty email & short password', (
      tester,
    ) async {
      final storage = MockSecureStorage();
      when(() => storage.readToken()).thenAnswer((_) async => null);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            secureStorageProvider.overrideWithValue(storage),
            authSessionProvider.overrideWith(AuthSessionNotifier.new),
          ],
          child: MaterialApp(theme: AppTheme.light, home: const LoginScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(InkWell, 'Masuk').first);
      await tester.pumpAndSettle();

      expect(find.text('Email wajib diisi.'), findsOneWidget);
      expect(find.text('Kata sandi wajib diisi.'), findsOneWidget);
    });
  });
}
