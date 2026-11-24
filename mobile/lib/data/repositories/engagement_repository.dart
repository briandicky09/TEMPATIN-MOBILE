import 'package:drift/drift.dart';

import '../database/app_database.dart';
import 'kos_repository.dart';
import 'models.dart';

/// Repository handling Favorites, Reviews, and Local Notifications in SQLite.
class EngagementRepository {
  const EngagementRepository(this.db);

  final AppDatabase db;

  Future<bool> toggleFavorite(int memberId, int kosId) async {
    final existing =
        await (db.select(db.favorites)..where(
              (f) => f.memberId.equals(memberId) & f.kosId.equals(kosId),
            ))
            .getSingleOrNull();

    if (existing != null) {
      await (db.delete(db.favorites)
            ..where((f) => f.memberId.equals(memberId) & f.kosId.equals(kosId)))
          .go();
      return false;
    }

    await db
        .into(db.favorites)
        .insert(FavoritesCompanion.insert(memberId: memberId, kosId: kosId));
    return true;
  }

  Future<List<KosCardData>> getFavoriteKos(int memberId) async {
    final favs = await (db.select(
      db.favorites,
    )..where((f) => f.memberId.equals(memberId))).get();
    if (favs.isEmpty) return const [];
    final favIds = favs.map((f) => f.kosId).toSet();

    final all = await KosRepository(db)
        .searchKos(const KosFilterParams(), memberId: memberId);
    return all.where((item) => favIds.contains(item.kos.id)).toList();
  }

  Future<void> submitReview({
    required int kosId,
    required int memberId,
    required String reviewerName,
    required int rating,
    required String comment,
  }) async {
    final existing =
        await (db.select(db.reviews)..where(
              (r) => r.kosId.equals(kosId) & r.memberId.equals(memberId),
            ))
            .getSingleOrNull();

    if (existing == null) {
      await db
          .into(db.reviews)
          .insert(
            ReviewsCompanion.insert(
              kosId: kosId,
              memberId: memberId,
              reviewerName: reviewerName.trim(),
              rating: rating.clamp(1, 5),
              comment: comment.trim(),
            ),
          );
    } else {
      await (db.update(
        db.reviews,
      )..where((r) => r.id.equals(existing.id))).write(
        ReviewsCompanion(
          rating: Value(rating.clamp(1, 5)),
          comment: Value(comment.trim()),
        ),
      );
    }
  }

  Future<void> replyToReview(int reviewId, String reply) async {
    await (db.update(db.reviews)..where((r) => r.id.equals(reviewId))).write(
      ReviewsCompanion(ownerReply: Value(reply.trim())),
    );
  }

  Future<List<AppNotification>> getNotifications(int userId) {
    return (db.select(db.appNotifications)
          ..where((n) => n.userId.equals(userId))
          ..orderBy([(n) => OrderingTerm.desc(n.id)]))
        .get();
  }

  Future<int> getUnreadCount(int userId) async {
    final rows = await (db.select(
      db.appNotifications,
    )..where((n) => n.userId.equals(userId) & n.isRead.equals(false))).get();
    return rows.length;
  }

  Future<void> markAsRead(int notificationId) async {
    await (db.update(db.appNotifications)
          ..where((n) => n.id.equals(notificationId)))
        .write(const AppNotificationsCompanion(isRead: Value(true)));
  }

  Future<void> markAllAsRead(int userId) async {
    await (db.update(db.appNotifications)
          ..where((n) => n.userId.equals(userId)))
        .write(const AppNotificationsCompanion(isRead: Value(true)));
  }
}
