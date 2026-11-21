import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../data/owner_repository.dart';
import '../providers/owner_providers.dart';

/// Owner property list (`GET /api/v1/owner/kos`) with filter tabs, room management & CRUD.
class OwnerKosListScreen extends ConsumerStatefulWidget {
  const OwnerKosListScreen({super.key});

  @override
  ConsumerState<OwnerKosListScreen> createState() => _OwnerKosListScreenState();
}

class _OwnerKosListScreenState extends ConsumerState<OwnerKosListScreen> {
  String _statusFilter = 'all';
  String _search = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = (status: _statusFilter, search: _search);
    final listAsync = ref.watch(ownerKosListProvider(query));

    return Scaffold(
      appBar: AppBar(title: const Text('Properti Kos Saya')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(RoutePaths.ownerKosCreate),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(LucideIcons.plus),
        label: const Text('Tambah Kos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari nama kos atau kota...',
                prefixIcon: const Icon(LucideIcons.search, size: 18),
                suffixIcon: _search.isNotEmpty
                    ? IconButton(
                        icon: const Icon(LucideIcons.x, size: 16),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _search = '');
                        },
                      )
                    : null,
              ),
              onSubmitted: (v) => setState(() => _search = v.trim()),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              children: [
                for (final entry in const [
                  ('all', 'Semua'),
                  ('active', 'Aktif'),
                  ('inactive', 'Nonaktif'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(entry.$2),
                      selected: _statusFilter == entry.$1,
                      onSelected: (_) =>
                          setState(() => _statusFilter = entry.$1),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async =>
                  ref.invalidate(ownerKosListProvider(query)),
              child: listAsync.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: 4,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, _) => const KosListCardSkeleton(),
                ),
                error: (err, _) => AppErrorState(
                  message: err.toString(),
                  onRetry: () => ref.invalidate(ownerKosListProvider(query)),
                ),
                data: (res) {
                  if (res.items.isEmpty) {
                    return ListView(
                      children: [
                        const SizedBox(height: 48),
                        AppEmptyState(
                          icon: LucideIcons.building2,
                          title: 'Belum Ada Properti',
                          description: 'Klik tombol + Tambah Kos untuk mendaftarkan properti baru.',
                          actionLabel: 'Tambah Properti',
                          onAction: () =>
                              context.push(RoutePaths.ownerKosCreate),
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.sm,
                      AppSpacing.lg,
                      96,
                    ),
                    itemCount: res.items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final kos = res.items[index];
                      final isActive = kos.status == 'active';

                      return TempatinCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StatusBadge(
                                  label: isActive ? 'Aktif' : 'Nonaktif',
                                  tone: isActive
                                      ? StatusTone.success
                                      : StatusTone.neutral,
                                ),
                                StatusBadge(
                                  label: kos.type,
                                  tone: StatusTone.info,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(kos.title, style: AppTypography.headingSm),
                            const SizedBox(height: 2),
                            Text(
                              '${kos.city} • ${CurrencyFormatter.formatMonthly(kos.price)}',
                              style: AppTypography.bodySm,
                            ),
                            if (kos.availableRoomsCount != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                '${kos.availableRoomsCount} kamar tersedia',
                                style: AppTypography.caption,
                              ),
                            ],
                            const Divider(
                              height: 20,
                              color: AppColors.borderHairline,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => context.push(
                                      RoutePaths.ownerKosRooms(kos.slug),
                                    ),
                                    icon: const Icon(
                                      LucideIcons.bedDouble,
                                      size: 16,
                                    ),
                                    label: const Text('Kamar'),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: () => context.push(
                                      RoutePaths.ownerKosEdit(kos.slug),
                                    ),
                                    icon: const Icon(
                                      LucideIcons.pencil,
                                      size: 16,
                                    ),
                                    label: const Text('Edit'),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                IconButton(
                                  tooltip: 'Hapus Properti',
                                  onPressed: () => _confirmDelete(
                                    kos.slug,
                                    kos.title,
                                    query,
                                  ),
                                  icon: const Icon(
                                    LucideIcons.trash2,
                                    size: 18,
                                    color: AppColors.dangerText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Future<void> _confirmDelete(
    String slug,
    String title,
    OwnerKosQuery query,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Properti Kos?'),
        content: Text('Properti "$title" akan dinonaktifkan/dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Hapus', style: TextStyle(color: AppColors.dangerText)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    try {
      await ref.read(ownerRepositoryProvider).deleteKos(slug);
      ref.invalidate(ownerKosListProvider(query));
      ref.invalidate(ownerDashboardProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Properti kos berhasil dihapus.')),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }
}
