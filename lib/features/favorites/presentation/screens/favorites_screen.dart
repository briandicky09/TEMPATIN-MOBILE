import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../shared/widgets/guest_auth_prompt.dart';
import '../../../../shared/widgets/kos_card.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../providers/favorites_provider.dart';

/// Saved wishlist screen backed by `GET /api/v1/favorites`.
class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
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
      ref.read(favoritesProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authSessionProvider);
    if (!auth.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kos Favorit')),
        body: const GuestAuthPrompt(
          icon: LucideIcons.heart,
          title: 'Simpan Kos Pilihan Anda',
          description: 'Masuk dengan akun TEMPATIN untuk menyimpan dan membandingkan kos favorit.',
        ),
      );
    }

    final favAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kos Favorit')),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => ref.read(favoritesProvider.notifier).refresh(),
        child: favAsync.when(
          loading: () => ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (_, _) => const KosListCardSkeleton(),
          ),
          error: (err, _) => ListView(
            children: [
              const SizedBox(height: 48),
              AppErrorState(
                message: err.toString(),
                onRetry: () => ref.read(favoritesProvider.notifier).refresh(),
              ),
            ],
          ),
          data: (paginated) {
            if (paginated.items.isEmpty) {
              return ListView(
                children: [
                  const SizedBox(height: 48),
                  AppEmptyState(
                    icon: LucideIcons.heart,
                    title: 'Belum Ada Kos Favorit',
                    description: 'Ketuk ikon hati pada kartu kos untuk menyimpannya ke daftar ini.',
                    actionLabel: 'Eksplor Kos',
                    onAction: () => context.go(RoutePaths.explore),
                  ),
                ],
              );
            }

            return ListView.separated(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppSpacing.lg),
              itemCount:
                  paginated.items.length + (paginated.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                if (index >= paginated.items.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final kos = paginated.items[index];
                return KosCard(
                  kos: kos,
                  layout: KosCardLayout.compactList,
                  onTap: () => context.push(RoutePaths.kosDetail(kos.slug)),
                  onFavoriteTap: () async {
                    try {
                      await ref
                          .read(favoritesProvider.notifier)
                          .toggleFavorite(kos);
                    } on AppException catch (e) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
