import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../database/app_database.dart';
import 'models.dart';

/// Repository for searching, filtering, viewing, and managing kos properties locally in SQLite.
class KosRepository {
  const KosRepository(this.db);

  final AppDatabase db;

  Future<List<Facility>> getAllFacilities() {
    return (db.select(
      db.facilities,
    )..orderBy([(f) => OrderingTerm.asc(f.name)])).get();
  }

  Future<List<KosCardData>> getFeatured({int? memberId}) async {
    final rows =
        await (db.select(db.kosProperties)
              ..where(
                (k) => k.status.equals('active') & k.isFeatured.equals(true),
              )
              ..orderBy([(k) => OrderingTerm.desc(k.id)]))
            .get();
    return _hydrateCards(rows, memberId: memberId);
  }

  Future<List<KosCardData>> searchKos(
    KosFilterParams filter, {
    int? memberId,
    bool includeInactive = false,
    int? ownerId,
  }) async {
    final query = db.select(db.kosProperties);

    query.where((k) {
      Expression<bool> expr = const Constant(true);
      if (!includeInactive) {
        expr = expr & k.status.equals('active');
      }
      if (ownerId != null) {
        expr = expr & k.ownerId.equals(ownerId);
      }
      if (filter.type != null &&
          filter.type!.isNotEmpty &&
          filter.type != 'Semua') {
        expr = expr & k.type.equals(filter.type!);
      }
      if (filter.minPrice != null) {
        expr = expr & k.price.isBiggerOrEqualValue(filter.minPrice!);
      }
      if (filter.maxPrice != null) {
        expr = expr & k.price.isSmallerOrEqualValue(filter.maxPrice!);
      }
      final q = filter.query.trim().toLowerCase();
      if (q.isNotEmpty) {
        expr =
            expr &
            (k.title.lower().like('%$q%') |
                k.city.lower().like('%$q%') |
                k.address.lower().like('%$q%'));
      }
      return expr;
    });

    final rows = await query.get();
    var cards = await _hydrateCards(rows, memberId: memberId);

    // Multi-facility filter
    if (filter.facilityIds.isNotEmpty) {
      final allFacilityRows = await db.select(db.kosFacilities).get();
      final facilitiesByKos = <int, Set<int>>{};
      for (final row in allFacilityRows) {
        facilitiesByKos.putIfAbsent(row.kosId, () => {}).add(row.facilityId);
      }
      cards = cards.where((c) {
        final owned = facilitiesByKos[c.kos.id] ?? const {};
        return filter.facilityIds.every(owned.contains);
      }).toList();
    }

    switch (filter.sortBy) {
      case 'price_asc':
        cards.sort((a, b) => a.kos.price.compareTo(b.kos.price));
      case 'price_desc':
        cards.sort((a, b) => b.kos.price.compareTo(a.kos.price));
      case 'rating_desc':
        cards.sort((a, b) => b.averageRating.compareTo(a.averageRating));
      default:
        cards.sort((a, b) => b.kos.id.compareTo(a.kos.id));
    }

    return cards;
  }

