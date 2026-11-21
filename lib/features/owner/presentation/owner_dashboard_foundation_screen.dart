import 'package:material_ui/material_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../core/widgets/tempatin_card.dart';

/// Phase 4 Owner Dashboard Foundation screen (wired to `/api/v1/owner/dashboard` in Phase 8).
class OwnerDashboardFoundationScreen extends StatelessWidget {
  const OwnerDashboardFoundationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 24),
            const SizedBox(width: AppSpacing.sm),
            const StatusBadge(label: 'Owner', tone: StatusTone.info),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text('Dashboard Pemilik Kos', style: AppTypography.headingLg),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Kelola properti, kamar individual, persetujuan booking, dan laporan penghuni.',
            style: AppTypography.bodySm,
          ),
          const SizedBox(height: AppSpacing.xl),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.45,
            children: const [
              _KpiTile(
                label: 'Total Properti',
                value: '—',
                icon: LucideIcons.building2,
              ),
              _KpiTile(
                label: 'Kos Aktif',
                value: '—',
                icon: LucideIcons.circleCheck,
              ),
              _KpiTile(
                label: 'Booking Menunggu',
                value: '—',
                icon: LucideIcons.clock,
              ),
              _KpiTile(
                label: 'Laporan Terbuka',
                value: '—',
                icon: LucideIcons.wrench,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          TempatinCard(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  LucideIcons.server,
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Siap Integrasi API Phase 6 & 8',
                        style: AppTypography.headingSm,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Data real-time properti, okupansi, dan pendapatan akan dimuat dari endpoint /api/v1/owner/dashboard setelah backend Sanctum disetujui.',
                        style: AppTypography.bodySm,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TempatinCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: AppTypography.headingMd),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
