import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tempatin_mobile/app/theme/app_theme.dart';
import 'package:tempatin_mobile/features/messaging/data/chat_repository.dart';
import 'package:tempatin_mobile/features/messaging/presentation/screens/chat_screens.dart';
import 'package:tempatin_mobile/features/owner/presentation/providers/owner_providers.dart';
import 'package:tempatin_mobile/features/owner/presentation/screens/owner_analytics_and_more_screens.dart';
import 'package:tempatin_mobile/features/owner/presentation/screens/owner_booking_detail_screen.dart';
import 'package:tempatin_mobile/features/owner/presentation/screens/owner_dashboard_screen.dart';
import 'package:tempatin_mobile/shared/models/chat_models.dart';
import 'package:tempatin_mobile/shared/models/kos_models.dart';
import 'package:tempatin_mobile/shared/models/owner_models.dart';
import 'package:tempatin_mobile/shared/models/transaction_models.dart';
import 'package:tempatin_mobile/shared/models/user_model.dart';

class _MockChatRepository extends Mock implements ChatRepository {}

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID');
  });

  test('Owner & Chat Freezed models parse Laravel snake_case payloads', () {
    final dash = OwnerDashboardModel.fromJson({
      'total_kos': 4,
      'active_kos': 3,
      'inactive_kos': 1,
      'avg_price': '1650000.00',
      'pending_bookings_count': 2,
      'pending_surveys_count': 1,
      'open_maintenance_count': 3,
      'recent_kos': [],
    });
    expect(dash.totalKos, 4);
    expect(dash.avgPrice, 1650000.0);
    expect(dash.pendingBookingsCount, 2);

    final analytics = OwnerAnalyticsModel.fromJson({
      'total_revenue': '9000000',
      'total_bookings': 6,
      'occupancy_rate': 75,
      'revenue_growth_pct': 12.5,
      'monthly_revenue': [
        {'month': 'Nov', 'value': 3000000},
      ],
      'kos_performance': [
        {
          'title': 'Kos Melati',
          'occupancy': 80,
          'booking': 4,
          'revenue': 6000000,
        },
      ],
    });
    expect(analytics.occupancyRate, 75);
    expect(analytics.monthlyRevenue.first.month, 'Nov');
    expect(analytics.kosPerformance.first.revenue, 6000000.0);

    final conv = ConversationModel.fromJson({
      'id': 8,
      'unread_count': 2,
      'counterpart': {
        'id': 3,
        'name': 'Dewi Sartika',
        'email': 'dewi@email.com',
        'role': 'customer',
      },
      'last_message': {
        'id': 55,
        'conversation_id': 8,
        'sender_id': 3,
        'message': 'Apakah kamar 101 masih kosong?',
        'is_read': false,
      },
    });
    expect(conv.id, 8);
    expect(conv.unreadCount, 2);
    expect(conv.counterpart?.name, 'Dewi Sartika');
    expect(conv.lastMessage?.message, contains('101'));
  });

  testWidgets('OwnerDashboardScreen displays live KPI counts and queues', (
    tester,
  ) async {
    const dash = OwnerDashboardModel(
      totalKos: 5,
      activeKos: 4,
      inactiveKos: 1,
      avgPrice: 1500000,
      pendingBookingsCount: 3,
      pendingSurveysCount: 2,
      openMaintenanceCount: 1,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [ownerDashboardProvider.overrideWith((ref) async => dash)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const OwnerDashboardScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('5'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('3'), findsAtLeastNWidgets(1));
    await tester.scrollUntilVisible(
      find.text('Persetujuan Booking Baru'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Persetujuan Booking Baru'), findsOneWidget);
  });

  testWidgets(
    'OwnerBookingDetailScreen renders Approve + Reject + rooms on pending, Check-In on confirmed',
    (tester) async {
      const pendingData = OwnerBookingDetailData(
        booking: BookingModel(
          id: 1,
          bookingCode: 'BK-2026-00099',
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
          status: 'pending',
        ),
        availableRooms: [
          RoomModel(
            id: 7,
            roomNumber: '201',
            effectivePrice: 1500000,
            status: 'available',
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ownerBookingDetailProvider.overrideWith(
              (ref, code) async => pendingData,
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const OwnerBookingDetailScreen(bookingCode: 'BK-2026-00099'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Tolak Pengajuan'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.textContaining('Kamar 201'), findsOneWidget);
      expect(find.text('Setujui Pengajuan Sewa'), findsOneWidget);
      expect(find.text('Tolak Pengajuan'), findsOneWidget);

      final confirmedData = pendingData.copyWith(
        booking: pendingData.booking.copyWith(status: 'confirmed'),
      );
      await tester.pumpWidget(
        ProviderScope(
          key: const ValueKey('confirmed-booking-scope'),
          overrides: [
            ownerBookingDetailProvider.overrideWith(
              (ref, code) async => confirmedData,
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const OwnerBookingDetailScreen(bookingCode: 'BK-2026-00099'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Proses Check-In Penghuni'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Proses Check-In Penghuni'), findsOneWidget);
    },
  );

  testWidgets(
    'OwnerAnalyticsScreen renders fl_chart BarChart & performance list',
    (tester) async {
      const analytics = OwnerAnalyticsModel(
        totalRevenue: 4500000,
        totalBookings: 3,
        occupancyRate: 67,
        revenueGrowthPct: 25,
        monthlyRevenue: [
          MonthlyRevenuePoint(month: 'Okt', value: 1500000),
          MonthlyRevenuePoint(month: 'Nov', value: 3000000),
        ],
        kosPerformance: [
          KosPerformanceModel(
            title: 'Kos Melati Harmoni',
            occupancy: 67,
            booking: 3,
            revenue: 4500000,
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ownerAnalyticsProvider.overrideWith((ref) async => analytics),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const OwnerAnalyticsScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Rp 4.500.000'), findsAtLeastNWidgets(1));
      expect(find.text('Okupansi 67%'), findsOneWidget);
      expect(find.text('Kos Melati Harmoni'), findsOneWidget);
    },
  );

  testWidgets('ChatDetailScreen loads thread and disposes timer cleanly', (
    tester,
  ) async {
    final mockRepo = _MockChatRepository();
    when(() => mockRepo.fetchMessages(8)).thenAnswer(
      (_) async => const [
        MessageModel(
          id: 1,
          conversationId: 8,
          senderId: 2,
          message: 'Halo, apakah kamar A1 masih tersedia?',
        ),
        MessageModel(
          id: 2,
          conversationId: 8,
          senderId: 9,
          message: 'Masih kak, silakan jadwalkan survei.',
        ),
      ],
    );

    final conv = const ConversationModel(
      id: 8,
      counterpart: UserModel(
        id: 9,
        name: 'Budi Santoso',
        email: 'budi@email.com',
        role: UserRole.owner,
      ),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [chatRepositoryProvider.overrideWithValue(mockRepo)],
        child: MaterialApp(
          theme: AppTheme.light,
          home: ChatDetailScreen(conversationId: 8, initialConversation: conv),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Budi Santoso'), findsOneWidget);
    expect(find.text('Halo, apakah kamar A1 masih tersedia?'), findsOneWidget);
    expect(find.text('Masih kak, silakan jadwalkan survei.'), findsOneWidget);
  });
}
