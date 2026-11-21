import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/models/home_data_model.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../../shared/widgets/kos_card.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../../property/presentation/providers/property_providers.dart';
import '../providers/home_provider.dart';

/// Customer & Guest discovery home screen connected to `GET /api/v1/home`.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const _fallbackCities = [
    'Surabaya',
    'Malang',
    'Yogyakarta',
    'Bandung',
    'Jakarta Selatan',
    'Semarang',
  ];

  static const _kosTypes = ['Putri', 'Putra', 'Campur', 'Eksklusif'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authSessionProvider);
    final homeAsync = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppSpacing.lg,
        title: Image.asset(
          'assets/images/logo.png',
          height: 26,
          fit: BoxFit.contain,
        ),
        actions: [
          _BadgeIconButton(
            icon: LucideIcons.messageSquare,
            tooltip: 'Pesan',
            count: auth.unreadMessagesCount,
            onPressed: () {
              if (!auth.isAuthenticated) {
                context.push(RoutePaths.login);
                return;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Fitur Pesan internal diaktifkan pada Phase 9.',
                  ),
                ),
              );
            },
          ),
          _BadgeIconButton(
            icon: LucideIcons.bell,
            tooltip: 'Notifikasi',
            count: auth.unreadNotificationsCount,
            onPressed: () {
              if (!auth.isAuthenticated) {
                context.push(RoutePaths.login);
                return;
              }
              context.push(RoutePaths.notifications);
            },
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => ref.read(homeProvider.notifier).refresh(),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _HeroSearchCard(
              userName: auth.user?.name,
              onSearchTap: () => context.go(RoutePaths.explore),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Cities
            Text('Kota Populer', style: AppTypography.headingSm),
            const SizedBox(height: AppSpacing.sm),
            _buildCityStrip(context, ref, homeAsync.value?.popularCities),
            const SizedBox(height: AppSpacing.xl),

            // Kos Types
            Text('Tipe Hunian', style: AppTypography.headingSm),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: _kosTypes
                  .map(
                    (type) => ActionChip(
                      avatar: const Icon(
                        LucideIcons.building2,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      label: Text('Kos $type'),
                      onPressed: () {
                        ref.read(exploreFilterProvider.notifier).setType(type);
                        context.go(RoutePaths.explore);
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Featured Kos Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kos Pilihan Terbaru', style: AppTypography.headingSm),
                TextButton(
                  onPressed: () => context.go(RoutePaths.explore),
                  child: Text(
                    'Lihat Semua',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            homeAsync.when(
              loading: () => Column(
                children: const [
                  KosCardSkeleton(),
                  SizedBox(height: AppSpacing.md),
                  KosCardSkeleton(),
                ],
              ),
              error: (err, _) => AppErrorState(
                message: err.toString(),
                onRetry: () => ref.read(homeProvider.notifier).refresh(),
              ),
              data: (data) =>
                  _buildFeaturedList(context, ref, data, auth.isAuthenticated),
            ),

            if (!auth.isAuthenticated) ...[
              const SizedBox(height: AppSpacing.xl),
              TempatinCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.shieldCheck,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Masuk untuk Simpan Favorit & Booking',
                            style: AppTypography.headingSm,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Alur sewa terverifikasi dengan persetujuan pemilik, pembayaran Midtrans, dan kontrak digital.',
                      style: AppTypography.bodySm,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TempatinButton(
                      label: 'Masuk atau Daftar Akun',
                      icon: LucideIcons.logIn,
                      onPressed: () => context.push(RoutePaths.login),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCityStrip(
    BuildContext context,
    WidgetRef ref,
    List<CityStatModel>? cities,
  ) {
    final labels = (cities != null && cities.isNotEmpty)
        ? cities.map((c) => c.city).toList()
        : _fallbackCities;

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final city = labels[index];
          return ActionChip(
            label: Text(city),
            onPressed: () {
              ref.read(exploreFilterProvider.notifier).setCity(city);
              context.go(RoutePaths.explore);
            },
          );
        },
      ),
    );
  }

  Widget _buildFeaturedList(
    BuildContext context,
    WidgetRef ref,
    HomeDataModel data,
    bool isAuthenticated,
  ) {
    if (data.featuredKos.isEmpty) {
      return AppEmptyState(
        icon: LucideIcons.building2,
        title: 'Belum Ada Properti Aktif',
        description: 'Saat ini belum ada kos yang tersedia untuk ditampilkan.',
        actionLabel: 'Buka Eksplor',
        onAction: () => context.go(RoutePaths.explore),
      );
    }

    return Column(
      children: data.featuredKos
          .map(
            (kos) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: KosCard(
                kos: kos,
                onTap: () => context.push(RoutePaths.kosDetail(kos.slug)),
                onFavoriteTap: () =>
                    _handleFavoriteTap(context, ref, kos, isAuthenticated),
              ),
            ),
          )
          .toList(),
    );
  }

  Future<void> _handleFavoriteTap(
    BuildContext context,
    WidgetRef ref,
    KosSummaryModel kos,
    bool isAuthenticated,
  ) async {
    if (!isAuthenticated) {
      context.push(RoutePaths.login);
      return;
    }
    try {
      final isFav = await ref
          .read(favoritesProvider.notifier)
          .toggleFavorite(kos);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFav ? 'Ditambahkan ke favorit.' : 'Dihapus dari favorit.',
          ),
        ),
      );
    } on AppException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}

class _HeroSearchCard extends StatelessWidget {
  const _HeroSearchCard({required this.onSearchTap, this.userName});

  final String? userName;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    return TempatinCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(
            label: userName != null
                ? 'Halo, ${userName!.split(' ').first}'
                : 'Marketplace Kos Terverifikasi',
            tone: StatusTone.info,
            icon: LucideIcons.sparkles,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Temukan kos nyaman,\ntransparan & terverifikasi.',
            style: AppTypography.headingLg,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Cari hunian ideal, jadwalkan survei lokasi, dan kelola sewa digital dalam satu aplikasi.',
            style: AppTypography.editorialSubhead.copyWith(fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 64,
            width: double.infinity,
            child: SvgPicture.asset(
              'assets/images/city-skyline.svg',
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          InkWell(
            borderRadius: AppRadii.inputRadius,
            onTap: onSearchTap,
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: AppRadii.inputRadius,
                border: Border.all(color: AppColors.borderHairline),
              ),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.search,
                    size: 18,
                    color: AppColors.inkSecondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      'Cari kos berdasarkan kota, nama, atau kampus...',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.inkMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeIconButton extends StatelessWidget {
  const _BadgeIconButton({
    required this.icon,
    required this.tooltip,
    required this.count,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final int count;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, size: 20),
          if (count > 0)
            Positioned(
              right: -5,
              top: -5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.accentCoral,
                  borderRadius: AppRadii.pillRadius,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                alignment: Alignment.center,
                child: Text(
                  count > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
