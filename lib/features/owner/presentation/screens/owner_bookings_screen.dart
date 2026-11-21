import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/status_mapper.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../providers/owner_providers.dart';

/// Owner incoming bookings list enforcing Owner Approval First workflow.
class OwnerBookingsScreen extends ConsumerStatefulWidget {
  const OwnerBookingsScreen({super.key});

  @override
  ConsumerState<OwnerBookingsScreen> createState() =>
      _OwnerBookingsScreenState();
}

class _OwnerBookingsScreenState extends ConsumerState<OwnerBookingsScreen> {
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
    final bookingsAsync = ref.watch(ownerBookingsProvider(query));
    final counts = bookingsAsync.value?.counts;

    return Scaffold(
      appBar: AppBar(title: const Text('Kelola Booking Masuk')),
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
                hintText: 'Cari kode booking, penyewa, atau nama kos...',
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
                for (final chip in [
                  ('all', 'Semua', counts?.all),
                  ('pending', 'Menunggu', counts?.pending),
                  ('approved', 'Disetujui', counts?.approved),
                  ('confirmed', 'Lunas', counts?.confirmed),
                  ('active', 'Aktif', counts?.active),
                  ('rejected', 'Ditolak', counts?.rejected),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(
                        chip.$3 != null ? '${chip.$2} (${chip.$3})' : chip.$2,
                      ),
                      selected: _statusFilter == chip.$1,
                      onSelected: (_) =>
                          setState(() => _statusFilter = chip.$1),
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
                  ref.invalidate(ownerBookingsProvider(query)),
              child: bookingsAsync.when(
                loading: () => ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: 4,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, _) => const KosListCardSkeleton(),
                ),
                error: (err, _) => AppErrorState(
                  message: err.toString(),
                  onRetry: () => ref.invalidate(ownerBookingsProvider(query)),
                ),
                data: (res) {
                  if (res.items.isEmpty) {
                    return ListView(
                      children: const [
                        SizedBox(height: 48),
                        AppEmptyState(
                          icon: LucideIcons.clipboardList,
                          title: 'Tidak Ada Pengajuan Booking',
                          description: 'Pengajuan sewa baru dari calon penyewa akan tampil di sini.',
                        ),
                      ],
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: res.items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final b = res.items[index];
                      final (statusLabel, tone) = StatusMapper.booking(
                        b.status,
                      );

                      return TempatinCard(
                        onTap: () => context.push(
                          RoutePaths.ownerBookingDetail(b.bookingCode),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  b.bookingCode,
                                  style: AppTypography.caption,
                                ),
                                StatusBadge(label: statusLabel, tone: tone),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(b.tenantName, style: AppTypography.headingSm),
                            const SizedBox(height: 2),
                            Text(
                              '${b.kos?.title ?? 'Kos'} • ${b.durationMonths} bulan',
                              style: AppTypography.bodySm,
                            ),
                            if (b.room != null) ...[
                              const SizedBox(height: 2),
                              Text(
                                'Kamar ${b.room!.roomNumber}',
                                style: AppTypography.caption,
                              ),
                            ],
                            const SizedBox(height: AppSpacing.sm),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  CurrencyFormatter.formatIdr(b.totalAmount),
                                  style: AppTypography.label.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      b.status == 'pending'
                                          ? 'Tinjau Sekarang'
                                          : 'Detail',
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    const Icon(
                                      LucideIcons.chevronRight,
                                      size: 14,
                                      color: AppColors.primary,
                                    ),
                                  ],
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
}
