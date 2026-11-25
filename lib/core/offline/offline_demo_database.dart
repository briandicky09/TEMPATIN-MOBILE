import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

/// Persistent local SQLite database powering TEMPATIN Offline Demo Mode.
///
/// Mirrors the relational Laravel domain schema (`users`, `kos`, `kos_photos`,
/// `facilities`, `kos_facilities`, `rooms`, `favorites`, `bookings`, `invoices`,
/// `payments`, `rental_contracts`, `surveys`, `maintenance_reports`, `reviews`,
/// `conversations`, `messages`, `notifications`, `sessions`) and seeds realistic
/// Indonesian kos listings using bundled local assets (`assets/images/kos/*`).
class OfflineDemoDatabase {
  OfflineDemoDatabase({
    this.factoryOverride,
    this.dbPathOverride,
  });

  final DatabaseFactory? factoryOverride;
  final String? dbPathOverride;

  Database? _db;
  Future<Database>? _openingFuture;

  Future<Database> get database async {
    final existing = _db;
    if (existing != null && existing.isOpen) return existing;
    return _openingFuture ??= _open();
  }

  Future<Database> _open() async {
    final factory = factoryOverride ?? databaseFactory;
    final path =
        dbPathOverride ??
        p.join(await factory.getDatabasesPath(), 'tempatin_demo.db');

    final db = await factory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
        onCreate: (db, version) async {
          await _createSchema(db);
        },
      ),
    );
    await _seedIfEmpty(db);
    _db = db;
    return db;
  }

  Future<void> resetDemoData() async {
    final db = await database;
    await db.transaction((txn) async {
      const tables = [
        'messages',
        'conversations',
        'notifications',
        'maintenance_reports',
        'payments',
        'rental_contracts',
        'invoices',
        'bookings',
        'surveys',
        'reviews',
        'favorites',
        'rooms',
        'kos_facilities',
        'kos_photos',
        'kos',
        'facilities',
        'sessions',
        'users',
      ];
      for (final table in tables) {
        await txn.delete(table);
      }
      await _insertSeedData(txn);
    });
  }

  Future<void> close() async {
    final db = _db;
    _db = null;
    _openingFuture = null;
    if (db != null && db.isOpen) {
      await db.close();
    }
  }

  Future<void> _createSchema(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        role TEXT NOT NULL,
        phone TEXT,
        avatar_url TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE sessions (
        token TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE facilities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        slug TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE kos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        owner_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        slug TEXT NOT NULL UNIQUE,
        description TEXT,
        price REAL NOT NULL,
        type TEXT NOT NULL,
        city TEXT NOT NULL,
        address TEXT,
        thumbnail_url TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'active',
        area TEXT,
        rooms_summary TEXT,
        bathrooms TEXT,
        bedrooms TEXT,
        garages TEXT,
        latitude REAL,
        longitude REAL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (owner_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE kos_photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kos_id INTEGER NOT NULL,
        photo_url TEXT NOT NULL,
        sort_order INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE kos_facilities (
        kos_id INTEGER NOT NULL,
        facility_id INTEGER NOT NULL,
        PRIMARY KEY (kos_id, facility_id),
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE,
        FOREIGN KEY (facility_id) REFERENCES facilities (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE rooms (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kos_id INTEGER NOT NULL,
        room_number TEXT NOT NULL,
        floor TEXT,
        room_type TEXT,
        price_override REAL,
        status TEXT NOT NULL DEFAULT 'available',
        notes TEXT,
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE favorites (
        user_id INTEGER NOT NULL,
        kos_id INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        PRIMARY KEY (user_id, kos_id),
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        booking_code TEXT NOT NULL UNIQUE,
        kos_id INTEGER NOT NULL,
        room_id INTEGER,
        customer_id INTEGER NOT NULL,
        tenant_name TEXT NOT NULL,
        tenant_phone TEXT NOT NULL,
        tenant_email TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT NOT NULL,
        duration_months INTEGER NOT NULL DEFAULT 1,
        kos_price REAL NOT NULL,
        subtotal REAL NOT NULL,
        admin_fee REAL NOT NULL DEFAULT 25000,
        total_amount REAL NOT NULL,
        notes TEXT,
        status TEXT NOT NULL,
        rejection_reason TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE,
        FOREIGN KEY (room_id) REFERENCES rooms (id) ON DELETE SET NULL,
        FOREIGN KEY (customer_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE invoices (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        invoice_number TEXT NOT NULL UNIQUE,
        booking_id INTEGER NOT NULL UNIQUE,
        amount REAL NOT NULL,
        admin_fee REAL NOT NULL DEFAULT 25000,
        tax REAL NOT NULL DEFAULT 0,
        total_amount REAL NOT NULL,
        due_date TEXT,
        paid_at TEXT,
        status TEXT NOT NULL,
        created_at TEXT NOT NULL,
        FOREIGN KEY (booking_id) REFERENCES bookings (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE payments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        payment_code TEXT NOT NULL UNIQUE,
        invoice_id INTEGER NOT NULL,
        order_id TEXT,
        payment_method TEXT NOT NULL,
        payment_channel TEXT,
        transaction_id TEXT,
        amount REAL NOT NULL,
        status TEXT NOT NULL,
        paid_at TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (invoice_id) REFERENCES invoices (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE rental_contracts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        contract_number TEXT NOT NULL UNIQUE,
        booking_id INTEGER NOT NULL UNIQUE,
        terms TEXT NOT NULL,
        status TEXT NOT NULL,
        is_signed INTEGER NOT NULL DEFAULT 0,
        signed_at TEXT,
        signer_ip TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (booking_id) REFERENCES bookings (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE surveys (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kos_id INTEGER NOT NULL,
        customer_id INTEGER NOT NULL,
        survey_date TEXT NOT NULL,
        survey_time TEXT NOT NULL,
        notes TEXT,
        status TEXT NOT NULL,
        rejection_reason TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE,
        FOREIGN KEY (customer_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE maintenance_reports (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        booking_id INTEGER NOT NULL,
        customer_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        photo_url TEXT,
        status TEXT NOT NULL,
        owner_notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (booking_id) REFERENCES bookings (id) ON DELETE CASCADE,
        FOREIGN KEY (customer_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE reviews (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kos_id INTEGER NOT NULL,
        user_id INTEGER NOT NULL,
        reviewer_name TEXT NOT NULL,
        is_verified_tenant INTEGER NOT NULL DEFAULT 0,
        rating INTEGER NOT NULL,
        comment TEXT NOT NULL,
        reply TEXT,
        user_avatar_url TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE conversations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        kos_id INTEGER NOT NULL,
        customer_id INTEGER NOT NULL,
        owner_id INTEGER NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (kos_id) REFERENCES kos (id) ON DELETE CASCADE,
        FOREIGN KEY (customer_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (owner_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        conversation_id INTEGER NOT NULL,
        sender_id INTEGER NOT NULL,
        message TEXT NOT NULL,
        is_read INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        FOREIGN KEY (conversation_id) REFERENCES conversations (id) ON DELETE CASCADE,
        FOREIGN KEY (sender_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE notifications (
        id TEXT PRIMARY KEY,
        user_id INTEGER NOT NULL,
        title TEXT NOT NULL,
        message TEXT NOT NULL,
        category TEXT NOT NULL,
        action_type TEXT,
        action_id TEXT,
        action_url TEXT,
        read_at TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> _seedIfEmpty(Database db) async {
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM users'),
    );
    if ((count ?? 0) > 0) return;

    await db.transaction((txn) async {
      await _insertSeedData(txn);
    });
  }

  Future<void> _insertSeedData(DatabaseExecutor db) async {
    final now = DateTime.now();
    String iso(Duration delta) => now.subtract(delta).toIso8601String();
    String day(int offsetDays) {
      final d = now.add(Duration(days: offsetDays));
      return '${d.year.toString().padLeft(4, '0')}-'
          '${d.month.toString().padLeft(2, '0')}-'
          '${d.day.toString().padLeft(2, '0')}';
    }

    // 1. Seed Users
    await db.insert('users', {
      'id': 1,
      'name': 'Budi Santoso',
      'email': 'owner@tempatin.id',
      'password': 'password123',
      'role': 'owner',
      'phone': '+62 812-2200-1100',
      'avatar_url': null,
      'created_at': iso(const Duration(days: 120)),
    });
    await db.insert('users', {
      'id': 2,
      'name': 'Dewi Lestari',
      'email': 'dewi@email.com',
      'password': 'password123',
      'role': 'customer',
      'phone': '+62 813-4567-8901',
      'avatar_url': null,
      'created_at': iso(const Duration(days: 90)),
    });
    await db.insert('users', {
      'id': 3,
      'name': 'Rafi Pratama',
      'email': 'rafi@email.com',
      'password': 'password123',
      'role': 'customer',
      'phone': '+62 815-9988-7766',
      'avatar_url': null,
      'created_at': iso(const Duration(days: 60)),
    });

    // 2. Seed Facilities
    const facilities = [
      (1, 'Wi-Fi 100 Mbps', 'wifi'),
      (2, 'AC', 'ac'),
      (3, 'Kamar Mandi Dalam', 'kamar-mandi-dalam'),
      (4, 'Kasur Springbed', 'kasur'),
      (5, 'Parkir Motor & Mobil', 'parkir'),
      (6, 'Dapur Bersama', 'dapur'),
      (7, 'Mesin Cuci & Laundry', 'laundry'),
      (8, 'CCTV 24 Jam', 'cctv'),
    ];
    for (final (id, name, slug) in facilities) {
      await db.insert('facilities', {'id': id, 'name': name, 'slug': slug});
    }

    // 3. Seed 7 realistic Kos properties using local bundled photos
    final kosList = <Map<String, dynamic>>[
      {
        'id': 1,
        'owner_id': 1,
        'title': 'Kos Mentari Eksklusif Pogung',
        'slug': 'kos-mentari-eksklusif-pogung',
        'description':
            'Hunian eksklusif bergaya minimalis hangat hanya 4 menit dari Fakultas Teknik UGM. Dilengkapi kamar mandi dalam water heater, meja kerja ergonomis, dan akses smartlock 24 jam.',
        'price': 1850000.0,
        'type': 'Campur',
        'city': 'Yogyakarta',
        'address': 'Jl. Kaliurang KM 5.5, Pogung Baru, Sleman, Yogyakarta',
        'thumbnail_url': 'assets/images/kos/kos_001.png',
        'status': 'active',
        'area': '4 x 5 m',
        'rooms_summary': '12 Kamar',
        'bathrooms': 'Dalam',
        'bedrooms': '1 Bed Queen',
        'garages': 'Motor & Mobil',
        'latitude': -7.7638,
        'longitude': 110.3765,
        'created_at': iso(const Duration(days: 45)),
        'facs': [1, 2, 3, 4, 5, 6, 8],
        'photos': [
          'assets/images/kos/kos_001.png',
          'assets/images/kos/detail_01.jpg',
          'assets/images/kos/detail_02.jpg',
        ],
      },
      {
        'id': 2,
        'owner_id': 1,
        'title': 'Paviliun Dago Asri Residence',
        'slug': 'paviliun-dago-asri-residence',
        'description':
            'Kos tenang dengan pencahayaan alami dan taman tengah di kawasan Dago, 6 menit menuju ITB. Cocok untuk mahasiswa pascasarjana dan pekerja remote.',
        'price': 2100000.0,
        'type': 'Putri',
        'city': 'Bandung',
        'address': 'Jl. Ir. H. Juanda No. 142, Dago, Coblong, Bandung',
        'thumbnail_url': 'assets/images/kos/kos_002.png',
        'status': 'active',
        'area': '4 x 4.5 m',
        'rooms_summary': '10 Kamar',
        'bathrooms': 'Dalam',
        'bedrooms': '1 Bed',
        'garages': 'Parkir Luas',
        'latitude': -6.8856,
        'longitude': 107.6138,
        'created_at': iso(const Duration(days: 40)),
        'facs': [1, 2, 3, 4, 7, 8],
        'photos': [
          'assets/images/kos/kos_002.png',
          'assets/images/kos/detail_03.jpg',
          'assets/images/kos/detail_04.jpg',
        ],
      },
      {
        'id': 3,
        'owner_id': 1,
        'title': 'Kos Harmoni Kemang Residence',
        'slug': 'kos-harmoni-kemang-residence',
        'description':
            'Apartemen kos modern di jantung Kemang dengan akses cepat menuju SCBD & MRT Blok M. Interior clean warm wood, dapur bersih, dan housekeeping mingguan.',
        'price': 2950000.0,
        'type': 'Campur',
        'city': 'Jakarta Selatan',
        'address': 'Jl. Kemang Timur No. 28, Mampang Prapatan, Jakarta Selatan',
        'thumbnail_url': 'assets/images/kos/kos_003.png',
        'status': 'active',
        'area': '4.5 x 5 m',
        'rooms_summary': '16 Kamar',
        'bathrooms': 'Dalam + Water Heater',
        'bedrooms': 'Queen + Smart TV',
        'garages': 'Basement',
        'latitude': -6.2654,
        'longitude': 106.8195,
        'created_at': iso(const Duration(days: 35)),
        'facs': [1, 2, 3, 4, 5, 6, 7, 8],
        'photos': [
          'assets/images/kos/kos_003.png',
          'assets/images/kos/detail_05.jpg',
          'assets/images/kos/detail_01.jpg',
        ],
      },
      {
        'id': 4,
        'owner_id': 1,
        'title': 'Griya Kukusan UI Depok',
        'slug': 'griya-kukusan-ui-depok',
        'description':
            'Pilihan favorit mahasiswa UI Kukusan dengan lingkungan aman, Wi-Fi fiber khusus setiap lantai, dan ruang belajar bersama ber-AC.',
        'price': 1450000.0,
        'type': 'Putra',
        'city': 'Depok',
        'address': 'Jl. KH. Usman No. 19, Kukusan, Beji, Depok',
        'thumbnail_url': 'assets/images/kos/kos_004.png',
        'status': 'active',
        'area': '3.5 x 4 m',
        'rooms_summary': '14 Kamar',
        'bathrooms': 'Dalam',
        'bedrooms': 'Single Premium',
        'garages': 'Motor 18 Slot',
        'latitude': -6.3642,
        'longitude': 106.8211,
        'created_at': iso(const Duration(days: 30)),
        'facs': [1, 2, 3, 4, 5, 8],
        'photos': [
          'assets/images/kos/kos_004.png',
          'assets/images/kos/detail_02.jpg',
          'assets/images/kos/detail_03.jpg',
        ],
      },
      {
        'id': 5,
        'owner_id': 1,
        'title': 'Rumah Teduh Dharmawangsa',
        'slug': 'rumah-teduh-dharmawangsa',
        'description':
            'Kos putri tenang dekat RS Dr. Soetomo dan Kampus UNAIR Surabaya. Halaman asri, penjaga 24 jam, dan paket laundry opsional.',
        'price': 1650000.0,
        'type': 'Putri',
        'city': 'Surabaya',
        'address': 'Jl. Dharmawangsa Dalam Selatan No. 8, Gubeng, Surabaya',
        'thumbnail_url': 'assets/images/kos/kos_005.png',
        'status': 'active',
        'area': '4 x 4 m',
        'rooms_summary': '8 Kamar',
        'bathrooms': 'Dalam',
        'bedrooms': 'Queen',
        'garages': 'Motor & Mobil',
        'latitude': -7.2741,
        'longitude': 112.7582,
        'created_at': iso(const Duration(days: 22)),
        'facs': [1, 2, 3, 4, 6, 7, 8],
        'photos': [
          'assets/images/kos/kos_005.png',
          'assets/images/kos/detail_04.jpg',
        ],
      },
      {
        'id': 6,
        'owner_id': 1,
        'title': 'Seturan Co-Living Studio',
        'slug': 'seturan-co-living-studio',
        'description':
            'Studio co-living modern dekat UPN, Atma Jaya, dan YKPN. Desain industrial hangat, pantry bersama, dan rooftop santai.',
        'price': 1750000.0,
        'type': 'Campur',
        'city': 'Yogyakarta',
        'address': 'Jl. Seturan Raya No. 64, Caturtunggal, Sleman, Yogyakarta',
        'thumbnail_url': 'assets/images/kos/kos_006.png',
        'status': 'active',
        'area': '4 x 4.5 m',
        'rooms_summary': '12 Kamar',
        'bathrooms': 'Dalam',
        'bedrooms': 'Queen',
        'garages': 'Motor & Mobil',
        'latitude': -7.7689,
        'longitude': 110.4101,
        'created_at': iso(const Duration(days: 15)),
        'facs': [1, 2, 3, 4, 5, 6, 8],
        'photos': [
          'assets/images/kos/kos_006.png',
          'assets/images/kos/detail_05.jpg',
        ],
      },
      {
        'id': 7,
        'owner_id': 1,
        'title': 'Paviliun Ciumbuleuit View',
        'slug': 'paviliun-ciumbuleuit-view',
        'description':
            'Hunian sejuk di lereng Ciumbuleuit dekat UNPAR. Balkon pribadi, udara pegunungan, dan akses parkir aman.',
        'price': 1950000.0,
        'type': 'Putra',
        'city': 'Bandung',
        'address': 'Jl. Ciumbuleuit No. 89, Hegarmanah, Bandung',
        'thumbnail_url': 'assets/images/kos/kos_007.png',
        'status': 'active',
        'area': '4 x 5 m',
        'rooms_summary': '9 Kamar',
        'bathrooms': 'Dalam',
        'bedrooms': 'Queen',
        'garages': 'Motor & Mobil',
        'latitude': -6.8742,
        'longitude': 107.6048,
        'created_at': iso(const Duration(days: 8)),
        'facs': [1, 2, 3, 4, 5, 7, 8],
        'photos': [
          'assets/images/kos/kos_007.png',
          'assets/images/kos/detail_01.jpg',
        ],
      },
    ];

    for (final k in kosList) {
      final facs = k['facs'] as List<int>;
      final photos = k['photos'] as List<String>;
      final row = Map<String, dynamic>.from(k)
        ..remove('facs')
        ..remove('photos');
      await db.insert('kos', row);

      for (final fid in facs) {
        await db.insert('kos_facilities', {
          'kos_id': k['id'],
          'facility_id': fid,
        });
      }
      for (var i = 0; i < photos.length; i++) {
        await db.insert('kos_photos', {
          'kos_id': k['id'],
          'photo_url': photos[i],
          'sort_order': i,
        });
      }

      // Create 3 rooms per kos (id deterministic)
      final kosId = k['id'] as int;
      final basePrice = k['price'] as double;
      await db.insert('rooms', {
        'id': (kosId - 1) * 3 + 1,
        'kos_id': kosId,
        'room_number': '${String.fromCharCode(64 + kosId)}-101',
        'floor': 'Lantai 1',
        'room_type': 'Deluxe',
        'price_override': null,
        'status': kosId == 1 ? 'occupied' : 'available',
        'notes': 'Menghadap taman dalam, pencahayaan pagi.',
      });
      await db.insert('rooms', {
        'id': (kosId - 1) * 3 + 2,
        'kos_id': kosId,
        'room_number': '${String.fromCharCode(64 + kosId)}-201',
        'floor': 'Lantai 2',
        'room_type': 'Suite Balcony',
        'price_override': basePrice + 200000,
        'status': 'available',
        'notes': 'Dengan balkon pribadi dan meja kerja luas.',
      });
      await db.insert('rooms', {
        'id': (kosId - 1) * 3 + 3,
        'kos_id': kosId,
        'room_number': '${String.fromCharCode(64 + kosId)}-202',
        'floor': 'Lantai 2',
        'room_type': 'Standard AC',
        'price_override': null,
        'status': kosId == 3 ? 'maintenance' : 'available',
        'notes': 'Dekat pantry dan area santai lantai 2.',
      });
    }

    // 4. Seed Reviews
    final seedReviews = [
      (
        1,
        2,
        'Dewi Lestari',
        1,
        5,
        'Bersih banget, internet kencang buat WFH/kuliah, pemilik juga sangat responsif.',
        'Terima kasih Kak Dewi! Senang sekali Kakak betah tinggal di Kos Mentari.',
        iso(const Duration(days: 12)),
      ),
      (
        1,
        3,
        'Rafi Pratama',
        1,
        5,
        'Lokasinya strategis ke UGM dan cari makan gampang. Parkir motor luas dan aman.',
        null,
        iso(const Duration(days: 7)),
      ),
      (
        2,
        2,
        'Dewi Lestari',
        0,
        5,
        'Lingkungan Dago super tenang dan adem, cocok banget buat fokus skripsi.',
        null,
        iso(const Duration(days: 18)),
      ),
      (
        3,
        3,
        'Rafi Pratama',
        0,
        4,
        'Kamar luas dan modern, akses ke MRT gampang. Worth it untuk area Kemang.',
        null,
        iso(const Duration(days: 9)),
      ),
    ];
    for (final r in seedReviews) {
      await db.insert('reviews', {
        'kos_id': r.$1,
        'user_id': r.$2,
        'reviewer_name': r.$3,
        'is_verified_tenant': r.$4,
        'rating': r.$5,
        'comment': r.$6,
        'reply': r.$7,
        'user_avatar_url': null,
        'created_at': r.$8,
      });
    }

    // 5. Favorites for Dewi
    await db.insert('favorites', {
      'user_id': 2,
      'kos_id': 1,
      'created_at': iso(const Duration(days: 20)),
    });
    await db.insert('favorites', {
      'user_id': 2,
      'kos_id': 2,
      'created_at': iso(const Duration(days: 5)),
    });

    // 6. Bookings + Invoices + Payments + Contracts
    // Booking 1: Active checked-in booking for Dewi (Paid + Signed Contract)
    await db.insert('bookings', {
      'id': 1,
      'booking_code': 'BOOK-2026-0001',
      'kos_id': 1,
      'room_id': 1,
      'customer_id': 2,
      'tenant_name': 'Dewi Lestari',
      'tenant_phone': '+62 813-4567-8901',
      'tenant_email': 'dewi@email.com',
      'start_date': day(-15),
      'end_date': day(165),
      'duration_months': 6,
      'kos_price': 1850000.0,
      'subtotal': 11100000.0,
      'admin_fee': 25000.0,
      'total_amount': 11125000.0,
      'notes': 'Membawa 1 sepeda motor dan butuh akses parkir.',
      'status': 'active',
      'rejection_reason': null,
      'created_at': iso(const Duration(days: 20)),
    });
    await db.insert('invoices', {
      'id': 1,
      'invoice_number': 'INV-2026-0001',
      'booking_id': 1,
      'amount': 11100000.0,
      'admin_fee': 25000.0,
      'tax': 0.0,
      'total_amount': 11125000.0,
      'due_date': day(-16),
      'paid_at': iso(const Duration(days: 17)),
      'status': 'paid',
      'created_at': iso(const Duration(days: 19)),
    });
    await db.insert('payments', {
      'id': 1,
      'payment_code': 'PAY-2026-0001',
      'invoice_id': 1,
      'order_id': 'ORD-DEMO-0001',
      'payment_method': 'bank_transfer',
      'payment_channel': 'BCA Virtual Account (Demo)',
      'transaction_id': 'TRX-DEMO-20260001',
      'amount': 11125000.0,
      'status': 'success',
      'paid_at': iso(const Duration(days: 17)),
      'created_at': iso(const Duration(days: 17)),
    });
    await db.insert('rental_contracts', {
      'id': 1,
      'contract_number': 'CTR-2026-0001',
      'booking_id': 1,
      'terms': _defaultContractTerms('Kos Mentari Eksklusif Pogung', 'A-101'),
      'status': 'signed',
      'is_signed': 1,
      'signed_at': iso(const Duration(days: 16)),
      'signer_ip': '127.0.0.1 (Offline Demo)',
      'created_at': iso(const Duration(days: 17)),
    });

    // Booking 2: Approved waiting customer demo payment (Paviliun Dago Asri)
    await db.insert('bookings', {
      'id': 2,
      'booking_code': 'BOOK-2026-0002',
      'kos_id': 2,
      'room_id': 5,
      'customer_id': 2,
      'tenant_name': 'Dewi Lestari',
      'tenant_phone': '+62 813-4567-8901',
      'tenant_email': 'dewi@email.com',
      'start_date': day(7),
      'end_date': day(97),
      'duration_months': 3,
      'kos_price': 2100000.0,
      'subtotal': 6300000.0,
      'admin_fee': 25000.0,
      'total_amount': 6325000.0,
      'notes': 'Mohon disiapkan kamar di lantai 2.',
      'status': 'approved',
      'rejection_reason': null,
      'created_at': iso(const Duration(days: 2)),
    });
    await db.insert('invoices', {
      'id': 2,
      'invoice_number': 'INV-2026-0002',
      'booking_id': 2,
      'amount': 6300000.0,
      'admin_fee': 25000.0,
      'tax': 0.0,
      'total_amount': 6325000.0,
      'due_date': day(5),
      'paid_at': null,
      'status': 'unpaid',
      'created_at': iso(const Duration(days: 1)),
    });

    // Booking 3: Pending approval for Owner Budi
    await db.insert('bookings', {
      'id': 3,
      'booking_code': 'BOOK-2026-0003',
      'kos_id': 3,
      'room_id': null,
      'customer_id': 3,
      'tenant_name': 'Rafi Pratama',
      'tenant_phone': '+62 815-9988-7766',
      'tenant_email': 'rafi@email.com',
      'start_date': day(10),
      'end_date': day(40),
      'duration_months': 1,
      'kos_price': 2950000.0,
      'subtotal': 2950000.0,
      'admin_fee': 25000.0,
      'total_amount': 2975000.0,
      'notes': 'Check-in pagi sekitar pukul 10.00 WIB.',
      'status': 'pending',
      'rejection_reason': null,
      'created_at': iso(const Duration(hours: 6)),
    });

    // 7. Surveys
    await db.insert('surveys', {
      'id': 1,
      'kos_id': 2,
      'customer_id': 2,
      'survey_date': day(3),
      'survey_time': '14:00',
      'notes': 'Ingin melihat kamar lantai 2 dengan balkon.',
      'status': 'approved',
      'rejection_reason': null,
      'created_at': iso(const Duration(days: 3)),
    });
    await db.insert('surveys', {
      'id': 2,
      'kos_id': 1,
      'customer_id': 3,
      'survey_date': day(4),
      'survey_time': '10:30',
      'notes': 'Sekalian cek area parkir motor.',
      'status': 'pending',
      'rejection_reason': null,
      'created_at': iso(const Duration(hours: 10)),
    });

    // 8. Maintenance Report
    await db.insert('maintenance_reports', {
      'id': 1,
      'booking_id': 1,
      'customer_id': 2,
      'title': 'AC Kamar Kurang Dingin',
      'description':
          'Sejak kemarin sore AC di kamar A-101 hanya mengeluarkan angin biasa, mohon dicek freon atau filternya.',
      'photo_url': 'assets/images/kos/detail_02.jpg',
      'status': 'open',
      'owner_notes': null,
      'created_at': iso(const Duration(days: 1)),
    });

    // 9. Conversations & Messages
    await db.insert('conversations', {
      'id': 1,
      'kos_id': 1,
      'customer_id': 2,
      'owner_id': 1,
      'updated_at': iso(const Duration(hours: 2)),
    });
    await db.insert('messages', {
      'id': 1,
      'conversation_id': 1,
      'sender_id': 2,
      'message': 'Halo Pak Budi, apakah filter AC kamar A-101 bisa dicek besok pagi?',
      'is_read': 1,
      'created_at': iso(const Duration(hours: 3)),
    });
    await db.insert('messages', {
      'id': 2,
      'conversation_id': 1,
      'sender_id': 1,
      'message':
          'Halo Mbak Dewi, teknisi sudah kami jadwalkan besok pukul 09.30 WIB ya.',
      'is_read': 0,
      'created_at': iso(const Duration(hours: 2)),
    });

    await db.insert('conversations', {
      'id': 2,
      'kos_id': 3,
      'customer_id': 3,
      'owner_id': 1,
      'updated_at': iso(const Duration(hours: 5)),
    });
    await db.insert('messages', {
      'id': 3,
      'conversation_id': 2,
      'sender_id': 3,
      'message': 'Selamat siang Pak, saya baru saja mengajukan sewa di Kemang Residence.',
      'is_read': 0,
      'created_at': iso(const Duration(hours: 5)),
    });

    // 10. Notifications
    await db.insert('notifications', {
      'id': 'notif-cust-1',
      'user_id': 2,
      'title': 'Pengajuan Sewa Disetujui',
      'message':
          'Booking BOOK-2026-0002 di Paviliun Dago Asri Residence telah disetujui pemilik. Siap untuk simulasi pembayaran.',
      'category': 'booking',
      'action_type': 'booking',
      'action_id': 'BOOK-2026-0002',
      'action_url': '/bookings/BOOK-2026-0002',
      'read_at': null,
      'created_at': iso(const Duration(hours: 8)),
    });
    await db.insert('notifications', {
      'id': 'notif-cust-2',
      'user_id': 2,
      'title': 'Jadwal Survei Dikonfirmasi',
      'message':
          'Survei lokasi Paviliun Dago Asri Residence pukul 14:00 telah dikonfirmasi pemilik.',
      'category': 'survey',
      'action_type': 'survey',
      'action_id': '1',
      'action_url': '/activity',
      'read_at': iso(const Duration(hours: 4)),
      'created_at': iso(const Duration(days: 1)),
    });
    await db.insert('notifications', {
      'id': 'notif-owner-1',
      'user_id': 1,
      'title': 'Pengajuan Sewa Baru',
      'message':
          'Rafi Pratama mengajukan sewa kamar di Kos Harmoni Kemang Residence (BOOK-2026-0003).',
      'category': 'booking',
      'action_type': 'owner_booking',
      'action_id': 'BOOK-2026-0003',
      'action_url': '/owner/bookings/BOOK-2026-0003',
      'read_at': null,
      'created_at': iso(const Duration(hours: 6)),
    });
    await db.insert('notifications', {
      'id': 'notif-owner-2',
      'user_id': 1,
      'title': 'Laporan Perawatan Baru',
      'message': 'Dewi Lestari melaporkan: AC Kamar Kurang Dingin (Kamar A-101).',
      'category': 'maintenance',
      'action_type': 'owner_maintenance',
      'action_id': '1',
      'action_url': '/owner/maintenance',
      'read_at': null,
      'created_at': iso(const Duration(days: 1)),
    });
  }

  static String _defaultContractTerms(String kosTitle, String roomNumber) {
    return 'PASAL 1 - OBJEK SEWA\n'
        'Pemilik menyewakan kamar $roomNumber pada properti $kosTitle dalam kondisi bersih, layak huni, beserta fasilitas sesuai kesepakatan.\n\n'
        'PASAL 2 - KEWAJIBAN PENYEWA\n'
        '1. Menjaga kebersihan, ketertiban, dan keamanan lingkungan kos.\n'
        '2. Tidak memindahtangankan hak sewa kepada pihak ketiga tanpa persetujuan tertulis pemilik.\n'
        '3. Melaporkan kerusakan fasilitas melalui aplikasi TEMPATIN agar segera ditindaklanjuti.\n\n'
        'PASAL 3 - PENYELESAIAN DIGITAL\n'
        'Dokumen ini disimpan sebagai bukti kesepakatan sewa digital pada aplikasi TEMPATIN.';
  }

  static String bookingStatusLabel(String status) {
    return switch (status) {
      'pending' => 'Menunggu Persetujuan',
      'approved' => 'Disetujui • Siap Bayar',
      'confirmed' => 'Dikonfirmasi (Lunas)',
      'active' => 'Aktif Dihuni',
      'completed' => 'Selesai',
      'rejected' => 'Ditolak',
      'cancelled' => 'Dibatalkan',
      _ => status,
    };
  }

  static String invoiceStatusLabel(String status) {
    return switch (status) {
      'paid' => 'Lunas',
      'unpaid' => 'Belum Dibayar',
      'expired' => 'Kedaluwarsa',
      'cancelled' => 'Dibatalkan',
      _ => status,
    };
  }

  static String surveyStatusLabel(String status) {
    return switch (status) {
      'pending' => 'Menunggu Konfirmasi',
      'approved' => 'Disetujui',
      'completed' => 'Selesai',
      'rejected' => 'Ditolak',
      'cancelled' => 'Dibatalkan',
      _ => status,
    };
  }

  static String maintenanceStatusLabel(String status) {
    return switch (status) {
      'open' => 'Menunggu Penanganan',
      'in_progress' => 'Sedang Diproses',
      'resolved' => 'Selesai Diperbaiki',
      'rejected' => 'Ditolak',
      _ => status,
    };
  }

  // ---- Query & JSON Hydration Helpers ----

  Future<Map<String, dynamic>?> findUserByToken(String? bearerToken) async {
    if (bearerToken == null || bearerToken.isEmpty) return null;
    final db = await database;
    final rows = await db.rawQuery(
      '''
      SELECT u.* FROM users u
      INNER JOIN sessions s ON s.user_id = u.id
      WHERE s.token = ?
      LIMIT 1
      ''',
      [bearerToken],
    );
    if (rows.isEmpty) return null;
    return _userMap(rows.first);
  }

  Map<String, dynamic> _userMap(Map<String, Object?> row) => {
    'id': row['id'],
    'name': row['name'],
    'email': row['email'],
    'role': row['role'],
    'phone': row['phone'],
    'avatar_url': row['avatar_url'],
  };

  Future<List<Map<String, dynamic>>> fetchFacilitiesList() async {
    final db = await database;
    final rows = await db.query('facilities', orderBy: 'id ASC');
    return rows
        .map((r) => {'id': r['id'], 'name': r['name'], 'slug': r['slug']})
        .toList();
  }

  Future<Map<String, dynamic>> buildKosSummaryJson(
    DatabaseExecutor db,
    Map<String, Object?> row, {
    int? currentUserId,
  }) async {
    final kosId = row['id'] as int;

    final facRows = await db.rawQuery(
      '''
      SELECT f.id, f.name, f.slug FROM facilities f
      INNER JOIN kos_facilities kf ON kf.facility_id = f.id
      WHERE kf.kos_id = ?
      ORDER BY f.id ASC
      ''',
      [kosId],
    );
    final facilities = facRows
        .map((f) => {'id': f['id'], 'name': f['name'], 'slug': f['slug']})
        .toList();

    final ratingRow = (await db.rawQuery(
      'SELECT COALESCE(AVG(rating), 0) AS avg_rating, COUNT(*) AS cnt FROM reviews WHERE kos_id = ?',
      [kosId],
    )).first;
    final avgRating = ((ratingRow['avg_rating'] as num?)?.toDouble() ?? 0.0);
    final reviewCount = (ratingRow['cnt'] as num?)?.toInt() ?? 0;

    final roomRow = (await db.rawQuery(
      "SELECT COUNT(*) AS cnt FROM rooms WHERE kos_id = ? AND status = 'available'",
      [kosId],
    )).first;
    final availableCount = (roomRow['cnt'] as num?)?.toInt() ?? 0;

    var isFavorited = false;
    if (currentUserId != null) {
      final fav = await db.query(
        'favorites',
        where: 'user_id = ? AND kos_id = ?',
        whereArgs: [currentUserId, kosId],
        limit: 1,
      );
      isFavorited = fav.isNotEmpty;
    }

    return {
      'id': kosId,
      'title': row['title'],
      'slug': row['slug'],
      'price': (row['price'] as num).toDouble(),
      'type': row['type'],
      'city': row['city'],
      'address': row['address'],
      'thumbnail_url': row['thumbnail_url'],
      'status': row['status'],
      'rating': double.parse(avgRating.toStringAsFixed(1)),
      'review_count': reviewCount,
      'is_favorited': isFavorited,
      'available_rooms_count': availableCount,
      'facilities': facilities,
    };
  }

  Future<Map<String, dynamic>?> buildKosDetailJson(
    String slug, {
    int? currentUserId,
  }) async {
    final db = await database;
    final rows = await db.query(
      'kos',
      where: 'slug = ?',
      whereArgs: [slug],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final row = rows.first;
    final kosId = row['id'] as int;
    final summary = await buildKosSummaryJson(
      db,
      row,
      currentUserId: currentUserId,
    );

    final ownerRows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [row['owner_id']],
      limit: 1,
    );
    final owner = ownerRows.isNotEmpty
        ? {
            'id': ownerRows.first['id'],
            'name': ownerRows.first['name'],
            'phone': ownerRows.first['phone'],
            'avatar_url': ownerRows.first['avatar_url'],
          }
        : null;

    final photoRows = await db.query(
      'kos_photos',
      where: 'kos_id = ?',
      whereArgs: [kosId],
      orderBy: 'sort_order ASC, id ASC',
    );
    final photos = photoRows
        .map(
          (pRow) => {
            'id': pRow['id'],
            'photo_url': pRow['photo_url'],
            'sort_order': pRow['sort_order'],
          },
        )
        .toList();

    final roomRows = await db.query(
      'rooms',
      where: "kos_id = ? AND status = 'available'",
      whereArgs: [kosId],
      orderBy: 'id ASC',
    );
    final basePrice = (row['price'] as num).toDouble();
    final availableRooms = roomRows
        .map((r) => buildRoomJson(r, basePrice))
        .toList();

    final reviewRows = await db.query(
      'reviews',
      where: 'kos_id = ?',
      whereArgs: [kosId],
      orderBy: 'id DESC',
    );
    final reviews = reviewRows.map(buildReviewJson).toList();

    var canReview = false;
    if (currentUserId != null) {
      final eligible = await db.rawQuery(
        '''
        SELECT id FROM bookings
        WHERE kos_id = ? AND customer_id = ?
          AND status IN ('confirmed', 'active', 'completed')
        LIMIT 1
        ''',
        [kosId, currentUserId],
      );
      canReview = eligible.isNotEmpty;
    }

    final similarRows = await db.query(
      'kos',
      where: "id != ? AND status = 'active'",
      whereArgs: [kosId],
      orderBy: 'id ASC',
      limit: 3,
    );
    final similarKos = <Map<String, dynamic>>[];
    for (final sRow in similarRows) {
      similarKos.add(
        await buildKosSummaryJson(db, sRow, currentUserId: currentUserId),
      );
    }

    return {
      ...summary,
      'description': row['description'],
      'area': row['area'],
      'rooms_summary': row['rooms_summary'],
      'bathrooms': row['bathrooms'],
      'bedrooms': row['bedrooms'],
      'garages': row['garages'],
      'latitude': row['latitude'],
      'longitude': row['longitude'],
      'can_review': canReview,
      'owner': owner,
      'photos': photos,
      'available_rooms': availableRooms,
      'reviews': reviews,
      'similar_kos': similarKos,
    };
  }

  Map<String, dynamic> buildRoomJson(
    Map<String, Object?> r,
    double basePrice,
  ) {
    final override = (r['price_override'] as num?)?.toDouble();
    return {
      'id': r['id'],
      'room_number': r['room_number'],
      'floor': r['floor'],
      'room_type': r['room_type'],
      'price_override': override,
      'effective_price': override ?? basePrice,
      'status': r['status'],
      'notes': r['notes'],
    };
  }

  Map<String, dynamic> buildReviewJson(Map<String, Object?> r) => {
    'id': r['id'],
    'reviewer_name': r['reviewer_name'],
    'is_verified_tenant': (r['is_verified_tenant'] as num? ?? 0) == 1,
    'rating': r['rating'],
    'comment': r['comment'],
    'reply': r['reply'],
    'user_avatar_url': r['user_avatar_url'],
    'created_at': r['created_at'],
  };

  Future<Map<String, dynamic>?> buildBookingJson(
    DatabaseExecutor db,
    Map<String, Object?> bRow,
  ) async {
    final bookingId = bRow['id'] as int;
    final kosId = bRow['kos_id'] as int;
    final kosRows = await db.query(
      'kos',
      where: 'id = ?',
      whereArgs: [kosId],
      limit: 1,
    );
    final kosJson = kosRows.isNotEmpty
        ? await buildKosSummaryJson(db, kosRows.first)
        : null;
    final basePrice = kosRows.isNotEmpty
        ? (kosRows.first['price'] as num).toDouble()
        : (bRow['kos_price'] as num).toDouble();

    Map<String, dynamic>? roomJson;
    final roomId = bRow['room_id'] as int?;
    if (roomId != null) {
      final roomRows = await db.query(
        'rooms',
        where: 'id = ?',
        whereArgs: [roomId],
        limit: 1,
      );
      if (roomRows.isNotEmpty) {
        roomJson = buildRoomJson(roomRows.first, basePrice);
      }
    }

    final custRows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [bRow['customer_id']],
      limit: 1,
    );
    final customerJson = custRows.isNotEmpty ? _userMap(custRows.first) : null;

    final invRows = await db.query(
      'invoices',
      where: 'booking_id = ?',
      whereArgs: [bookingId],
      limit: 1,
    );
    Map<String, dynamic>? invoiceJson;
    if (invRows.isNotEmpty) {
      invoiceJson = await buildInvoiceJson(
        db,
        invRows.first,
        bookingCode: bRow['booking_code'] as String?,
        kosTitle: kosRows.isNotEmpty ? kosRows.first['title'] as String? : null,
        kosSlug: kosRows.isNotEmpty ? kosRows.first['slug'] as String? : null,
      );
    }

    final ctrRows = await db.query(
      'rental_contracts',
      where: 'booking_id = ?',
      whereArgs: [bookingId],
      limit: 1,
    );
    final contractJson = ctrRows.isNotEmpty
        ? buildContractJson(ctrRows.first, bRow['booking_code'] as String?)
        : null;

    final status = bRow['status'] as String;
    return {
      'id': bookingId,
      'booking_code': bRow['booking_code'],
      'tenant_name': bRow['tenant_name'],
      'tenant_phone': bRow['tenant_phone'],
      'tenant_email': bRow['tenant_email'],
      'start_date': bRow['start_date'],
      'end_date': bRow['end_date'],
      'duration_months': bRow['duration_months'],
      'kos_price': bRow['kos_price'],
      'subtotal': bRow['subtotal'],
      'admin_fee': bRow['admin_fee'],
      'total_amount': bRow['total_amount'],
      'notes': bRow['notes'],
      'status': status,
      'status_label': bookingStatusLabel(status),
      'rejection_reason': bRow['rejection_reason'],
      'kos': kosJson,
      'room': roomJson,
      'customer': customerJson,
      'invoice': invoiceJson,
      'contract': contractJson,
      'created_at': bRow['created_at'],
    };
  }

  Future<Map<String, dynamic>> buildInvoiceJson(
    DatabaseExecutor db,
    Map<String, Object?> invRow, {
    String? bookingCode,
    String? kosTitle,
    String? kosSlug,
  }) async {
    final invId = invRow['id'] as int;
    String? resolvedBookingCode = bookingCode;
    String? resolvedKosTitle = kosTitle;
    String? resolvedKosSlug = kosSlug;

    if (resolvedBookingCode == null || resolvedKosTitle == null) {
      final joined = await db.rawQuery(
        '''
        SELECT b.booking_code, k.title, k.slug
        FROM bookings b
        INNER JOIN kos k ON k.id = b.kos_id
        WHERE b.id = ?
        LIMIT 1
        ''',
        [invRow['booking_id']],
      );
      if (joined.isNotEmpty) {
        resolvedBookingCode ??= joined.first['booking_code'] as String?;
        resolvedKosTitle ??= joined.first['title'] as String?;
        resolvedKosSlug ??= joined.first['slug'] as String?;
      }
    }

    final payRows = await db.query(
      'payments',
      where: 'invoice_id = ?',
      whereArgs: [invId],
      orderBy: 'id DESC',
    );

    final status = invRow['status'] as String;
    return {
      'id': invId,
      'invoice_number': invRow['invoice_number'],
      'booking_code': resolvedBookingCode,
      'kos_title': resolvedKosTitle,
      'kos_slug': resolvedKosSlug,
      'amount': invRow['amount'],
      'admin_fee': invRow['admin_fee'],
      'tax': invRow['tax'],
      'total_amount': invRow['total_amount'],
      'due_date': invRow['due_date'],
      'paid_at': invRow['paid_at'],
      'status': status,
      'status_label': invoiceStatusLabel(status),
      'payments': payRows
          .map(
            (pRow) => {
              'id': pRow['id'],
              'payment_code': pRow['payment_code'],
              'order_id': pRow['order_id'],
              'payment_method': pRow['payment_method'],
              'payment_channel': pRow['payment_channel'],
              'transaction_id': pRow['transaction_id'],
              'amount': pRow['amount'],
              'snap_token': null,
              'snap_redirect_url': null,
              'status': pRow['status'],
              'paid_at': pRow['paid_at'],
              'created_at': pRow['created_at'],
            },
          )
          .toList(),
      'created_at': invRow['created_at'],
    };
  }

  Map<String, dynamic> buildContractJson(
    Map<String, Object?> row,
    String? bookingCode,
  ) {
    return {
      'id': row['id'],
      'contract_number': row['contract_number'],
      'booking_code': bookingCode,
      'terms': row['terms'],
      'status': row['status'],
      'is_signed': (row['is_signed'] as num? ?? 0) == 1,
      'signed_at': row['signed_at'],
      'signer_ip': row['signer_ip'],
      'created_at': row['created_at'],
    };
  }

  Future<Map<String, dynamic>> buildSurveyJson(
    DatabaseExecutor db,
    Map<String, Object?> sRow,
  ) async {
    final kosRows = await db.query(
      'kos',
      where: 'id = ?',
      whereArgs: [sRow['kos_id']],
      limit: 1,
    );
    final custRows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [sRow['customer_id']],
      limit: 1,
    );
    final status = sRow['status'] as String;
    return {
      'id': sRow['id'],
      'survey_date': sRow['survey_date'],
      'survey_time': sRow['survey_time'],
      'notes': sRow['notes'],
      'status': status,
      'status_label': surveyStatusLabel(status),
      'rejection_reason': sRow['rejection_reason'],
      'kos': kosRows.isNotEmpty
          ? await buildKosSummaryJson(db, kosRows.first)
          : null,
      'customer': custRows.isNotEmpty ? _userMap(custRows.first) : null,
      'created_at': sRow['created_at'],
    };
  }

  Future<Map<String, dynamic>> buildMaintenanceJson(
    DatabaseExecutor db,
    Map<String, Object?> mRow,
  ) async {
    final bRows = await db.query(
      'bookings',
      where: 'id = ?',
      whereArgs: [mRow['booking_id']],
      limit: 1,
    );
    Map<String, dynamic>? kosJson;
    Map<String, dynamic>? roomJson;
    String? bookingCode;

    if (bRows.isNotEmpty) {
      final b = bRows.first;
      bookingCode = b['booking_code'] as String?;
      final kRows = await db.query(
        'kos',
        where: 'id = ?',
        whereArgs: [b['kos_id']],
        limit: 1,
      );
      if (kRows.isNotEmpty) {
        kosJson = await buildKosSummaryJson(db, kRows.first);
        final roomId = b['room_id'] as int?;
        if (roomId != null) {
          final rRows = await db.query(
            'rooms',
            where: 'id = ?',
            whereArgs: [roomId],
            limit: 1,
          );
          if (rRows.isNotEmpty) {
            roomJson = buildRoomJson(
              rRows.first,
              (kRows.first['price'] as num).toDouble(),
            );
          }
        }
      }
    }

    final custRows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [mRow['customer_id']],
      limit: 1,
    );
    final status = mRow['status'] as String;
    return {
      'id': mRow['id'],
      'booking_id': mRow['booking_id'],
      'booking_code': bookingCode,
      'title': mRow['title'],
      'description': mRow['description'],
      'photo_url': mRow['photo_url'],
      'status': status,
      'status_label': maintenanceStatusLabel(status),
      'owner_notes': mRow['owner_notes'],
      'kos': kosJson,
      'room': roomJson,
      'customer': custRows.isNotEmpty ? _userMap(custRows.first) : null,
      'created_at': mRow['created_at'],
    };
  }

  Future<Map<String, dynamic>> buildConversationJson(
    DatabaseExecutor db,
    Map<String, Object?> cRow, {
    required int viewerUserId,
  }) async {
    final convId = cRow['id'] as int;
    final kRows = await db.query(
      'kos',
      where: 'id = ?',
      whereArgs: [cRow['kos_id']],
      limit: 1,
    );
    final kosJson = kRows.isNotEmpty
        ? await buildKosSummaryJson(db, kRows.first)
        : null;

    final counterpartId = viewerUserId == (cRow['customer_id'] as int)
        ? (cRow['owner_id'] as int)
        : (cRow['customer_id'] as int);
    final uRows = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [counterpartId],
      limit: 1,
    );
    final counterpart = uRows.isNotEmpty ? _userMap(uRows.first) : null;

    final lastMsgRows = await db.query(
      'messages',
      where: 'conversation_id = ?',
      whereArgs: [convId],
      orderBy: 'id DESC',
      limit: 1,
    );
    final lastMessage = lastMsgRows.isNotEmpty
        ? buildMessageJson(lastMsgRows.first)
        : null;

    final unreadRow = (await db.rawQuery(
      '''
      SELECT COUNT(*) AS cnt FROM messages
      WHERE conversation_id = ? AND sender_id != ? AND is_read = 0
      ''',
      [convId, viewerUserId],
    )).first;

    return {
      'id': convId,
      'kos': kosJson,
      'counterpart': counterpart,
      'last_message': lastMessage,
      'unread_count': (unreadRow['cnt'] as num?)?.toInt() ?? 0,
      'updated_at': cRow['updated_at'],
    };
  }

  Map<String, dynamic> buildMessageJson(Map<String, Object?> row) => {
    'id': row['id'],
    'conversation_id': row['conversation_id'],
    'sender_id': row['sender_id'],
    'message': row['message'],
    'is_read': (row['is_read'] as num? ?? 0) == 1,
    'created_at': row['created_at'],
  };

  Map<String, dynamic> buildNotificationJson(Map<String, Object?> row) => {
    'id': row['id'],
    'title': row['title'],
    'message': row['message'],
    'category': row['category'],
    'action_type': row['action_type'],
    'action_id': row['action_id'],
    'action_url': row['action_url'],
    'read_at': row['read_at'],
    'created_at': row['created_at'],
  };

  Future<Map<String, dynamic>> buildPaginationMeta({
    required int page,
    required int perPage,
    required int total,
  }) async {
    final lastPage = math.max(1, (total / perPage).ceil());
    return {
      'current_page': page,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total,
    };
  }
}

final offlineDemoDatabaseProvider = Provider<OfflineDemoDatabase>((ref) {
  final db = OfflineDemoDatabase();
  ref.onDispose(db.close);
  return db;
});