  Future<KosDetailData?> getKosDetail(int kosId, {int? memberId}) async {
    final kos = await (db.select(
      db.kosProperties,
    )..where((k) => k.id.equals(kosId))).getSingleOrNull();
    if (kos == null) return null;

    final images =
        await (db.select(db.kosImages)
              ..where((img) => img.kosId.equals(kosId))
              ..orderBy([(img) => OrderingTerm.asc(img.sortOrder)]))
            .get();

    final joinFacilities =
        await (db.select(db.kosFacilities).join([
                innerJoin(
                  db.facilities,
                  db.facilities.id.equalsExp(db.kosFacilities.facilityId),
                ),
              ])
              ..where(db.kosFacilities.kosId.equals(kosId))
              ..orderBy([OrderingTerm.asc(db.facilities.name)]))
            .get();
    final facilities = joinFacilities
        .map((row) => row.readTable(db.facilities))
        .toList();

    final reviews =
        await (db.select(db.reviews)
              ..where((r) => r.kosId.equals(kosId))
              ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
            .get();

    final avg = reviews.isEmpty
        ? 0.0
        : reviews.map((r) => r.rating).reduce((a, b) => a + b) / reviews.length;

    final owner = await (db.select(
      db.users,
    )..where((u) => u.id.equals(kos.ownerId))).getSingleOrNull();
    final ownerProfile = await (db.select(
      db.userProfiles,
    )..where((p) => p.userId.equals(kos.ownerId))).getSingleOrNull();

    var isFav = false;
    if (memberId != null) {
      final fav =
          await (db.select(db.favorites)..where(
                (f) => f.memberId.equals(memberId) & f.kosId.equals(kosId),
              ))
              .getSingleOrNull();
      isFav = fav != null;
    }

    return KosDetailData(
      kos: kos,
      images: images,
      facilities: facilities,
      reviews: reviews,
      ownerName: owner?.name ?? 'Pemilik TEMPATIN',
      ownerPhone: ownerProfile?.phone ?? '-',
      averageRating: avg,
      isFavorited: isFav,
    );
  }

  /// Persists a user-picked image into the permanent app documents folder so
  /// it survives cache cleanups and app restarts offline.
  Future<String> persistLocalImage(String sourcePath) async {
    if (sourcePath.startsWith('assets/')) return sourcePath;
    final dir = await getApplicationDocumentsDirectory();
    final photoDir = Directory(p.join(dir.path, 'kos_photos'));
    if (!photoDir.existsSync()) {
      photoDir.createSync(recursive: true);
    }
    final ext = p.extension(sourcePath).isEmpty
        ? '.jpg'
        : p.extension(sourcePath);
    final fileName = 'kos_${DateTime.now().microsecondsSinceEpoch}$ext';
    final dest = File(p.join(photoDir.path, fileName));
    await File(sourcePath).copy(dest.path);
    return dest.path;
  }

  Future<int> saveKos({
    int? existingId,
    required int ownerId,
    required String title,
    required String description,
    required double price,
    required String type,
    required String city,
    required String address,
    required List<String> imagePaths,
    required Set<int> facilityIds,
    String status = 'active',
    String? area,
    String? roomsCount,
    String? bathrooms,
    String? garages,
    bool isFeatured = false,
  }) async {
    final images = imagePaths.isEmpty
        ? ['assets/images/kos/kos_001.png']
        : imagePaths;
    final thumbnail = images.first;

    return db.transaction(() async {
      late final int kosId;
      if (existingId == null) {
        final baseSlug = title
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
            .replaceAll(RegExp(r'^-|-$'), '');
        final slug =
            '${baseSlug.isEmpty ? 'kos' : baseSlug}-${DateTime.now().millisecondsSinceEpoch}';
        kosId = await db
            .into(db.kosProperties)
            .insert(
              KosPropertiesCompanion.insert(
                ownerId: ownerId,
                slug: slug,
                title: title.trim(),
                description: description.trim(),
                price: price,
                type: type,
                city: city.trim(),
                address: address.trim(),
                thumbnailAsset: thumbnail,
                status: Value(status),
                area: Value(area?.trim()),
                roomsCount: Value(roomsCount?.trim()),
                bathrooms: Value(bathrooms?.trim()),
                garages: Value(garages?.trim()),
                isFeatured: Value(isFeatured),
              ),
            );
      } else {
        kosId = existingId;
        await (db.update(
          db.kosProperties,
        )..where((k) => k.id.equals(kosId) & k.ownerId.equals(ownerId))).write(
          KosPropertiesCompanion(
            title: Value(title.trim()),
            description: Value(description.trim()),
            price: Value(price),
            type: Value(type),
            city: Value(city.trim()),
            address: Value(address.trim()),
            thumbnailAsset: Value(thumbnail),
            status: Value(status),
            area: Value(area?.trim()),
            roomsCount: Value(roomsCount?.trim()),
            bathrooms: Value(bathrooms?.trim()),
            garages: Value(garages?.trim()),
            isFeatured: Value(isFeatured),
            updatedAt: Value(DateTime.now()),
          ),
        );

        await (db.delete(
          db.kosImages,
        )..where((i) => i.kosId.equals(kosId))).go();
        await (db.delete(
          db.kosFacilities,
        )..where((f) => f.kosId.equals(kosId))).go();
      }

      for (var i = 0; i < images.length; i++) {
        await db
            .into(db.kosImages)
            .insert(
              KosImagesCompanion.insert(
                kosId: kosId,
                imagePath: images[i],
                sortOrder: Value(i),
              ),
            );
      }

      for (final fid in facilityIds) {
        await db
            .into(db.kosFacilities)
            .insert(
              KosFacilitiesCompanion.insert(kosId: kosId, facilityId: fid),
            );
      }
      return kosId;
    });
  }

  Future<void> deleteKos(int kosId, int ownerId) async {
    await (db.delete(
      db.kosProperties,
    )..where((k) => k.id.equals(kosId) & k.ownerId.equals(ownerId))).go();
  }

  Future<List<KosCardData>> _hydrateCards(
    List<KosProperty> rows, {
    int? memberId,
  }) async {
    if (rows.isEmpty) return const [];

    final kosIds = rows.map((r) => r.id).toList();
    final allReviews = await (db.select(
      db.reviews,
    )..where((r) => r.kosId.isIn(kosIds))).get();
    final facJoin = await (db.select(db.kosFacilities).join([
      innerJoin(
        db.facilities,
        db.facilities.id.equalsExp(db.kosFacilities.facilityId),
      ),
    ])..where(db.kosFacilities.kosId.isIn(kosIds))).get();

    final favIds = <int>{};
    if (memberId != null) {
      final favs = await (db.select(
        db.favorites,
      )..where((f) => f.memberId.equals(memberId))).get();
      favIds.addAll(favs.map((f) => f.kosId));
    }

    final reviewsByKos = <int, List<Review>>{};
    for (final rev in allReviews) {
      reviewsByKos.putIfAbsent(rev.kosId, () => []).add(rev);
    }

    final facNamesByKos = <int, List<String>>{};
    for (final row in facJoin) {
      final kf = row.readTable(db.kosFacilities);
      final fac = row.readTable(db.facilities);
      facNamesByKos.putIfAbsent(kf.kosId, () => []).add(fac.name);
    }

    return rows.map((kos) {
      final revs = reviewsByKos[kos.id] ?? const [];
      final avg = revs.isEmpty
          ? 0.0
          : revs.map((r) => r.rating).reduce((a, b) => a + b) / revs.length;
      return KosCardData(
        kos: kos,
        averageRating: avg,
        reviewCount: revs.length,
        facilityNames: facNamesByKos[kos.id] ?? const [],
        isFavorited: favIds.contains(kos.id),
      );
    }).toList();
  }
}
