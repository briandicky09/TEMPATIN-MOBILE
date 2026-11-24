import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tempatin_offline/core/security/password_hasher.dart';
import 'package:tempatin_offline/data/database/app_database.dart';
import 'package:tempatin_offline/data/database/database_seeder.dart';
import 'package:tempatin_offline/data/repositories/auth_repository.dart';
import 'package:tempatin_offline/data/repositories/booking_repository.dart';
import 'package:tempatin_offline/data/repositories/engagement_repository.dart';
import 'package:tempatin_offline/data/repositories/kos_repository.dart';
import 'package:tempatin_offline/data/repositories/models.dart';

void main() {
  late AppDatabase db;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await DatabaseSeeder(db).seedIfEmpty();
  });

  tearDown(() async {
    await db.close();
  });

  test('PasswordHasher hashes with salt and verifies without plaintext', () {
    final salt = PasswordHasher.generateSalt();
    final hash = PasswordHasher.hashPassword('password123', salt);
    expect(hash, isNot('password123'));
    expect(PasswordHasher.verify('password123', salt, hash), isTrue);
    expect(PasswordHasher.verify('wrongpass', salt, hash), isFalse);
  });

  test(
    'DatabaseSeeder is idempotent and seeds realistic TEMPATIN data',
    () async {
      // Call seedIfEmpty a second time; counts must remain identical
      await DatabaseSeeder(db).seedIfEmpty();

      final users = await db.select(db.users).get();
      final kos = await db.select(db.kosProperties).get();
      final facilities = await db.select(db.facilities).get();
      final images = await db.select(db.kosImages).get();

      expect(users.length, 2);
      expect(kos.length, 6);
      expect(facilities.length, 13);
      expect(images.length, greaterThanOrEqualTo(6));
      for (final img in images) {
        expect(img.imagePath.startsWith('assets/images/kos/'), isTrue);
      }
    },
  );

  test(
    'AuthRepository logs in seeded users, registers, and restores session',
    () async {
      final auth = AuthRepository(db, prefs);

      final dewi = await auth.login(
        email: 'dewi@email.com',
        password: 'password123',
      );
      expect(dewi.user.name, 'Dewi Sartika');
      expect(dewi.isMember, isTrue);

      final restored = await auth.restoreSession();
      expect(restored?.user.email, 'dewi@email.com');

      await auth.logout();
      expect(await auth.restoreSession(), isNull);

      final newUser = await auth.register(
        name: 'Budi Santoso',
        email: 'budi@local.test',
        password: 'secret123',
        phone: '081299988877',
      );
      expect(newUser.user.role, 'member');
      expect(newUser.profile?.phone, '081299988877');
    },
  );

  test(
    'KosRepository filters by query, type, price range, facilities, and sorts',
    () async {
      final repo = KosRepository(db);

      final putriOnly = await repo.searchKos(
        const KosFilterParams(type: 'Putri'),
      );
      expect(putriOnly.length, 2);
      expect(putriOnly.every((k) => k.kos.type == 'Putri'), isTrue);

      final budgetSort = await repo.searchKos(
        const KosFilterParams(maxPrice: 1000000, sortBy: 'price_asc'),
      );
      expect(budgetSort.isNotEmpty, isTrue);
      expect(budgetSort.first.kos.price <= budgetSort.last.kos.price, isTrue);

      final queryMalang = await repo.searchKos(
        const KosFilterParams(query: 'Malang'),
      );
      expect(queryMalang.length, 1);
      expect(queryMalang.first.kos.title, 'Kos Putra Anggrek');
    },
  );

  test(
    'Booking transaction, Owner approval, demo payment & CRUD persist cleanly',
    () async {
      final auth = AuthRepository(db, prefs);
      final kosRepo = KosRepository(db);
      final bookingRepo = BookingRepository(db);
      final engagementRepo = EngagementRepository(db);

      final member = await auth.login(
        email: 'dewi@email.com',
        password: 'password123',
      );
      final owner = await auth.login(
        email: 'owner@tempatin.id',
        password: 'password123',
      );

      final createdKosId = await kosRepo.saveKos(
        ownerId: owner.user.id,
        title: 'Kos Offline Baru',
        description: 'Kos baru pengujian CRUD SQLite lokal.',
        price: 900000,
        type: 'Campur',
        city: 'Solo',
        address: 'Jl. Slamet Riyadi No. 10',
        imagePaths: ['assets/images/kos/kos_007.png'],
        facilityIds: {1, 2},
      );

      final detail = await kosRepo.getKosDetail(
        createdKosId,
        memberId: member.user.id,
      );
      expect(detail?.kos.title, 'Kos Offline Baru');
      expect(detail?.facilities.length, 2);

      final createdBooking = await bookingRepo.createBooking(
        kos: detail!.kos,
        memberId: member.user.id,
        tenantName: member.user.name,
        tenantPhone: '081234567890',
        tenantEmail: member.user.email,
        startDate: DateTime(2026, 12, 10),
        durationMonths: 2,
      );
      expect(createdBooking.booking.status, 'pending');
      expect(createdBooking.booking.totalAmount, 900000 * 2 + 25000);
      expect(createdBooking.invoice?.status, 'unpaid');

      await bookingRepo.approveBooking(createdBooking.booking.id);
      await bookingRepo.payDemoInvoice(
        createdBooking.invoice!.id,
        member.user.id,
        'Simulasi QRIS (Offline)',
      );

      final refreshedInv = await bookingRepo.getInvoiceDetail(
        createdBooking.invoice!.id,
      );
      expect(refreshedInv?.invoice.status, 'paid');

      final memberNotifs = await engagementRepo.getNotifications(
        member.user.id,
      );
      expect(memberNotifs.isNotEmpty, isTrue);

      await kosRepo.deleteKos(createdKosId, owner.user.id);
      expect(await kosRepo.getKosDetail(createdKosId), isNull);
    },
  );
}
