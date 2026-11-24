import 'package:drift/drift.dart';

import '../../core/utils/formatters.dart';
import '../database/app_database.dart';
import 'kos_repository.dart';
import 'models.dart';

/// Transactional repository for bookings, invoices, demo payments, and owner approval.
class BookingRepository {
  const BookingRepository(this.db);

  final AppDatabase db;
  static const double adminFee = 25000.0;

  Future<BookingWithDetails> createBooking({
    required KosProperty kos,
    required int memberId,
    required String tenantName,
    required String tenantPhone,
    required String tenantEmail,
    required DateTime startDate,
    required int durationMonths,
    String? notes,
  }) async {
    final endDate = DateTime(
      startDate.year,
      startDate.month + durationMonths,
      startDate.day,
    );
    final subtotal = kos.price * durationMonths;
    final total = subtotal + adminFee;
    final stamp = DateTime.now().millisecondsSinceEpoch.toString();
    final suffix = stamp.substring(stamp.length - 5);
    final bookingCode = 'BKG-${DateTime.now().year}$suffix';
    final invoiceNum = 'INV-${DateTime.now().year}-$suffix';
    final due = DateFormatter.apiDate(
      DateTime.now().add(const Duration(days: 3)),
    );

    final bookingId = await db.transaction(() async {
      final bId = await db
          .into(db.bookings)
          .insert(
            BookingsCompanion.insert(
              bookingCode: bookingCode,
              kosId: kos.id,
              memberId: memberId,
              tenantName: tenantName.trim(),
              tenantPhone: tenantPhone.trim(),
              tenantEmail: tenantEmail.trim(),
              startDate: DateFormatter.apiDate(startDate),
              endDate: DateFormatter.apiDate(endDate),
              durationMonths: durationMonths,
              kosPrice: kos.price,
              subtotal: subtotal,
              adminFee: const Value(adminFee),
              totalAmount: total,
              notes: Value(
                notes?.trim().isEmpty ?? true ? null : notes!.trim(),
              ),
              status: const Value('pending'),
            ),
          );

      await db
          .into(db.invoices)
          .insert(
            InvoicesCompanion.insert(
              invoiceNumber: invoiceNum,
              bookingId: bId,
              memberId: memberId,
              kosId: kos.id,
              amount: subtotal,
              adminFee: const Value(adminFee),
              totalAmount: total,
              dueDate: due,
              status: const Value('unpaid'),
            ),
          );

      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: memberId,
              title: 'Pengajuan Sewa Terkirim ($bookingCode)',
              message:
                  'Booking ${kos.title} ($durationMonths bulan) menunggu persetujuan pemilik.',
              category: const Value('booking'),
            ),
          );

      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: kos.ownerId,
              title: 'Booking Baru: $bookingCode',
              message: '${tenantName.trim()} mengajukan sewa di ${kos.title}.',
              category: const Value('booking'),
            ),
          );

      return bId;
    });

    final bookings = await _fetchBookingsWithDetails(
      db.select(db.bookings)..where((b) => b.id.equals(bookingId)),
    );
    return bookings.first;
  }

  Future<List<BookingWithDetails>> getMemberBookings(int memberId) {
    return _fetchBookingsWithDetails(
      db.select(db.bookings)
        ..where((b) => b.memberId.equals(memberId))
        ..orderBy([(b) => OrderingTerm.desc(b.id)]),
    );
  }

  Future<List<BookingWithDetails>> getOwnerBookings(
    int ownerId, {
    String? status,
  }) async {
    final ownerKos = await (db.select(
      db.kosProperties,
    )..where((k) => k.ownerId.equals(ownerId))).get();
    final kosIds = ownerKos.map((k) => k.id).toList();
    if (kosIds.isEmpty) return const [];

    final query = db.select(db.bookings)
      ..where((b) {
        Expression<bool> expr = b.kosId.isIn(kosIds);
        if (status != null && status.isNotEmpty && status != 'all') {
          expr = expr & b.status.equals(status);
        }
        return expr;
      })
      ..orderBy([(b) => OrderingTerm.desc(b.id)]);

    return _fetchBookingsWithDetails(query);
  }

  Future<List<InvoiceWithDetails>> getMemberInvoices(int memberId) async {
    final rows =
        await (db.select(db.invoices).join([
                innerJoin(
                  db.bookings,
                  db.bookings.id.equalsExp(db.invoices.bookingId),
                ),
                innerJoin(
                  db.kosProperties,
                  db.kosProperties.id.equalsExp(db.invoices.kosId),
                ),
              ])
              ..where(db.invoices.memberId.equals(memberId))
              ..orderBy([OrderingTerm.desc(db.invoices.id)]))
            .get();

    return rows.map((row) {
      final inv = row.readTable(db.invoices);
      final booking = row.readTable(db.bookings);
      final kos = row.readTable(db.kosProperties);
      return InvoiceWithDetails(
        invoice: inv,
        bookingCode: booking.bookingCode,
        kosTitle: kos.title,
        tenantName: booking.tenantName,
        durationMonths: booking.durationMonths,
        startDate: booking.startDate,
        endDate: booking.endDate,
      );
    }).toList();
  }

  Future<InvoiceWithDetails?> getInvoiceDetail(int invoiceId) async {
    final row = await (db.select(db.invoices).join([
      innerJoin(db.bookings, db.bookings.id.equalsExp(db.invoices.bookingId)),
      innerJoin(
        db.kosProperties,
        db.kosProperties.id.equalsExp(db.invoices.kosId),
      ),
    ])..where(db.invoices.id.equals(invoiceId))).getSingleOrNull();
    if (row == null) return null;

    final inv = row.readTable(db.invoices);
    final booking = row.readTable(db.bookings);
    final kos = row.readTable(db.kosProperties);
    return InvoiceWithDetails(
      invoice: inv,
      bookingCode: booking.bookingCode,
      kosTitle: kos.title,
      tenantName: booking.tenantName,
      durationMonths: booking.durationMonths,
      startDate: booking.startDate,
      endDate: booking.endDate,
    );
  }

  Future<void> cancelBooking(int bookingId, int memberId) async {
    await db.transaction(() async {
      final booking = await (db.select(
        db.bookings,
      )..where((b) => b.id.equals(bookingId))).getSingleOrNull();
      if (booking == null ||
          booking.memberId != memberId ||
          booking.status != 'pending') {
        return;
      }

      await (db.update(db.bookings)..where((b) => b.id.equals(bookingId)))
          .write(const BookingsCompanion(status: Value('cancelled')));
      await (db.update(db.invoices)
            ..where((i) => i.bookingId.equals(bookingId)))
          .write(const InvoicesCompanion(status: Value('cancelled')));
    });
  }

  Future<void> payDemoInvoice(
    int invoiceId,
    int memberId,
    String method,
  ) async {
    await db.transaction(() async {
      final inv = await (db.select(
        db.invoices,
      )..where((i) => i.id.equals(invoiceId))).getSingleOrNull();
      if (inv == null || inv.memberId != memberId || inv.status == 'paid') {
        return;
      }

      final booking = await (db.select(
        db.bookings,
      )..where((b) => b.id.equals(inv.bookingId))).getSingleOrNull();
      final kos = await (db.select(
        db.kosProperties,
      )..where((k) => k.id.equals(inv.kosId))).getSingleOrNull();

      await (db.update(
        db.invoices,
      )..where((i) => i.id.equals(invoiceId))).write(
        InvoicesCompanion(
          status: const Value('paid'),
          paidAt: Value(DateTime.now()),
          paymentMethod: Value(method),
        ),
      );

      if (booking != null &&
          (booking.status == 'approved' || booking.status == 'pending')) {
        await (db.update(db.bookings)..where((b) => b.id.equals(booking.id)))
            .write(const BookingsCompanion(status: Value('confirmed')));
      }

      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: memberId,
              title: 'Pembayaran Demo Berhasil (${inv.invoiceNumber})',
              message:
                  'Booking ${booking?.bookingCode ?? ''} untuk ${kos?.title ?? 'Kos'} kini berstatus Terkonfirmasi.',
              category: const Value('invoice'),
            ),
          );

      if (kos != null) {
        await db
            .into(db.appNotifications)
            .insert(
              AppNotificationsCompanion.insert(
                userId: kos.ownerId,
                title: 'Pembayaran Masuk (${inv.invoiceNumber})',
                message:
                    '${booking?.tenantName ?? 'Penyewa'} telah melunasi booking ${booking?.bookingCode ?? ''}.',
                category: const Value('invoice'),
              ),
            );
      }
    });
  }

  Future<void> approveBooking(int bookingId) async {
    await db.transaction(() async {
      final b = await (db.select(
        db.bookings,
      )..where((r) => r.id.equals(bookingId))).getSingleOrNull();
      if (b == null || b.status != 'pending') return;

      await (db.update(db.bookings)..where((r) => r.id.equals(bookingId)))
          .write(const BookingsCompanion(status: Value('approved')));
      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: b.memberId,
              title: 'Booking Disetujui (${b.bookingCode})',
              message: 'Pemilik menyetujui pengajuan Anda. Silakan selesaikan pembayaran demo.',
              category: const Value('booking'),
            ),
          );
    });
  }

  Future<void> rejectBooking(int bookingId, String reason) async {
    await db.transaction(() async {
      final b = await (db.select(
        db.bookings,
      )..where((r) => r.id.equals(bookingId))).getSingleOrNull();
      if (b == null) return;

      await (db.update(
        db.bookings,
      )..where((r) => r.id.equals(bookingId))).write(
        BookingsCompanion(
          status: const Value('rejected'),
          rejectionReason: Value(reason.trim()),
        ),
      );
      await (db.update(db.invoices)
            ..where((i) => i.bookingId.equals(bookingId)))
          .write(const InvoicesCompanion(status: Value('cancelled')));
      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: b.memberId,
              title: 'Booking Ditolak (${b.bookingCode})',
              message: 'Alasan: ${reason.trim()}',
              category: const Value('booking'),
            ),
          );
    });
  }

  Future<void> updateBookingLifecycle(int bookingId, String nextStatus) async {
    await db.transaction(() async {
      final b = await (db.select(
        db.bookings,
      )..where((r) => r.id.equals(bookingId))).getSingleOrNull();
      if (b == null) return;
      await (db.update(db.bookings)..where((r) => r.id.equals(bookingId)))
          .write(BookingsCompanion(status: Value(nextStatus)));

      final msg = nextStatus == 'active'
          ? 'Check-in selesai! Selamat menikmati hunian Anda.'
          : 'Masa sewa telah diselesaikan.';
      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: b.memberId,
              title: 'Status Hunian Diperbarui (${b.bookingCode})',
              message: msg,
              category: const Value('booking'),
            ),
          );
    });
  }

  Future<OwnerDashboardStats> getOwnerStats(int ownerId) async {
    final properties = await KosRepository(db).searchKos(
      const KosFilterParams(),
      includeInactive: true,
      ownerId: ownerId,
    );
    final bookings = await getOwnerBookings(ownerId);
    final kosIds = properties.map((p) => p.kos.id).toList();

    var paidRevenue = 0.0;
    if (kosIds.isNotEmpty) {
      final paidInvoices = await (db.select(
        db.invoices,
      )..where((i) => i.kosId.isIn(kosIds) & i.status.equals('paid'))).get();
      for (final inv in paidInvoices) {
        paidRevenue += inv.totalAmount;
      }
    }

    final unreadNotifs = await (db.select(
      db.appNotifications,
    )..where((n) => n.userId.equals(ownerId) & n.isRead.equals(false))).get();

    return OwnerDashboardStats(
      totalProperties: properties.length,
      activeProperties: properties
          .where((p) => p.kos.status == 'active')
          .length,
      totalBookings: bookings.length,
      pendingBookings: bookings
          .where((b) => b.booking.status == 'pending')
          .length,
      paidRevenue: paidRevenue,
      unreadNotifications: unreadNotifs.length,
      properties: properties,
    );
  }

  Future<List<BookingWithDetails>> _fetchBookingsWithDetails(
    SimpleSelectStatement<$BookingsTable, Booking> query,
  ) async {
    final bookings = await query.get();
    if (bookings.isEmpty) return const [];

    final kosIds = bookings.map((b) => b.kosId).toSet().toList();
    final bookingIds = bookings.map((b) => b.id).toList();

    final kosList = await (db.select(
      db.kosProperties,
    )..where((k) => k.id.isIn(kosIds))).get();
    final invList = await (db.select(
      db.invoices,
    )..where((i) => i.bookingId.isIn(bookingIds))).get();

    final kosMap = {for (final k in kosList) k.id: k};
    final invMap = {for (final i in invList) i.bookingId: i};

    return bookings.map((b) {
      final kos = kosMap[b.kosId];
      return BookingWithDetails(
        booking: b,
        kosTitle: kos?.title ?? 'Properti Kos',
        kosCity: kos?.city ?? '-',
        kosThumbnail:
            kos?.thumbnailAsset ??
            'assets/images/placeholders/kos_placeholder.jpg',
        invoice: invMap[b.id],
      );
    }).toList();
  }
}
