import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../providers/owner_providers.dart';

/// Owner revenue & occupancy analytics screen (`GET /api/v1/owner/analytics`).
class OwnerAnalyticsScreen extends ConsumerWidget {
  const OwnerAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(ownerAnalyticsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Pendapatan')),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(ownerAnalyticsProvider),
        child: async.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => AppErrorState(
            message: err.toString(),
            onRetry: () => ref.invalidate(ownerAnalyticsProvider),
          ),
          data: (data) => ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              TempatinCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Pendapatan Lunas',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      CurrencyFormatter.formatIdr(data.totalRevenue),
                      style: AppTypography.displaySm.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        StatusBadge(
                          label: 'Okupansi ${data.occupancyRate}%',
                          tone: StatusTone.info,
                        ),
                        StatusBadge(
                          label: '${data.totalBookings} Total Booking',
                          tone: StatusTone.neutral,
                        ),
                        StatusBadge(
                          label:
                              '${data.revenueGrowthPct >= 0 ? '+' : ''}${data.revenueGrowthPct.toStringAsFixed(1)}% bln ini',
                          tone: data.revenueGrowthPct >= 0
                              ? StatusTone.success
                              : StatusTone.warning,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              TempatinCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tren Pendapatan 6 Bulan Terakhir',
                      style: AppTypography.headingSm,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    if (data.monthlyRevenue.isEmpty)
                      Text('Belum ada transaksi.', style: AppTypography.bodySm)
                    else
                      SizedBox(
                        height: 210,
                        child: BarChart(
                          BarChartData(
                            gridData: const FlGridData(
                              show: true,
                              drawVerticalLine: false,
                            ),
                            borderData: FlBorderData(show: false),
                            titlesData: FlTitlesData(
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 28,
                                  getTitlesWidget: (val, _) {
                                    final idx = val.toInt();
                                    if (idx < 0 ||
                                        idx >= data.monthlyRevenue.length) {
                                      return const SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(
                                        data.monthlyRevenue[idx].month,
                                        style: AppTypography.caption,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            barGroups: [
                              for (
                                var i = 0;
                                i < data.monthlyRevenue.length;
                                i++
                              )
                                BarChartGroupData(
                                  x: i,
                                  barRods: [
                                    BarChartRodData(
                                      toY: data.monthlyRevenue[i].value,
                                      color: AppColors.primary,
                                      width: 20,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(6),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              Text('Performa Per Properti', style: AppTypography.headingSm),
              const SizedBox(height: AppSpacing.sm),
              for (final p in data.kosPerformance)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: TempatinCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.title, style: AppTypography.label),
                              const SizedBox(height: 2),
                              Text(
                                'Okupansi ${p.occupancy}% • ${p.booking} booking',
                                style: AppTypography.caption,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          CurrencyFormatter.formatIdr(p.revenue),
                          style: AppTypography.label.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Owner Tab 5 hub linking Profile, Tenants, Surveys, Maintenance, Reviews, Analytics & Logout.
class OwnerMoreScreen extends ConsumerWidget {
  const OwnerMoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authSessionProvider);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Menu Pemilik')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TempatinCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.name ?? 'Pemilik Kos',
                  style: AppTypography.headingSm,
                ),
                const SizedBox(height: 2),
                Text(user?.email ?? '', style: AppTypography.bodySm),
                const SizedBox(height: AppSpacing.sm),
                const StatusBadge(label: 'Pemilik Kos', tone: StatusTone.info),
                const SizedBox(height: AppSpacing.md),
                TempatinButton(
                  label: 'Edit Profil Akun',
                  variant: TempatinButtonVariant.secondary,
                  icon: LucideIcons.userPen,
                  onPressed: () => context.push(RoutePaths.editProfile),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          TempatinCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _OwnerMenuTile(
                  icon: LucideIcons.users,
                  title: 'Daftar Penghuni',
                  onTap: () => context.push(RoutePaths.ownerTenants),
                ),
                const Divider(height: 1, color: AppColors.borderHairline),
                _OwnerMenuTile(
                  icon: LucideIcons.mapPin,
                  title: 'Permintaan Survei',
                  onTap: () => context.push(RoutePaths.ownerSurveys),
                ),
                const Divider(height: 1, color: AppColors.borderHairline),
                _OwnerMenuTile(
                  icon: LucideIcons.wrench,
                  title: 'Laporan Kerusakan',
                  onTap: () => context.push(RoutePaths.ownerMaintenance),
                ),
                const Divider(height: 1, color: AppColors.borderHairline),
                _OwnerMenuTile(
                  icon: LucideIcons.star,
                  title: 'Ulasan & Balasan',
                  onTap: () => context.push(RoutePaths.ownerReviews),
                ),
                const Divider(height: 1, color: AppColors.borderHairline),
                _OwnerMenuTile(
                  icon: LucideIcons.barChart3,
                  title: 'Statistik Pendapatan',
                  onTap: () => context.push(RoutePaths.ownerAnalytics),
                ),
                const Divider(height: 1, color: AppColors.borderHairline),
                _OwnerMenuTile(
                  icon: LucideIcons.bell,
                  title: 'Notifikasi',
                  onTap: () => context.push(RoutePaths.notifications),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          TempatinButton(
            label: 'Keluar dari Akun',
            variant: TempatinButtonVariant.danger,
            icon: LucideIcons.logOut,
            onPressed: () async {
              await ref.read(authSessionProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}

class _OwnerMenuTile extends StatelessWidget {
  const _OwnerMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: AppColors.inkCharcoal),
      title: Text(title, style: AppTypography.label),
      trailing: const Icon(
        LucideIcons.chevronRight,
        size: 16,
        color: AppColors.inkMuted,
      ),
      onTap: onTap,
    );
  }
}
