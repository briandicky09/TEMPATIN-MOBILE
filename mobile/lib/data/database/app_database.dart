import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 120)();
  TextColumn get email => text().unique()();
  TextColumn get passwordHash => text()();
  TextColumn get passwordSalt => text()();
  TextColumn get role => text().withDefault(const Constant('member'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().unique().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get bio => text().nullable()();
  TextColumn get avatarAsset => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class KosProperties extends Table {
  @override
  String get tableName => 'kos';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get slug => text().unique()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  RealColumn get price => real()();
  TextColumn get type => text()(); // Putri, Putra, Campur, Eksklusif
  TextColumn get city => text()();
  TextColumn get address => text()();
  TextColumn get thumbnailAsset => text()();
  TextColumn get status => text().withDefault(const Constant('active'))();
  TextColumn get area => text().nullable()();
  TextColumn get roomsCount => text().nullable()();
  TextColumn get bathrooms => text().nullable()();
  TextColumn get garages => text().nullable()();
  BoolColumn get isFeatured => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class KosImages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get kosId =>
      integer().references(KosProperties, #id, onDelete: KeyAction.cascade)();
  TextColumn get imagePath => text()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
}

class Facilities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get slug => text().unique()();
  TextColumn get iconKey => text().withDefault(const Constant('check'))();
}

class KosFacilities extends Table {
  IntColumn get kosId =>
      integer().references(KosProperties, #id, onDelete: KeyAction.cascade)();
  IntColumn get facilityId =>
      integer().references(Facilities, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {kosId, facilityId};
}

class Bookings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get bookingCode => text().unique()();
  IntColumn get kosId =>
      integer().references(KosProperties, #id, onDelete: KeyAction.cascade)();
  IntColumn get memberId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get tenantName => text()();
  TextColumn get tenantPhone => text()();
  TextColumn get tenantEmail => text()();
  TextColumn get startDate => text()();
  TextColumn get endDate => text()();
  IntColumn get durationMonths => integer()();
  RealColumn get kosPrice => real()();
  RealColumn get subtotal => real()();
  RealColumn get adminFee => real().withDefault(const Constant(25000.0))();
  RealColumn get totalAmount => real()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  TextColumn get rejectionReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Invoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get invoiceNumber => text().unique()();
  IntColumn get bookingId => integer().unique().references(
    Bookings,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get memberId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get kosId =>
      integer().references(KosProperties, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real()();
  RealColumn get adminFee => real().withDefault(const Constant(25000.0))();
  RealColumn get totalAmount => real()();
  TextColumn get dueDate => text()();
  DateTimeColumn get paidAt => dateTime().nullable()();
  TextColumn get paymentMethod => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('unpaid'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Reviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get kosId =>
      integer().references(KosProperties, #id, onDelete: KeyAction.cascade)();
  IntColumn get memberId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get reviewerName => text()();
  IntColumn get rating => integer()();
  TextColumn get comment => text()();
  TextColumn get ownerReply => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {kosId, memberId},
  ];
}

class AppNotifications extends Table {
  @override
  String get tableName => 'notifications';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get message => text()();
  TextColumn get category => text().withDefault(const Constant('system'))();
  BoolColumn get isRead => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Favorites extends Table {
  IntColumn get memberId =>
      integer().references(Users, #id, onDelete: KeyAction.cascade)();
  IntColumn get kosId =>
      integer().references(KosProperties, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {memberId, kosId};
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tempatin_offline.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(
  tables: [
    Users,
    UserProfiles,
    KosProperties,
    KosImages,
    Facilities,
    KosFacilities,
    Bookings,
    Invoices,
    Reviews,
    AppNotifications,
    Favorites,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_kos_search ON kos(status, type, city, price)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_bookings_member ON bookings(member_id, status)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_invoices_member ON invoices(member_id, status)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_notifications_user ON notifications(user_id, is_read)',
      );
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Schema v1 baseline; future schema changes migrate incrementally here.
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
