import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';
import '../../core/config/app_mode_provider.dart';
import '../../core/config/env.dart';
import '../../core/offline/offline_demo_database.dart';
import '../../core/widgets/status_badge.dart';
import '../../core/widgets/tempatin_button.dart';
import '../../core/widgets/tempatin_card.dart';
import '../../features/authentication/presentation/providers/auth_session_provider.dart';
import '../../features/home/presentation/providers/home_provider.dart';

/// Shared application mode indicator, server/offline mode toggle, and demo reset panel.
class AppModeSettingsCard extends ConsumerStatefulWidget {
  const AppModeSettingsCard({super.key});

  @override
  ConsumerState<AppModeSettingsCard> createState() =>
      _AppModeSettingsCardState();
}

class _AppModeSettingsCardState extends ConsumerState<AppModeSettingsCard> {
  bool _isResetting = false;

  Future<void> _toggleMode(bool offlineDemo) async {
    await ref.read(appModeProvider.notifier).setOfflineDemo(offlineDemo);
    await ref.read(authSessionProvider.notifier).signOut(notifyServer: false);
    ref.invalidate(homeProvider);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          offlineDemo
              ? 'Beralih ke Mode Demo Offline (SQLite lokal).'
              : 'Beralih ke Mode Server Live (${AppEnv.apiBaseUrl}).',
        ),
      ),
    );
  }

  Future<void> _confirmResetDemo() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Data Demo Offline?'),
        content: const Text(
          'Semua booking, pembayaran simulasi, chat, dan perubahan properti demo akan dikembalikan ke data awal.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Reset Data'),
          ),
        ],
      ),
    );
    if (ok != true) return;

    setState(() => _isResetting = true);
    try {
      await ref.read(offlineDemoDatabaseProvider).resetDemoData();
      await ref
          .read(authSessionProvider.notifier)
          .signOut(notifyServer: false);
      ref.invalidate(homeProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Database demo offline berhasil dikembalikan ke awal.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _isResetting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(appModeProvider);

    return TempatinCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pengaturan & Informasi', style: AppTypography.headingSm),
              StatusBadge(
                label: mode.shortLabel,
                tone: mode.isOfflineDemo ? StatusTone.info : StatusTone.success,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Mode Demo Offline (SQLite)',
              style: AppTypography.label,
            ),
            subtitle: Text(
              mode.isOfflineDemo
                  ? 'Aktif: seluruh fitur berjalan lokal tanpa internet/server.'
                  : 'Nonaktif: terhubung ke ${AppEnv.apiBaseUrl}.',
              style: AppTypography.caption,
            ),
            value: mode.isOfflineDemo,
            activeThumbColor: AppColors.primary,
            onChanged: _toggleMode,
          ),
          if (mode.isOfflineDemo) ...[
            const SizedBox(height: AppSpacing.sm),
            TempatinButton(
              label: 'Reset Data Demo Offline',
              variant: TempatinButtonVariant.outlined,
              icon: LucideIcons.rotateCcw,
              isLoading: _isResetting,
              onPressed: _confirmResetDemo,
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(
            'TEMPATIN Mobile v1.0.0 • ${mode.modeLabel}',
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }
}
