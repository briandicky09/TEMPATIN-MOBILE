import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tempatin_mobile/app/app.dart';
import 'package:tempatin_mobile/core/storage/prefs_storage.dart';
import 'package:tempatin_mobile/core/utils/currency_formatter.dart';
import 'package:tempatin_mobile/core/utils/validators.dart';
import 'package:tempatin_mobile/features/home/data/home_repository.dart';
import 'package:tempatin_mobile/shared/models/home_data_model.dart';

class _MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  group('Core Formatters & Validators', () {
    test('CurrencyFormatter formats IDR cleanly', () {
      expect(CurrencyFormatter.formatIdr(850000), 'Rp 850.000');
      expect(CurrencyFormatter.formatMonthly(1250000), 'Rp 1.250.000 / bln');
    });

    test('AppValidators enforce Laravel-matching rules', () {
      expect(AppValidators.email('invalid-email'), isNotNull);
      expect(AppValidators.email('dewi@email.com'), isNull);
      expect(AppValidators.password('1234567'), isNotNull);
      expect(AppValidators.password('password123'), isNull);
      expect(AppValidators.phone('12345'), isNotNull);
      expect(AppValidators.phone('081234567890'), isNull);
    });
  });

  testWidgets('TempatinApp boots into Customer 5-tab Home shell', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final mockHomeRepo = _MockHomeRepository();
    when(() => mockHomeRepo.fetchHomeData())
        .thenAnswer((_) async => const HomeDataModel());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          homeRepositoryProvider.overrideWithValue(mockHomeRepo),
        ],
        child: const TempatinApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Beranda'), findsOneWidget);
    expect(find.text('Eksplor'), findsOneWidget);
    expect(find.text('Favorit'), findsOneWidget);
    expect(find.text('Aktivitas'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(find.text('Kota Populer'), findsOneWidget);
  });
}
