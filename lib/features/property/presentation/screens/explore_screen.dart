import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/storage/prefs_storage.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../../shared/widgets/kos_card.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../domain/kos_filter.dart';
import '../providers/property_providers.dart';
import '../widgets/filter_bottom_sheet.dart';

/// Search, filter, and paginated discovery screen (`GET /api/v1/kos`).
class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(exploreFilterProvider).keyword;
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      ref.read(exploreKosProvider.notifier).loadMore();
    }
  }

  void _onKeywordChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      ref.read(exploreFilterProvider.notifier).setKeyword(value);
      if (value.trim().length >= 2) {
        ref.read(prefsStorageProvider).saveRecentSearch(value);
      }
    });
  }

  Future<void> _openFilterSheet() async {
    final current = ref.read(exploreFilterProvider);
    final updated = await FilterBottomSheet.show(context, current: current);
    if (updated != null) {
      ref.read(exploreFilterProvider.notifier).update(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(exploreFilterProvider);
    final kosAsync = ref.watch(exploreKosProvider);
    final isAuthenticated = ref.watch(
      authSessionProvider.select((s) => s.isAuthenticated),
    );
    final recentSearches = ref.read(prefsStorageProvider).getRecentSearches();

    if (_searchController.text != filter.keyword &&
        !FocusScope.of(context).hasFocus) {
      _searchController.text = filter.keyword;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eksplor Kos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onKeywordChanged,
                    onSubmitted: (v) {
                      ref.read(exploreFilterProvider.notifier).setKeyword(v);
                      ref.read(prefsStorageProvider).saveRecentSearch(v);
                    },
                    textInputAction: TextInputAction.search,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.inkPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari nama kos, kota, atau alamat...',
                      prefixIcon: const Icon(
                        LucideIcons.search,
                        size: 18,
                        color: AppColors.inkSecondary,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                ref
                                    .read(exploreFilterProvider.notifier)
                                    .setKeyword('');
                              },
                              icon: const Icon(Icons.close_rounded, size: 18),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                _FilterTriggerButton(
                  activeCount: filter.activeFilterCount,
                  onPressed: _openFilterSheet,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (filter.hasAnyFilter) _ActiveFiltersRow(filter: filter),
          if (!filter.hasAnyFilter && recentSearches.isNotEmpty)
            _RecentSearchesStrip(
              searches: recentSearches,
              onSelect: (term) {
                _searchController.text = term;
                ref.read(exploreFilterProvider.notifier).setKeyword(term);
              },
            ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => ref.read(exploreKosProvider.notifier).refresh(),
              child: kosAsync.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: 5,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, _) => const KosListCardSkeleton(),
                ),
                error: (err, _) => ListView(
                  children: [
                    const SizedBox(height: 48),
                    AppErrorState(
                      message: err.toString(),
                      onRetry: () =>
                          ref.read(exploreKosProvider.notifier).refresh(),
                    ),
                  ],
                ),
                data: (paginated) {
                  if (paginated.items.isEmpty) {
                    return ListView(
                      children: [
                        const SizedBox(height: 48),
                        AppEmptyState(
                          icon: LucideIcons.searchX,
                          title: 'Kos Tidak Ditemukan',
                          description: 'Coba ubah kata kunci atau reset filter pencarian Anda.',
                          actionLabel: filter.hasAnyFilter
                              ? 'Reset Filter'
                              : 'Muat Ulang',
                          onAction: () {
                            if (filter.hasAnyFilter) {
                              _searchController.clear();
                              ref.read(exploreFilterProvider.notifier).reset();
                            } else {
                              ref.read(exploreKosProvider.notifier).refresh();
                            }
                          },
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount:
                        paginated.items.length +
                        (paginated.isLoadingMore ||
                                paginated.loadMoreError != null
                            ? 1
                            : 0),
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      if (index >= paginated.items.length) {
                        if (paginated.loadMoreError != null) {
                          return Center(
                            child: TextButton.icon(
                              onPressed: () => ref
                                  .read(exploreKosProvider.notifier)
                                  .loadMore(),
                              icon: const Icon(LucideIcons.refreshCw, size: 16),
                              label: const Text('Gagal memuat lagi. Coba lagi'),
                            ),
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppSpacing.md,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }

                      final kos = paginated.items[index];
                      return KosCard(
                        kos: kos,
                        layout: KosCardLayout.compactList,
                        onTap: () =>
                            context.push(RoutePaths.kosDetail(kos.slug)),
                        onFavoriteTap: () =>
                            _toggleFavorite(context, kos, isAuthenticated),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleFavorite(
    BuildContext context,
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

class _FilterTriggerButton extends StatelessWidget {
  const _FilterTriggerButton({
    required this.activeCount,
    required this.onPressed,
  });

  final int activeCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final hasActive = activeCount > 0;
    return Material(
      color: hasActive ? AppColors.primaryTint : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.inputRadius,
        side: BorderSide(
          color: hasActive ? AppColors.primary : AppColors.borderHairline,
        ),
      ),
      child: InkWell(
        borderRadius: AppRadii.inputRadius,
        onTap: onPressed,
        child: SizedBox(
          height: 48,
          width: 52,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                LucideIcons.slidersHorizontal,
                size: 20,
                color: hasActive ? AppColors.primary : AppColors.inkCharcoal,
              ),
              if (hasActive)
                Positioned(
                  top: 6,
                  right: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: AppRadii.pillRadius,
                    ),
                    child: Text(
                      '$activeCount',
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
        ),
      ),
    );
  }
}

class _ActiveFiltersRow extends ConsumerWidget {
  const _ActiveFiltersRow({required this.filter});

  final KosFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(exploreFilterProvider.notifier);

    return Container(
      height: 48,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.borderHairline, width: 1),
        ),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (filter.type != null)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: InputChip(
                label: Text('Tipe: ${filter.type}'),
                onDeleted: () => notifier.setType(null),
              ),
            ),
          if (filter.city != null)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: InputChip(
                label: Text('Kota: ${filter.city}'),
                onDeleted: () => notifier.setCity(null),
              ),
            ),
          if (filter.sort != KosSortOption.newest)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: InputChip(
                label: Text(filter.sort.label),
                onDeleted: () => notifier.update(
                  filter.copyWith(sort: KosSortOption.newest),
                ),
              ),
            ),
          if (filter.facilityIds.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: InputChip(
                label: Text('${filter.facilityIds.length} Fasilitas'),
                onDeleted: () =>
                    notifier.update(filter.copyWith(facilityIds: const [])),
              ),
            ),
          ActionChip(
            label: const Text('Reset Semua'),
            onPressed: notifier.reset,
          ),
        ],
      ),
    );
  }
}

class _RecentSearchesStrip extends StatelessWidget {
  const _RecentSearchesStrip({required this.searches, required this.onSelect});

  final List<String> searches;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.borderHairline, width: 1),
        ),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: searches.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          return ActionChip(
            avatar: const Icon(
              LucideIcons.history,
              size: 13,
              color: AppColors.inkSecondary,
            ),
            label: Text(searches[index], style: AppTypography.caption),
            onPressed: () => onSelect(searches[index]),
          );
        },
      ),
    );
  }
}
