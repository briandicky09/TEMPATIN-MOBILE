import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/router/routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/models.dart';
import '../../../shared/widgets/kos_card.dart';
import '../../../shared/widgets/tempatin_widgets.dart';

Future<void> _toggleFav(BuildContext context, WidgetRef ref, int kosId) async {
  final session = ref.read(sessionProvider);
  if (session == null) {
    context.push(AppRoutes.login);
    return;
  }
  final added = await ref
      .read(engagementRepositoryProvider)
      .toggleFavorite(session.user.id, kosId);
  ref.invalidate(featuredKosProvider);
  ref.invalidate(latestKosProvider);
  ref.invalidate(exploreKosProvider);
  ref.invalidate(favoritesProvider);
  ref.invalidate(kosDetailProvider(kosId));
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        added ? 'Ditambahkan ke favorit.' : 'Dihapus dari favorit.',
      ),
    ),
  );
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final featuredAsync = ref.watch(featuredKosProvider);
    final latestAsync = ref.watch(latestKosProvider);
    final unreadAsync = ref.watch(unreadNotificationCountProvider);
    final unreadCount = unreadAsync.value ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 28),
        actions: [
          IconButton(
            tooltip: 'Notifikasi',
            onPressed: () {
              if (session == null) {
                context.push(AppRoutes.login);
                return;
              }
              context.push(AppRoutes.notifications);
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(LucideIcons.bell, size: 21),
                if (unreadCount > 0)
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
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          ref.invalidate(featuredKosProvider);
          ref.invalidate(latestKosProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(
              session != null
                  ? 'Halo, ${session.user.name}'
                  : 'Selamat Datang di TEMPATIN',
              style: AppTypography.headingLg,
            ),
            const SizedBox(height: 4),
            const Text(
              'Temukan hunian kos nyaman — seluruh data & foto tersimpan lokal tanpa internet.',
              style: AppTypography.bodySm,
            ),
            const SizedBox(height: AppSpacing.md),

            // Search Shortcut
            TempatinCard(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 14,
              ),
              onTap: () => context.go(AppRoutes.explore),
              child: const Row(
                children: [
                  Icon(LucideIcons.search, size: 18, color: AppColors.inkMuted),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'Cari nama kos, kota, atau alamat...',
                    style: AppTypography.bodySm,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Category Quick Filters
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final cat in const [
                    'Semua',
                    'Putri',
                    'Putra',
                    'Campur',
                    'Eksklusif',
                  ])
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: ActionChip(
                        label: Text(cat),
                        onPressed: () {
                          ref
                              .read(exploreFilterProvider.notifier)
                              .setType(cat == 'Semua' ? null : cat);
                          context.go(AppRoutes.explore);
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Featured Carousel
            const Text('Rekomendasi Pilihan', style: AppTypography.headingMd),
            const SizedBox(height: AppSpacing.sm),
            featuredAsync.when(
              loading: () => const SizedBox(
                height: 230,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, _) => Text('Gagal memuat: $err'),
              data: (items) {
                if (items.isEmpty) {
                  return const Text(
                    'Belum ada properti unggulan.',
                    style: AppTypography.bodySm,
                  );
                }
                return SizedBox(
                  height: 266,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return SizedBox(
                        width: 245,
                        child: KosCard(
                          item: item,
                          onTap: () =>
                              context.push(AppRoutes.kosDetail(item.kos.id)),
                          onToggleFavorite: () =>
                              _toggleFav(context, ref, item.kos.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: AppSpacing.xl),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Kos Terbaru', style: AppTypography.headingMd),
                TextButton(
                  onPressed: () => context.go(AppRoutes.explore),
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            latestAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Gagal memuat: $err'),
              data: (items) {
                if (items.isEmpty) {
                  return const EmptyStateView(
                    icon: LucideIcons.building2,
                    title: 'Belum Ada Data Kos',
                    description: 'Tambahkan properti melalui akun Pemilik.',
                  );
                }
                return Column(
                  children: [
                    for (final item in items)
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: KosCard(
                          item: item,
                          compact: true,
                          onTap: () =>
                              context.push(AppRoutes.kosDetail(item.kos.id)),
                          onToggleFavorite: () =>
                              _toggleFav(context, ref, item.kos.id),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = ref.read(exploreFilterProvider).query;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilterSheet() async {
    final facilities = await ref.read(allFacilitiesProvider.future);
    if (!mounted) return;
    final current = ref.read(exploreFilterProvider);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (_) => _FilterSheet(
        initial: current,
        facilities: facilities,
        onApply: (updated) =>
            ref.read(exploreFilterProvider.notifier).update(updated),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(exploreFilterProvider);
    final resultsAsync = ref.watch(exploreKosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eksplor Kos'),
        actions: [
          IconButton(
            tooltip: 'Filter Lanjutan',
            onPressed: _openFilterSheet,
            icon: const Icon(LucideIcons.slidersHorizontal, size: 20),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (v) =>
                  ref.read(exploreFilterProvider.notifier).setQuery(v),
              decoration: InputDecoration(
                hintText: 'Cari kos, kota, atau jalan...',
                prefixIcon: const Icon(LucideIcons.search, size: 18),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(LucideIcons.x, size: 16),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(exploreFilterProvider.notifier).setQuery('');
                        },
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              children: [
                for (final t in const [
                  'Semua',
                  'Putri',
                  'Putra',
                  'Campur',
                  'Eksklusif',
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(t),
                      selected: (filter.type ?? 'Semua') == t,
                      onSelected: (_) => ref
                          .read(exploreFilterProvider.notifier)
                          .setType(t == 'Semua' ? null : t),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: resultsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (items) {
                if (items.isEmpty) {
                  return EmptyStateView(
                    icon: LucideIcons.searchX,
                    title: 'Kos Tidak Ditemukan',
                    description: 'Coba ubah kata kunci atau reset filter pencarian Anda.',
                    actionLabel: 'Reset Filter',
                    onAction: () {
                      _searchController.clear();
                      ref.read(exploreFilterProvider.notifier).reset();
                    },
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: items.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return KosCard(
                      item: item,
                      onTap: () =>
                          context.push(AppRoutes.kosDetail(item.kos.id)),
                      onToggleFavorite: () =>
                          _toggleFav(context, ref, item.kos.id),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSheet extends StatefulWidget {
  const _FilterSheet({
    required this.initial,
    required this.facilities,
    required this.onApply,
  });

  final KosFilterParams initial;
  final List<dynamic> facilities;
  final ValueChanged<KosFilterParams> onApply;

  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<_FilterSheet> {
  late final TextEditingController _minCtrl;
  late final TextEditingController _maxCtrl;
  late String? _type;
  late String _sortBy;
  late Set<int> _facilityIds;

  @override
  void initState() {
    super.initState();
    _minCtrl = TextEditingController(
      text: widget.initial.minPrice?.toStringAsFixed(0) ?? '',
    );
    _maxCtrl = TextEditingController(
      text: widget.initial.maxPrice?.toStringAsFixed(0) ?? '',
    );
    _type = widget.initial.type;
    _sortBy = widget.initial.sortBy;
    _facilityIds = {...widget.initial.facilityIds};
  }

  @override
  void dispose() {
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filter & Urutkan', style: AppTypography.headingMd),
            const SizedBox(height: AppSpacing.md),
            const Text('Rentang Harga / Bulan', style: AppTypography.label),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Min (Rp)'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TextField(
                    controller: _maxCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Maks (Rp)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('Kategori Kos', style: AppTypography.label),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final t in const [
                  'Semua',
                  'Putri',
                  'Putra',
                  'Campur',
                  'Eksklusif',
                ])
                  ChoiceChip(
                    label: Text(t),
                    selected: (_type ?? 'Semua') == t,
                    onSelected: (_) =>
                        setState(() => _type = t == 'Semua' ? null : t),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('Urutkan Berdasarkan', style: AppTypography.label),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final s in const [
                  ('newest', 'Terbaru'),
                  ('price_asc', 'Harga Termurah'),
                  ('price_desc', 'Harga Termahal'),
                  ('rating_desc', 'Rating Tertinggi'),
                ])
                  ChoiceChip(
                    label: Text(s.$2),
                    selected: _sortBy == s.$1,
                    onSelected: (_) => setState(() => _sortBy = s.$1),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Text('Fasilitas', style: AppTypography.label),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                for (final fac in widget.facilities)
                  FilterChip(
                    label: Text(fac.name as String),
                    selected: _facilityIds.contains(fac.id as int),
                    onSelected: (sel) {
                      setState(() {
                        if (sel) {
                          _facilityIds.add(fac.id as int);
                        } else {
                          _facilityIds.remove(fac.id as int);
                        }
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: TempatinButton(
                    label: 'Reset',
                    variant: ButtonVariant.outlined,
                    onPressed: () {
                      widget.onApply(const KosFilterParams());
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: TempatinButton(
                    label: 'Terapkan',
                    onPressed: () {
                      widget.onApply(
                        widget.initial.copyWith(
                          type: () => _type,
                          minPrice: () => double.tryParse(_minCtrl.text.trim()),
                          maxPrice: () => double.tryParse(_maxCtrl.text.trim()),
                          facilityIds: _facilityIds,
                          sortBy: _sortBy,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
