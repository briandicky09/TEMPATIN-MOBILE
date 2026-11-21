import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/status_mapper.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../data/owner_repository.dart';
import '../providers/owner_providers.dart';

/// Owner active/confirmed/completed tenants list.
class OwnerTenantsScreen extends ConsumerStatefulWidget {
  const OwnerTenantsScreen({super.key});

  @override
  ConsumerState<OwnerTenantsScreen> createState() => _OwnerTenantsScreenState();
}

class _OwnerTenantsScreenState extends ConsumerState<OwnerTenantsScreen> {
  String _status = 'active';

  @override
  Widget build(BuildContext context) {
    final tenantsAsync = ref.watch(ownerTenantsProvider(_status));

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Penghuni')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 4,
              ),
              children: [
                for (final item in const [
                  ('active', 'Aktif Dihuni'),
                  ('confirmed', 'Siap Check-In'),
                  ('completed', 'Selesai'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(item.$2),
                      selected: _status == item.$1,
                      onSelected: (_) => setState(() => _status = item.$1),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async =>
                  ref.invalidate(ownerTenantsProvider(_status)),
              child: tenantsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => AppErrorState(
                  message: err.toString(),
                  onRetry: () => ref.invalidate(ownerTenantsProvider(_status)),
                ),
                data: (res) {
                  if (res.items.isEmpty) {
                    return const AppEmptyState(
                      icon: LucideIcons.users,
                      title: 'Belum Ada Penghuni',
                      description: 'Tidak ada data penghuni pada kategori ini.',
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: res.items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final t = res.items[index];
                      final (label, tone) = StatusMapper.booking(t.status);
                      return TempatinCard(
                        onTap: () => context.push(
                          RoutePaths.ownerBookingDetail(t.bookingCode),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  t.tenantName,
                                  style: AppTypography.headingSm,
                                ),
                                StatusBadge(label: label, tone: tone),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${t.kos?.title ?? 'Kos'}${t.room != null ? ' • Kamar ${t.room!.roomNumber}' : ''}',
                              style: AppTypography.bodySm,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${t.tenantPhone} • ${t.startDate} s.d. ${t.endDate}',
                              style: AppTypography.caption,
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

/// Owner incoming survey schedule management.
class OwnerSurveysScreen extends ConsumerStatefulWidget {
  const OwnerSurveysScreen({super.key});

  @override
  ConsumerState<OwnerSurveysScreen> createState() => _OwnerSurveysScreenState();
}

class _OwnerSurveysScreenState extends ConsumerState<OwnerSurveysScreen> {
  String _status = 'all';

  Future<void> _updateStatus(
    SurveyModel s,
    String newStatus, {
    String? reason,
  }) async {
    try {
      await ref
          .read(ownerRepositoryProvider)
          .updateSurveyStatus(s.id, status: newStatus, rejectionReason: reason);
      ref.invalidate(ownerSurveysProvider(_status));
      ref.invalidate(ownerDashboardProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status survei berhasil diperbarui.')),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(ownerSurveysProvider(_status));

    return Scaffold(
      appBar: AppBar(title: const Text('Permintaan Survei')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 4,
              ),
              children: [
                for (final f in const [
                  ('all', 'Semua'),
                  ('pending', 'Menunggu'),
                  ('approved', 'Disetujui'),
                  ('completed', 'Selesai'),
                  ('rejected', 'Ditolak'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(f.$2),
                      selected: _status == f.$1,
                      onSelected: (_) => setState(() => _status = f.$1),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async =>
                  ref.invalidate(ownerSurveysProvider(_status)),
              child: async.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => AppErrorState(
                  message: err.toString(),
                  onRetry: () => ref.invalidate(ownerSurveysProvider(_status)),
                ),
                data: (res) {
                  if (res.items.isEmpty) {
                    return const AppEmptyState(
                      icon: LucideIcons.mapPin,
                      title: 'Belum Ada Jadwal Survei',
                      description:
                          'Pengajuan survei calon penyewa muncul di sini.',
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: res.items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final s = res.items[index];
                      final (label, tone) = StatusMapper.survey(s.status);
                      return TempatinCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  s.customer?.name ?? 'Calon Penyewa',
                                  style: AppTypography.headingSm,
                                ),
                                StatusBadge(label: label, tone: tone),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              s.kos?.title ?? 'Properti Kos',
                              style: AppTypography.bodySm,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${s.surveyDate} • ${s.surveyTime} WIB',
                              style: AppTypography.caption,
                            ),
                            if (s.notes != null && s.notes!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                'Catatan: ${s.notes}',
                                style: AppTypography.bodySm,
                              ),
                            ],
                            if (s.status == 'pending' ||
                                s.status == 'approved') ...[
                              const Divider(
                                height: 18,
                                color: AppColors.borderHairline,
                              ),
                              Row(
                                children: [
                                  if (s.status == 'pending') ...[
                                    Expanded(
                                      child: TempatinButton(
                                        label: 'Setujui',
                                        onPressed: () =>
                                            _updateStatus(s, 'approved'),
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Expanded(
                                      child: TempatinButton(
                                        label: 'Tolak',
                                        variant: TempatinButtonVariant.danger,
                                        onPressed: () =>
                                            _updateStatus(s, 'rejected'),
                                      ),
                                    ),
                                  ] else
                                    Expanded(
                                      child: TempatinButton(
                                        label: 'Tandai Survei Selesai',
                                        variant:
                                            TempatinButtonVariant.secondary,
                                        onPressed: () =>
                                            _updateStatus(s, 'completed'),
                                      ),
                                    ),
                                ],
                              ),
                            ],
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

/// Owner incoming room maintenance report triage screen.
class OwnerMaintenanceScreen extends ConsumerStatefulWidget {
  const OwnerMaintenanceScreen({super.key});

  @override
  ConsumerState<OwnerMaintenanceScreen> createState() =>
      _OwnerMaintenanceScreenState();
}

class _OwnerMaintenanceScreenState
    extends ConsumerState<OwnerMaintenanceScreen> {
  String _status = 'all';

  Future<void> _openUpdateSheet(MaintenanceReportModel report) async {
    final result = await AppBottomSheet.show<({String status, String notes})>(
      context: context,
      title: 'Tindak Lanjut Kerusakan',
      builder: (_) => _MaintenanceUpdateSheet(report: report),
    );
    if (result == null) return;

    try {
      await ref
          .read(ownerRepositoryProvider)
          .updateMaintenanceStatus(
            report.id,
            status: result.status,
            ownerNotes: result.notes,
          );
      ref.invalidate(ownerMaintenanceProvider(_status));
      ref.invalidate(ownerDashboardProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Status laporan kerusakan diperbarui.')),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(ownerMaintenanceProvider(_status));

    return Scaffold(
      appBar: AppBar(title: const Text('Laporan Kerusakan')),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: 4,
              ),
              children: [
                for (final f in const [
                  ('all', 'Semua'),
                  ('open', 'Dilaporkan'),
                  ('in_progress', 'Diproses'),
                  ('resolved', 'Selesai'),
                  ('rejected', 'Ditolak'),
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: ChoiceChip(
                      label: Text(f.$2),
                      selected: _status == f.$1,
                      onSelected: (_) => setState(() => _status = f.$1),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async =>
                  ref.invalidate(ownerMaintenanceProvider(_status)),
              child: async.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => AppErrorState(
                  message: err.toString(),
                  onRetry: () =>
                      ref.invalidate(ownerMaintenanceProvider(_status)),
                ),
                data: (res) {
                  if (res.items.isEmpty) {
                    return const AppEmptyState(
                      icon: LucideIcons.wrench,
                      title: 'Tidak Ada Laporan Kerusakan',
                      description:
                          'Laporan kendala fasilitas penghuni tampil di sini.',
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    itemCount: res.items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = res.items[index];
                      final (label, tone) = StatusMapper.maintenance(
                        item.status,
                      );
                      return TempatinCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: AppTypography.headingSm,
                                  ),
                                ),
                                StatusBadge(label: label, tone: tone),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${item.kos?.title ?? 'Kos'}${item.room != null ? ' • Kamar ${item.room!.roomNumber}' : ''} • ${item.customer?.name ?? 'Penghuni'}',
                              style: AppTypography.caption,
                            ),
                            const SizedBox(height: 6),
                            Text(item.description, style: AppTypography.bodySm),
                            if (item.ownerNotes != null &&
                                item.ownerNotes!.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                'Catatan Pemilik: ${item.ownerNotes}',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                            const SizedBox(height: AppSpacing.md),
                            TempatinButton(
                              label: 'Perbarui Status',
                              variant: TempatinButtonVariant.secondary,
                              onPressed: () => _openUpdateSheet(item),
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

class _MaintenanceUpdateSheet extends StatefulWidget {
  const _MaintenanceUpdateSheet({required this.report});

  final MaintenanceReportModel report;

  @override
  State<_MaintenanceUpdateSheet> createState() =>
      _MaintenanceUpdateSheetState();
}

class _MaintenanceUpdateSheetState extends State<_MaintenanceUpdateSheet> {
  late String _status;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _status = widget.report.status;
    _notesController = TextEditingController(
      text: widget.report.ownerNotes ?? '',
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final s in const [
              ('open', 'Dilaporkan'),
              ('in_progress', 'Diproses'),
              ('resolved', 'Selesai'),
              ('rejected', 'Ditolak'),
            ])
              ChoiceChip(
                label: Text(s.$2),
                selected: _status == s.$1,
                onSelected: (_) => setState(() => _status = s.$1),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        TempatinTextField(
          label: 'Catatan Penanganan (Opsional)',
          controller: _notesController,
          maxLines: 3,
        ),
        const SizedBox(height: AppSpacing.lg),
        TempatinButton(
          label: 'Simpan Pembaruan',
          onPressed: () => Navigator.pop(context, (
            status: _status,
            notes: _notesController.text.trim(),
          )),
        ),
      ],
    );
  }
}

/// Owner reviews dashboard + reply modal sheet.
class OwnerReviewsScreen extends ConsumerWidget {
  const OwnerReviewsScreen({super.key});

  Future<void> _replyReview(
    BuildContext context,
    WidgetRef ref,
    ReviewModel review,
  ) async {
    final text = await AppBottomSheet.show<String>(
      context: context,
      title: 'Balas Ulasan ${review.reviewerName}',
      builder: (_) => _ReplyReviewSheet(initialReply: review.reply),
    );
    if (text == null || text.isEmpty) return;

    try {
      await ref.read(ownerRepositoryProvider).replyReview(review.id, text);
      ref.invalidate(ownerReviewsProvider);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Balasan ulasan disimpan.')));
    } on AppException catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(ownerReviewsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ulasan Penghuni')),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async => ref.invalidate(ownerReviewsProvider),
        child: reviewsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => AppErrorState(
            message: err.toString(),
            onRetry: () => ref.invalidate(ownerReviewsProvider),
          ),
          data: (res) => ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              TempatinCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Rata-Rata Rating', style: AppTypography.caption),
                        Text(
                          '${res.summary.averageRating.toStringAsFixed(1)} ★',
                          style: AppTypography.headingLg,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Total Ulasan', style: AppTypography.caption),
                        Text(
                          '${res.summary.totalReviews}',
                          style: AppTypography.headingLg,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (res.items.isEmpty)
                const AppEmptyState(
                  icon: LucideIcons.star,
                  title: 'Belum Ada Ulasan',
                  description:
                      'Ulasan penghuni terverifikasi akan tampil di sini.',
                )
              else
                for (final rev in res.items)
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: TempatinCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                rev.reviewerName,
                                style: AppTypography.label,
                              ),
                              Text(
                                '${rev.rating} ★',
                                style: AppTypography.label,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(rev.comment, style: AppTypography.bodySm),
                          if (rev.reply != null && rev.reply!.isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: AppColors.canvas,
                                borderRadius: AppRadii.buttonRadius,
                              ),
                              child: Text(
                                'Balasan Anda: ${rev.reply}',
                                style: AppTypography.caption,
                              ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.sm),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => _replyReview(context, ref, rev),
                              icon: const Icon(LucideIcons.reply, size: 16),
                              label: Text(
                                (rev.reply?.isNotEmpty ?? false)
                                    ? 'Edit Balasan'
                                    : 'Balas Ulasan',
                              ),
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

class _ReplyReviewSheet extends StatefulWidget {
  const _ReplyReviewSheet({this.initialReply});

  final String? initialReply;

  @override
  State<_ReplyReviewSheet> createState() => _ReplyReviewSheetState();
}

class _ReplyReviewSheetState extends State<_ReplyReviewSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialReply ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TempatinTextField(
            label: 'Balasan Pemilik',
            controller: _controller,
            maxLines: 3,
            validator: (v) => AppValidators.requiredField(v, label: 'Balasan'),
          ),
          const SizedBox(height: AppSpacing.lg),
          TempatinButton(
            label: 'Kirim Balasan',
            onPressed: () {
              if (!(_formKey.currentState?.validate() ?? false)) return;
              Navigator.pop(context, _controller.text.trim());
            },
          ),
        ],
      ),
    );
  }
}
