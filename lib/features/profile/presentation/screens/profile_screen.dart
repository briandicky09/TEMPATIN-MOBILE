import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/widgets/app_mode_settings_card.dart';
import '../../../../shared/widgets/app_smart_image.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';

/// User profile screen for Guest & Customer (Owner also links here for profile edit).
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authSessionProvider);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TempatinCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _ProfileAvatar(
                      name: user?.name ?? 'Tamu',
                      avatarUrl: user?.avatarUrl,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.name ?? 'Tamu TEMPATIN',
                            style: AppTypography.headingSm,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user?.email ?? 'Masuk untuk mengakses booking, invoice, dan kontrak.',
                            style: AppTypography.bodySm,
                          ),
                          if (user?.phone != null &&
                              user!.phone!.isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(user.phone!, style: AppTypography.caption),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                if (user != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  StatusBadge(label: user.role.label, tone: StatusTone.info),
                ],
                const SizedBox(height: AppSpacing.lg),
                if (!auth.isAuthenticated)
                  TempatinButton(
                    label: 'Masuk atau Daftar',
                    icon: LucideIcons.logIn,
                    onPressed: () => context.push(RoutePaths.login),
                  )
                else
                  TempatinButton(
                    label: 'Edit Profil',
                    variant: TempatinButtonVariant.secondary,
                    icon: LucideIcons.userPen,
                    onPressed: () => context.push(RoutePaths.editProfile),
                  ),
              ],
            ),
          ),
          if (auth.isAuthenticated) ...[
            const SizedBox(height: AppSpacing.lg),
            TempatinCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _MenuRow(
                    icon: LucideIcons.bell,
                    title: 'Notifikasi',
                    trailing: auth.unreadNotificationsCount > 0
                        ? StatusBadge(
                            label: '${auth.unreadNotificationsCount} baru',
                            tone: StatusTone.danger,
                          )
                        : null,
                    onTap: () => context.push(RoutePaths.notifications),
                  ),
                  const Divider(height: 1, color: AppColors.borderHairline),
                  _MenuRow(
                    icon: LucideIcons.heart,
                    title: 'Kos Favorit',
                    onTap: () => context.go(RoutePaths.favorites),
                  ),
                  const Divider(height: 1, color: AppColors.borderHairline),
                  _MenuRow(
                    icon: LucideIcons.calendarCheck,
                    title: 'Aktivitas Sewa',
                    onTap: () => context.go(RoutePaths.activity),
                  ),
                  const Divider(height: 1, color: AppColors.borderHairline),
                  _MenuRow(
                    icon: LucideIcons.messageSquare,
                    title: 'Pesan & Chat Pemilik',
                    onTap: () => context.push(RoutePaths.chats),
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
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Anda telah keluar.')),
                );
              },
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          const AppModeSettingsCard(),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.name, this.avatarUrl});

  final String name;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipOval(
        child: AppSmartImage(
          source: avatarUrl!,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorWidget: _fallback(),
        ),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'T';
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primaryTint,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderHairline),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: AppTypography.headingMd.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: AppColors.inkCharcoal),
      title: Text(title, style: AppTypography.label),
      trailing:
          trailing ??
          const Icon(
            LucideIcons.chevronRight,
            size: 18,
            color: AppColors.inkSecondary,
          ),
      onTap: onTap,
    );
  }
}
