import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tempatin_mobile/app/theme/app_theme.dart';
import 'package:tempatin_mobile/features/booking/presentation/providers/booking_providers.dart';
import 'package:tempatin_mobile/features/booking/presentation/screens/booking_detail_screen.dart';
import 'package:tempatin_mobile/features/booking/presentation/screens/booking_form_screen.dart';
import 'package:tempatin_mobile/features/payment/data/payment_repository.dart';
import 'package:tempatin_mobile/features/property/presentation/providers/property_providers.dart';
import 'package:tempatin_mobile/shared/models/kos_models.dart';
import 'package:tempatin_mobile/shared/models/transaction_models.dart';

BookingModel _sampleBooking({
  required String status,
  String invoiceStatus = 'unpaid',
}) {
  return BookingModel(
    id: 10,
    bookingCode: 'BK-2026-00010',
    tenantName: 'Dewi Sartika',
    tenantPhone: '081234567890',
    tenantEmail: 'dewi@email.com',
    startDate: '2026-12-01',
    endDate: '2027-01-01',
    durationMonths: 1,
    kosPrice: 1500000,
    subtotal: 1500000,
    adminFee: 25000,
    totalAmount: 1525000,
    status: status,
    kos: const KosSummaryModel(
      id: 1,
      title: 'Kos Melati Harmoni',
      slug: 'kos-melati-harmoni',
      price: 1500000,
      type: 'putri',
      city: 'Yogyakarta',
      thumbnailUrl: '',
    ),
    room: const RoomModel(
      id: 2,
      roomNumber: '102',
      floor: 'Lantai 1',
      roomType: 'Standard AC',
      effectivePrice: 1500000,
      status: 'available',
    ),
    invoice: InvoiceModel(
      id: 5,
      invoiceNumber: 'INV-2026-00005',
      bookingCode: 'BK-2026-00010',
      amount: 1500000,
      adminFee: 25000,
      totalAmount: 1525000,
      status: invoiceStatus,
    ),
  );
}

Widget _wrapWithProviders(Widget child, {required BookingModel booking}) {
  return ProviderScope(
    overrides: [
      bookingDetailProvider.overrideWith((ref, code) async => booking),
    ],
    child: MaterialApp(theme: AppTheme.light, home: child),
  );
}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  test('Transaction models parse API JSON snake_case payload accurately', () {
    final booking = BookingModel.fromJson({
      'id': 1,
      'booking_code': 'BK-2026-00001',
      'tenant_name': 'Sari Putri',
      'tenant_phone': '0811111111',
      'tenant_email': 'sari@email.com',
      'start_date': '2026-12-01',
      'end_date': '2027-02-01',
      'duration_months': '2',
      'kos_price': '1400000.00',
      'subtotal': '2800000.00',
      'admin_fee': 25000,
      'total_amount': '2825000.00',
      'status': 'approved',
      'invoice': {
        'id': 9,
        'invoice_number': 'INV-2026-00009',
        'amount': '2800000',
        'admin_fee': '25000',
        'total_amount': '2825000',
        'status': 'unpaid',
      },
    });

    expect(booking.durationMonths, 2);
    expect(booking.totalAmount, 2825000.0);
    expect(booking.status, 'approved');
    expect(booking.invoice?.invoiceNumber, 'INV-2026-00009');

    final payInit = PayInitResult.fromJson({
      'payment_code': 'PAY-123',
      'order_id': 'TMP-INV-9',
      'amount': 2825000,
      'snap_token': 'snap-tok-xyz',
      'snap_redirect_url': 'https://app.sandbox.midtrans.com/snap/v2/vtweb/xyz',
      'is_production': false,
    });
    expect(payInit.snapToken, 'snap-tok-xyz');
    expect(payInit.isProduction, isFalse);
  });

  testWidgets('Owner Approval First: pending hides Pay and shows Cancel', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrapWithProviders(
        const BookingDetailScreen(bookingCode: 'BK-2026-00010'),
        booking: _sampleBooking(status: 'pending'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Batalkan Pengajuan'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Batalkan Pengajuan'), findsOneWidget);
    expect(find.text('Bayar Sekarang (Midtrans)'), findsNothing);
    expect(find.text('Kontrak Sewa Digital'), findsNothing);
  });

  testWidgets('Owner Approval First: approved unlocks Pay and hides Cancel', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrapWithProviders(
        const BookingDetailScreen(bookingCode: 'BK-2026-00010'),
        booking: _sampleBooking(status: 'approved'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Bayar Sekarang (Midtrans)'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Bayar Sekarang (Midtrans)'), findsOneWidget);
    expect(find.text('Batalkan Pengajuan'), findsNothing);
  });

  testWidgets(
    'Confirmed booking with paid invoice shows Nota, Contract & Maintenance',
    (tester) async {
      await tester.pumpWidget(
        _wrapWithProviders(
          const BookingDetailScreen(bookingCode: 'BK-2026-00010'),
          booking: _sampleBooking(status: 'confirmed', invoiceStatus: 'paid'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Laporkan Kerusakan Kamar'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Lihat & Unduh Nota PDF'), findsOneWidget);
      expect(find.text('Kontrak Sewa Digital'), findsOneWidget);
      expect(find.text('Laporkan Kerusakan Kamar'), findsOneWidget);
    },
  );

  testWidgets('BookingFormScreen displays rooms and fee calculation', (
    tester,
  ) async {
    const kosDetail = KosDetailModel(
      id: 1,
      title: 'Kos Melati Harmoni',
      slug: 'kos-melati-harmoni',
      price: 1500000,
      type: 'putri',
      city: 'Yogyakarta',
      thumbnailUrl: '',
      availableRooms: [
        RoomModel(
          id: 11,
          roomNumber: 'A1',
          roomType: 'AC + KM Dalam',
          effectivePrice: 1750000,
          status: 'available',
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          kosDetailProvider.overrideWith((ref, slug) async => kosDetail),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const BookingFormScreen(kosSlug: 'kos-melati-harmoni'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kos Melati Harmoni'), findsOneWidget);
    expect(find.textContaining('Kamar A1'), findsOneWidget);

    await tester.tap(find.textContaining('Kamar A1'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Kirim Pengajuan Sewa'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Kirim Pengajuan Sewa'), findsOneWidget);
    expect(find.text('Rp 25.000'), findsOneWidget);
    expect(find.text('Rp 1.775.000'), findsOneWidget);
  });
}
