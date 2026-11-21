import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/models/notification_model.dart';
import '../../../../shared/models/user_model.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../providers/notifications_provider.dart';

/// Notifications feed with explicit single/bulk read actions (`GET /api/v1/notifications`).
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(notificationsProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifAsync = ref.watch(notificationsProvider);
    final unreadCount = notifAsync.value?.unreadCount ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () =>
                  ref.read(notificationsProvider.notifier).markAllAsRead(),
              child: Text(
                'Tandai Dibaca',
                style: AppTypography.caption.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => ref.read(notificationsProvider.notifier).refresh(),
        child: notifAsync.when(
          loading: () => ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: 5,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (_, _) => const SkeletonBox(height: 88),
          ),
          error: (err, _) => ListView(
            children: [
              const SizedBox(height: 48),
              AppErrorState(
                message: err.toString(),
                onRetry: () =>
                    ref.read(notificationsProvider.notifier).refresh(),
              ),
            ],
          ),
          data: (state) {
            if (state.items.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(height: 48),
                  AppEmptyState(
                    icon: LucideIcons.bellOff,
                    title: 'Belum Ada Notifikasi',
                    description: 'Pembaruan booking, pembayaran, survei, dan pesan akan tampil di sini.',
                  ),
                ],
              );
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                if (index >= state.items.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final item = state.items[index];
                final isUnread = item.readAt == null;

                return TempatinCard(
                  backgroundColor: isUnread
                      ? AppColors.primaryTint
                      : AppColors.surface,
                  onTap: () => _onTapNotification(item),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.borderHairline),
                        ),
                        child: Icon(
                          _categoryIcon(item.category),
                          size: 18,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: AppTypography.label.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (isUnread)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(item.message, style: AppTypography.bodySm),
                            if (item.createdAt != null) ...[
                              const SizedBox(height: 6),
                              Text(
                                DateFormatter.dateTime(item.createdAt!),
                                style: AppTypography.caption,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _onTapNotification(AppNotificationModel item) {
    ref.read(notificationsProvider.notifier).markAsRead(item);
    final isOwner = ref.read(authSessionProvider).role == UserRole.owner;
    final category = item.category.toLowerCase();
    final actionId = item.actionId;

    switch (category) {
      case 'chat':
        final chatId = int.tryParse(actionId ?? '');
        if (chatId != null) {
          context.push(RoutePaths.chatDetail(chatId));
        } else {
          context.go(isOwner ? RoutePaths.ownerMessages : RoutePaths.chats);
        }
      case 'booking':
        if (actionId != null && actionId.startsWith('BK-')) {
          context.push(
            isOwner
                ? RoutePaths.ownerBookingDetail(actionId)
                : RoutePaths.bookingDetail(actionId),
          );
        } else {
          context.go(isOwner ? RoutePaths.ownerBookings : RoutePaths.activity);
        }
      case 'survey':
        if (isOwner) {
          context.push(RoutePaths.ownerSurveys);
        } else {
          context.go(RoutePaths.activity);
        }
      case 'maintenance':
        if (isOwner) {
          context.push(RoutePaths.ownerMaintenance);
        } else {
          context.go(RoutePaths.activity);
        }
      case 'contract':
        if (actionId != null && actionId.isNotEmpty) {
          context.push(RoutePaths.bookingContract(actionId));
        }
      case 'review':
        if (isOwner) {
          context.push(RoutePaths.ownerReviews);
        } else if (actionId != null && actionId.isNotEmpty) {
          context.push(RoutePaths.kosDetail(actionId));
        }
    }
  }

  IconData _categoryIcon(String category) {
    return switch (category.toLowerCase()) {
      'booking' => LucideIcons.calendarCheck,
      'review' => LucideIcons.star,
      'survey' => LucideIcons.mapPin,
      'maintenance' => LucideIcons.wrench,
      'chat' => LucideIcons.messageSquare,
      'contract' => LucideIcons.fileText,
      _ => LucideIcons.bell,
    };
  }
}
