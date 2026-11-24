import 'package:drift/drift.dart';

import '../../core/security/password_hasher.dart';
import 'app_database.dart';

/// Idempotent local SQLite seeder mirroring TEMPATIN's verified reference dataset.
class DatabaseSeeder {
  const DatabaseSeeder(this.db);

  final AppDatabase db;

  Future<void> seedIfEmpty() async {
    final existingUsers = await (db.select(db.users)..limit(1)).get();
    if (existingUsers.isNotEmpty) return;

    await db.transaction(() async {
      // Double-check inside transaction to avoid concurrent seeding races
      final check = await (db.select(db.users)..limit(1)).get();
      if (check.isNotEmpty) return;

      // 1. Users & Profiles (salted SHA-256, never plaintext)
      final ownerSalt = PasswordHasher.generateSalt();
      final ownerHash = PasswordHasher.hashPassword('password123', ownerSalt);
      final ownerId = await db
          .into(db.users)
          .insert(
            UsersCompanion.insert(
              name: 'Rokhim Wicaksono',
              email: 'owner@tempatin.id',
              passwordHash: ownerHash,
              passwordSalt: ownerSalt,
              role: const Value('owner'),
            ),
          );

      await db
          .into(db.userProfiles)
          .insert(
            UserProfilesCompanion.insert(
              userId: ownerId,
              phone: const Value('08028621673'),
              address: const Value('Jl. Kalirungkut No. 88, Surabaya'),
              bio: const Value('Pemilik & pengelola properti kos TEMPATIN.'),
              avatarAsset: const Value('assets/images/logo-symbol.png'),
            ),
          );

      final memberSalt = PasswordHasher.generateSalt();
      final memberHash = PasswordHasher.hashPassword('password123', memberSalt);
      final memberId = await db
          .into(db.users)
          .insert(
            UsersCompanion.insert(
              name: 'Dewi Sartika',
              email: 'dewi@email.com',
              passwordHash: memberHash,
              passwordSalt: memberSalt,
              role: const Value('member'),
            ),
          );

      await db
          .into(db.userProfiles)
          .insert(
            UserProfilesCompanion.insert(
              userId: memberId,
              phone: const Value('081234567890'),
              address: const Value('Jl. Ahmad Yani No. 15, Surabaya'),
              bio: const Value('Mahasiswi mencari kos nyaman dan tenang.'),
              avatarAsset: const Value('assets/images/logo-symbol.png'),
            ),
          );

      // 2. Master Facilities (13 items matching FacilitySeeder)
      final facilityDefs = [
        ('WiFi', 'wifi', 'wifi'),
        ('AC', 'ac', 'wind'),
        ('Kamar Mandi Dalam', 'kamar-mandi-dalam', 'bath'),
        ('Kasur', 'kasur', 'bed'),
        ('Lemari', 'lemari', 'archive'),
        ('Meja', 'meja', 'laptop'),
        ('Kursi', 'kursi', 'armchair'),
        ('Parkir Motor', 'parkir-motor', 'bike'),
        ('Parkir Mobil', 'parkir-mobil', 'car'),
        ('Dapur', 'dapur', 'utensils'),
        ('CCTV', 'cctv', 'video'),
        ('Laundry', 'laundry', 'shirt'),
        ('Listrik', 'listrik', 'zap'),
      ];

      final facilityIdByName = <String, int>{};
      for (final f in facilityDefs) {
        final fId = await db
            .into(db.facilities)
            .insert(
              FacilitiesCompanion.insert(
                name: f.$1,
                slug: f.$2,
                iconKey: Value(f.$3),
              ),
            );
        facilityIdByName[f.$1] = fId;
      }

      // 3. Kos Properties + Local Images + Facilities
      Future<int> insertKos({
        required String slug,
        required String title,
        required String description,
        required double price,
        required String type,
        required String city,
        required String address,
        required String thumbnail,
        required List<String> gallery,
        required List<String> facilities,
        required String area,
        required String bathrooms,
        required String garages,
        bool isFeatured = false,
      }) async {
        final kosId = await db
            .into(db.kosProperties)
            .insert(
              KosPropertiesCompanion.insert(
                ownerId: ownerId,
                slug: slug,
                title: title,
                description: description,
                price: price,
                type: type,
                city: city,
                address: address,
                thumbnailAsset: thumbnail,
                area: Value(area),
                roomsCount: const Value('12'),
                bathrooms: Value(bathrooms),
                garages: Value(garages),
                isFeatured: Value(isFeatured),
              ),
            );

        for (var i = 0; i < gallery.length; i++) {
          await db
              .into(db.kosImages)
              .insert(
                KosImagesCompanion.insert(
                  kosId: kosId,
                  imagePath: gallery[i],
                  sortOrder: Value(i),
                ),
              );
        }

        for (final name in facilities) {
          final fid = facilityIdByName[name];
          if (fid != null) {
            await db
                .into(db.kosFacilities)
                .insert(
                  KosFacilitiesCompanion.insert(kosId: kosId, facilityId: fid),
                );
          }
        }
        return kosId;
      }

      const melatiFacs = [
        'WiFi',
        'AC',
        'Kamar Mandi Dalam',
        'Kasur',
        'Lemari',
        'Listrik',
        'CCTV',
      ];
      const anggrekFacs = [
        'WiFi',
        'Kasur',
        'Lemari',
        'Meja',
        'Kursi',
        'Parkir Motor',
        'Listrik',
      ];

      final kosMelatiId = await insertKos(
        slug: 'kos-putri-melati',
        title: 'Kos Putri Melati',
        description: 'Menikmati hunian eksklusif di kawasan Kalirungkut. Fasilitas lengkap, kamar mandi dalam, AC, Wi-Fi cepat, CCTV 24 jam, dan lingkungan tenang.',
        price: 850000,
        type: 'Putri',
        city: 'Surabaya',
        address: 'Jl. Kalirungkut No. 88, Ruko Rungkut Makmur Blok C, Surabaya',
        thumbnail: 'assets/images/kos/kos_001.png',
        gallery: [
          'assets/images/kos/kos_001.png',
          'assets/images/kos/detail_01.jpg',
          'assets/images/kos/detail_02.jpg',
        ],
        facilities: melatiFacs,
        area: '16 m²',
        bathrooms: 'Dalam',
        garages: 'Motor',
        isFeatured: true,
      );

      await insertKos(
        slug: 'kos-putra-anggrek',
        title: 'Kos Putra Anggrek',
        description: 'Kos putra lokasi strategis dekat kampus dan pusat kota Malang. Lingkungan aman, akses 24 jam, dan fasilitas lengkap untuk mahasiswa.',
        price: 750000,
        type: 'Putra',
        city: 'Malang',
        address: 'Jl. Soekarno Hatta No. 12, Malang',
        thumbnail: 'assets/images/kos/kos_002.png',
        gallery: [
          'assets/images/kos/kos_002.png',
          'assets/images/kos/detail_03.jpg',
        ],
        facilities: anggrekFacs,
        area: '12 m²',
        bathrooms: 'Luar',
        garages: 'Motor',
      );

      final kosLavenderId = await insertKos(
        slug: 'kos-eksklusif-lavender',
        title: "Kos Eksklusif D'Lavender",
        description: 'Kos eksklusif modern dekat kampus UGM Yogyakarta. Keamanan 24 jam, kamar mandi dalam air hangat, dan layanan laundry mingguan.',
        price: 1500000,
        type: 'Eksklusif',
        city: 'Yogyakarta',
        address: 'Jl. Kaliurang KM 5.5 No. 42, Sleman, Yogyakarta',
        thumbnail: 'assets/images/kos/kos_003.png',
        gallery: [
          'assets/images/kos/kos_003.png',
          'assets/images/kos/detail_04.jpg',
          'assets/images/kos/detail_05.jpg',
        ],
        facilities: [...melatiFacs, 'Laundry', 'Parkir Mobil'],
        area: '20 m²',
        bathrooms: 'Dalam',
        garages: 'Motor & Mobil',
        isFeatured: true,
      );

      await insertKos(
        slug: 'kos-putra-cendana',
        title: 'Kos Putra Cendana ITB',
        description: 'Kos nyaman strategis 5 menit jalan kaki ke kampus ITB Ganesha Bandung. Sirkulasi udara sejuk dan area belajar bersama.',
        price: 950000,
        type: 'Putra',
        city: 'Bandung',
        address: 'Jl. Dago Asri No. 18, Bandung',
        thumbnail: 'assets/images/kos/kos_004.png',
        gallery: [
          'assets/images/kos/kos_004.png',
          'assets/images/kos/detail_01.jpg',
        ],
        facilities: [...anggrekFacs, 'Dapur'],
        area: '14 m²',
        bathrooms: 'Dalam',
        garages: 'Motor',
      );

      final kosMawarId = await insertKos(
        slug: 'kos-putri-mawar-asri',
        title: 'Kos Putri Mawar Asri',
        description: 'Hunian tenang khusus mahasiswi dan karyawati di Jakarta Selatan. Dekat stasiun MRT Fatmawati dan pusat perkantoran.',
        price: 1250000,
        type: 'Putri',
        city: 'Jakarta',
        address: 'Jl. Fatmawati Raya No. 27, Jakarta Selatan',
        thumbnail: 'assets/images/kos/kos_005.png',
        gallery: [
          'assets/images/kos/kos_005.png',
          'assets/images/kos/detail_02.jpg',
        ],
        facilities: [...melatiFacs, 'Dapur'],
        area: '15 m²',
        bathrooms: 'Dalam',
        garages: 'Motor',
        isFeatured: true,
      );

      await insertKos(
        slug: 'kos-harmoni-residence',
        title: 'Kos Harmoni Residence',
        description: 'Kos campur eksklusif dekat kawasan Simpang Lima Semarang. Dilengkapi dapur bersama, keamanan CCTV, dan parkir mobil luas.',
        price: 1100000,
        type: 'Campur',
        city: 'Semarang',
        address: 'Jl. Pandanaran No. 70, Semarang',
        thumbnail: 'assets/images/kos/kos_006.png',
        gallery: [
          'assets/images/kos/kos_006.png',
          'assets/images/kos/kos_007.png',
        ],
        facilities: [...anggrekFacs, 'Parkir Mobil', 'CCTV'],
        area: '18 m²',
        bathrooms: 'Dalam',
        garages: 'Motor & Mobil',
      );

      // 4. Bookings & Invoices
      final confirmedBookingId = await db
          .into(db.bookings)
          .insert(
            BookingsCompanion.insert(
              bookingCode: 'BKG-202608-0001',
              kosId: kosMelatiId,
              memberId: memberId,
              tenantName: 'Dewi Sartika',
              tenantPhone: '081234567890',
              tenantEmail: 'dewi@email.com',
              startDate: '2026-08-05',
              endDate: '2026-09-05',
              durationMonths: 1,
              kosPrice: 850000,
              subtotal: 850000,
              totalAmount: 875000,
              notes: const Value('Mohon disiapkan kamar di lantai 1.'),
              status: const Value('confirmed'),
            ),
          );

      await db
          .into(db.invoices)
          .insert(
            InvoicesCompanion.insert(
              invoiceNumber: 'INV-2026-08-0001',
              bookingId: confirmedBookingId,
              memberId: memberId,
              kosId: kosMelatiId,
              amount: 850000,
              totalAmount: 875000,
              dueDate: '2026-08-03',
              paidAt: Value(DateTime(2026, 8, 2, 14, 30)),
              paymentMethod: const Value('Simulasi Transfer BCA (Offline)'),
              status: const Value('paid'),
            ),
          );

      // Pending demo booking so Owner approval workflow can be demonstrated immediately
      final pendingBookingId = await db
          .into(db.bookings)
          .insert(
            BookingsCompanion.insert(
              bookingCode: 'BKG-202611-0002',
              kosId: kosLavenderId,
              memberId: memberId,
              tenantName: 'Dewi Sartika',
              tenantPhone: '081234567890',
              tenantEmail: 'dewi@email.com',
              startDate: '2026-12-01',
              endDate: '2027-02-01',
              durationMonths: 2,
              kosPrice: 1500000,
              subtotal: 3000000,
              totalAmount: 3025000,
              notes: const Value(
                '[Data Demo] Pengajuan menunggu persetujuan pemilik.',
              ),
              status: const Value('pending'),
            ),
          );

      await db
          .into(db.invoices)
          .insert(
            InvoicesCompanion.insert(
              invoiceNumber: 'INV-2026-11-0002',
              bookingId: pendingBookingId,
              memberId: memberId,
              kosId: kosLavenderId,
              amount: 3000000,
              totalAmount: 3025000,
              dueDate: '2026-11-30',
              status: const Value('unpaid'),
            ),
          );

      // 5. Reviews & Favorites
      await db
          .into(db.reviews)
          .insert(
            ReviewsCompanion.insert(
              kosId: kosMelatiId,
              memberId: memberId,
              reviewerName: 'Dewi Sartika',
              rating: 5,
              comment: 'Tempatnya bersih, nyaman sekali untuk istirahat setelah kuliah, dan ibu kos sangat ramah dan responsif!',
              ownerReply: const Value(
                'Terima kasih Mbak Dewi, senang bisa melayani dengan baik. Semoga betah tinggal di Kos Putri Melati!',
              ),
            ),
          );

      await db
          .into(db.favorites)
          .insert(
            FavoritesCompanion.insert(memberId: memberId, kosId: kosMelatiId),
          );
      await db
          .into(db.favorites)
          .insert(
            FavoritesCompanion.insert(memberId: memberId, kosId: kosMawarId),
          );

      // 6. Local Notifications
      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: memberId,
              title: 'Booking BKG-202608-0001 Terkonfirmasi',
              message: 'Pembayaran untuk Kos Putri Melati (INV-2026-08-0001) telah lunas.',
              category: const Value('booking'),
            ),
          );
      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: memberId,
              title: 'Menunggu Persetujuan Pemilik',
              message: 'Pengajuan BKG-202611-0002 di Kos Eksklusif D\'Lavender sedang ditinjau.',
              category: const Value('booking'),
            ),
          );
      await db
          .into(db.appNotifications)
          .insert(
            AppNotificationsCompanion.insert(
              userId: ownerId,
              title: 'Pengajuan Booking Baru: BKG-202611-0002',
              message: 'Dewi Sartika mengajukan sewa 2 bulan di Kos Eksklusif D\'Lavender.',
              category: const Value('booking'),
            ),
          );
    });
  }
}
