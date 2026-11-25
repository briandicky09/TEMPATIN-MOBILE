import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/config/app_mode_provider.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/widgets/kos_card.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../providers/owner_providers.dart';

/// Live Owner Dashboard wired to `GET /api/v1/owner/dashboard`.
class OwnerDashboardScreen extends ConsumerWidget {
  const OwnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashAsync = ref.watch(ownerDashboardProvider);
    final auth = ref.watch(authSessionProvider);
    final isOfflineDemo = ref.watch(appModeProvider).isOfflineDemo;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 24),
            const SizedBox(width: AppSpacing.sm),
            const StatusBadge(label: 'Owner', tone: StatusTone.info),
            if (isOfflineDemo) ...[
              const SizedBox(width: AppSpacing.xs),
              const StatusBadge(label: 'Offline', tone: StatusTone.neutral),
            ],
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () => context.push(RoutePaths.notifications),
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(LucideIcons.bell, size: 22),
                if (auth.unreadNotificationsCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: AppColors.dangerText,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          ref.invalidate(ownerDashboardProvider);
          await ref.read(ownerDashboardProvider.future);
        },
        child: dashAsync.when(
          loading: () => ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: const [
              SkeletonBox(height: 110),
              SizedBox(height: AppSpacing.md),
              SkeletonBox(height: 110),
              SizedBox(height: AppSpacing.md),
              SkeletonBox(height: 180),
            ],
          ),
          error: (err, _) => ListView(
            children: [
              const SizedBox(height: 48),
              AppErrorState(
                message: err.toString(),
                onRetry: () => ref.invalidate(ownerDashboardProvider),
              ),
            ],
          ),
          data: (dash) => ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Text(
                'Halo, ${auth.user?.name ?? 'Pemilik Kos'}',
                style: AppTypography.headingLg,
              ),
              const SizedBox(height: 2),
              Text(
                'Ringkasan operasional properti dan permintaan masuk.',
                style: AppTypography.bodySm,
              ),
              const SizedBox(height: AppSpacing.lg),

              // KPI Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.45,
                children: [
                  _KpiTile(
                    label: 'Total Properti',
                    value: '${dash.totalKos}',
                    icon: LucideIcons.building2,
                    onTap: () => context.go(RoutePaths.ownerProperties),
                  ),
                  _KpiTile(
                    label: 'Kos Aktif',
                    value: '${dash.activeKos}',
                    icon: LucideIcons.circleCheck,
                    onTap: () => context.go(RoutePaths.ownerProperties),
                  ),
                  _KpiTile(
                    label: 'Booking Menunggu',
                    value: '${dash.pendingBookingsCount}',
                    icon: LucideIcons.clock,
                    highlight: dash.pendingBookingsCount > 0,
                    onTap: () => context.go(RoutePaths.ownerBookings),
                  ),
                  _KpiTile(
                    label: 'Rata-rata Sewa',
                    value: CurrencyFormatter.formatIdr(dash.avgPrice),
                    icon: LucideIcons.wallet,
                    compactValue: true,
                    onTap: () => context.push(RoutePaths.ownerAnalytics),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),

              // Pending Actions Alert Banner List
              Text('Aksi Cepat Operasional', style: AppTypography.headingSm),
              const SizedBox(height: AppSpacing.sm),
              TempatinCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _ActionQueueRow(
                      icon: LucideIcons.clipboardCheck,
                      title: 'Persetujuan Booking Baru',
                      count: dash.pendingBookingsCount,
                      onTap: () => context.go(RoutePaths.ownerBookings),
                    ),
                    const Divider(height: 1, color: AppColors.borderHairline),
                    _ActionQueueRow(
                      icon: LucideIcons.mapPin,
                      title: 'Permintaan Survei Lokasi',
                      count: dash.pendingSurveysCount,
                      onTap: () => context.push(RoutePaths.ownerSurveys),
                    ),
                    const Divider(height: 1, color: AppColors.borderHairline),
                    _ActionQueueRow(
                      icon: LucideIcons.wrench,
                      title: 'Laporan Kerusakan Terbuka',
                      count: dash.openMaintenanceCount,
                      onTap: () => context.push(RoutePaths.ownerMaintenance),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Properti Terbaru', style: AppTypography.headingSm),
                  TextButton(
                    onPressed: () => context.go(RoutePaths.ownerProperties),
                    child: const Text('Kelola Semua'),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              if (dash.recentKos.isEmpty)
                AppEmptyState(
                  icon: LucideIcons.building2,
                  title: 'Belum Ada Properti',
                  description: 'Tambahkan properti kos pertama Anda sekarang.',
                  actionLabel: 'Tambah Properti',
                  onAction: () => context.push(RoutePaths.ownerKosCreate),
                )
              else
                for (final kos in dash.recentKos)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: KosCard(
                      kos: kos,
                      layout: KosCardLayout.compactList,
                      onTap: () =>
                          context.push(RoutePaths.ownerKosEdit(kos.slug)),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({
    required this.label,
    required this.value,
    required this.icon,
    this.highlight = false,
    this.compactValue = false,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final bool highlight;
  final bool compactValue;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TempatinCard(
      onTap: onTap,
      backgroundColor: highlight ? AppColors.primaryTint : AppColors.surface,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 20,
            color: highlight ? AppColors.primary : AppColors.inkMuted,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: compactValue
                    ? AppTypography.headingSm
                    : AppTypography.headingLg,
              ),
              const SizedBox(height: 2),
              Text(label, style: AppTypography.caption),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionQueueRow extends StatelessWidget {
  const _ActionQueueRow({
    required this.icon,
    required this.title,
    required this.count,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: AppColors.primary),
      title: Text(title, style: AppTypography.label),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (count > 0)
            StatusBadge(label: '$count', tone: StatusTone.warning)
          else
            const StatusBadge(label: '0', tone: StatusTone.neutral),
          const SizedBox(width: AppSpacing.xs),
          const Icon(
            LucideIcons.chevronRight,
            size: 16,
            color: AppColors.inkMuted,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
