import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/api_response.dart';
import '../../../../shared/models/notification_model.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../data/notifications_repository.dart';

class NotificationsState {
  const NotificationsState({
    required this.items,
    required this.unreadCount,
    required this.meta,
    this.isLoadingMore = false,
  });

  final List<AppNotificationModel> items;
  final int unreadCount;
  final PaginationMeta meta;
  final bool isLoadingMore;

  bool get hasMore => meta.hasMore;

  NotificationsState copyWith({
    List<AppNotificationModel>? items,
    int? unreadCount,
    PaginationMeta? meta,
    bool? isLoadingMore,
  }) {
    return NotificationsState(
      items: items ?? this.items,
      unreadCount: unreadCount ?? this.unreadCount,
      meta: meta ?? this.meta,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class NotificationsNotifier extends AsyncNotifier<NotificationsState> {
  @override
  Future<NotificationsState> build() async {
    final auth = ref.watch(authSessionProvider);
    if (!auth.isAuthenticated) {
      return const NotificationsState(
        items: [],
        unreadCount: 0,
        meta: PaginationMeta(
          currentPage: 1,
          lastPage: 1,
          perPage: 20,
          total: 0,
        ),
      );
    }
    final res = await ref
        .read(notificationsRepositoryProvider)
        .fetchNotifications();
    return NotificationsState(
      items: res.items,
      unreadCount: res.unreadCount,
      meta: res.meta,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final res = await ref
          .read(notificationsRepositoryProvider)
          .fetchNotifications();
      return NotificationsState(
        items: res.items,
        unreadCount: res.unreadCount,
        meta: res.meta,
      );
    });
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;

    state = AsyncData(current.copyWith(isLoadingMore: true));
    try {
      final next = await ref
          .read(notificationsRepositoryProvider)
          .fetchNotifications(
            page: current.meta.currentPage + 1,
            perPage: current.meta.perPage,
          );
      state = AsyncData(
        current.copyWith(
          items: [...current.items, ...next.items],
          unreadCount: next.unreadCount,
          meta: next.meta,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      state = AsyncData(current.copyWith(isLoadingMore: false));
    }
  }

  Future<void> markAsRead(AppNotificationModel item) async {
    if (item.readAt != null) return;
    final current = state.value;
    if (current == null) return;

    final now = DateTime.now();
    final updated = current.items
        .map((n) => n.id == item.id ? n.copyWith(readAt: now) : n)
        .toList();
    final nextUnread = current.unreadCount > 0 ? current.unreadCount - 1 : 0;

    state = AsyncData(
      current.copyWith(items: updated, unreadCount: nextUnread),
    );
    ref.read(authSessionProvider.notifier).decrementUnreadNotifications();

    try {
      await ref.read(notificationsRepositoryProvider).markAsRead(item.id);
    } catch (_) {
      state = AsyncData(current);
    }
  }

  Future<void> markAllAsRead() async {
    final current = state.value;
    if (current == null || current.unreadCount == 0) return;

    final now = DateTime.now();
    final updated = current.items
        .map((n) => n.readAt == null ? n.copyWith(readAt: now) : n)
        .toList();
    state = AsyncData(current.copyWith(items: updated, unreadCount: 0));
    ref.read(authSessionProvider.notifier).clearUnreadNotifications();

    try {
      await ref.read(notificationsRepositoryProvider).markAllAsRead();
    } catch (_) {
      state = AsyncData(current);
    }
  }
}

final notificationsProvider =
    AsyncNotifierProvider<NotificationsNotifier, NotificationsState>(
      NotificationsNotifier.new,
    );
