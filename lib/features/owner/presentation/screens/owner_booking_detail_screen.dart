import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/status_mapper.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../core/widgets/tempatin_text_field.dart';
import '../../../../shared/models/owner_models.dart';
import '../../data/owner_repository.dart';
import '../providers/owner_providers.dart';

/// Owner booking detail for Approve (with Room assignment), Reject, Check-in, and Check-out.
class OwnerBookingDetailScreen extends ConsumerStatefulWidget {
  const OwnerBookingDetailScreen({super.key, required this.bookingCode});

  final String bookingCode;

  @override
  ConsumerState<OwnerBookingDetailScreen> createState() =>
      _OwnerBookingDetailScreenState();
}

class _OwnerBookingDetailScreenState
    extends ConsumerState<OwnerBookingDetailScreen> {
  int? _selectedRoomId;
  bool _initializedRoom = false;
  bool _isActing = false;

  void _invalidateAll() {
    ref.invalidate(ownerBookingDetailProvider(widget.bookingCode));
    ref.invalidate(ownerBookingsProvider);
    ref.invalidate(ownerDashboardProvider);
    ref.invalidate(ownerTenantsProvider);
  }

  Future<void> _approve() async {
    setState(() => _isActing = true);
    try {
      await ref
          .read(ownerRepositoryProvider)
          .approveBooking(widget.bookingCode, roomId: _selectedRoomId);
      _invalidateAll();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Booking disetujui. Menunggu pembayaran Midtrans oleh penyewa.',
          ),
        ),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _reject() async {
    final reason = await AppBottomSheet.show<String>(
      context: context,
      title: 'Tolak Pengajuan Booking',
      builder: (_) => const _RejectReasonSheet(),
    );
    if (reason == null || reason.isEmpty) return;

    setState(() => _isActing = true);
    try {
      await ref
          .read(ownerRepositoryProvider)
          .rejectBooking(widget.bookingCode, reason);
      _invalidateAll();
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Booking telah ditolak.')));
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _checkIn() async {
    setState(() => _isActing = true);
    try {
      await ref
          .read(ownerRepositoryProvider)
          .checkInBooking(widget.bookingCode);
      _invalidateAll();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Check-in berhasil diproses. Kamar kini berstatus Terisi.',
          ),
        ),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  Future<void> _checkOut() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Proses Check-Out?'),
        content: const Text(
          'Masa sewa akan ditandai selesai dan kamar kembali tersedia.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Check-Out'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _isActing = true);
    try {
      await ref
          .read(ownerRepositoryProvider)
          .checkOutBooking(widget.bookingCode);
      _invalidateAll();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Check-out selesai. Kamar kembali tersedia.'),
        ),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isActing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(
      ownerBookingDetailProvider(widget.bookingCode),
    );

    return Scaffold(
      appBar: AppBar(title: Text(widget.bookingCode)),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => AppErrorState(
          message: err.toString(),
          onRetry: () =>
              ref.invalidate(ownerBookingDetailProvider(widget.bookingCode)),
        ),
        data: (detail) {
          if (!_initializedRoom) {
            _initializedRoom = true;
            _selectedRoomId =
                detail.booking.room?.id ??
                (detail.availableRooms.isNotEmpty
                    ? detail.availableRooms.first.id
                    : null);
          }
          return _buildBody(detail);
        },
      ),
    );
  }

  Widget _buildBody(OwnerBookingDetailData detail) {
    final booking = detail.booking;
    final (statusLabel, tone) = StatusMapper.booking(booking.status);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        TempatinCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(booking.bookingCode, style: AppTypography.caption),
                  StatusBadge(label: statusLabel, tone: tone),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                booking.kos?.title ?? 'Properti Kos',
                style: AppTypography.headingMd,
              ),
              const SizedBox(height: 4),
              Text(
                '${booking.startDate} s.d. ${booking.endDate} (${booking.durationMonths} bln)',
                style: AppTypography.bodySm,
              ),
              if (booking.room != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Kamar Dialokasikan: Kamar ${booking.room!.roomNumber}',
                  style: AppTypography.label.copyWith(color: AppColors.primary),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        TempatinCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Informasi Penyewa', style: AppTypography.headingSm),
              const SizedBox(height: AppSpacing.sm),
              _InfoRow(label: 'Nama', value: booking.tenantName),
              _InfoRow(label: 'HP / WA', value: booking.tenantPhone),
              _InfoRow(label: 'Email', value: booking.tenantEmail),
              if (booking.notes != null && booking.notes!.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text('Catatan: ${booking.notes}', style: AppTypography.bodySm),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        TempatinCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ringkasan Tagihan', style: AppTypography.headingSm),
              const SizedBox(height: AppSpacing.sm),
              _InfoRow(
                label: 'Subtotal Sewa',
                value: CurrencyFormatter.formatIdr(booking.subtotal),
              ),
              _InfoRow(
                label: 'Biaya Admin',
                value: CurrencyFormatter.formatIdr(booking.adminFee),
              ),
              const Divider(height: 18, color: AppColors.borderHairline),
              _InfoRow(
                label: 'Total',
                value: CurrencyFormatter.formatIdr(booking.totalAmount),
                highlight: true,
              ),
              if (booking.invoice != null) ...[
                const SizedBox(height: 6),
                Text(
                  'Invoice: ${booking.invoice!.invoiceNumber} (${StatusMapper.invoice(booking.invoice!.status).$1})',
                  style: AppTypography.caption,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        if (booking.status == 'pending') ...[
          TempatinCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alokasi Kamar (Opsional / Pilih Kamar Tersedia)',
                  style: AppTypography.headingSm,
                ),
                const SizedBox(height: AppSpacing.sm),
                if (detail.availableRooms.isEmpty)
                  Text(
                    'Belum ada unit kamar individual tersedia. Persetujuan tetap dapat diproses di level properti.',
                    style: AppTypography.bodySm,
                  )
                else
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: [
                      for (final r in detail.availableRooms)
                        ChoiceChip(
                          label: Text(
                            'Kamar ${r.roomNumber} (${CurrencyFormatter.formatIdr(r.effectivePrice)})',
                          ),
                          selected: _selectedRoomId == r.id,
                          onSelected: (_) =>
                              setState(() => _selectedRoomId = r.id),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          TempatinButton(
            label: 'Setujui Pengajuan Sewa',
            icon: LucideIcons.circleCheck,
            isLoading: _isActing,
            onPressed: _approve,
          ),
          const SizedBox(height: AppSpacing.sm),
          TempatinButton(
            label: 'Tolak Pengajuan',
            variant: TempatinButtonVariant.danger,
            icon: LucideIcons.x,
            isLoading: _isActing,
            onPressed: _reject,
          ),
        ],

        if (booking.status == 'approved')
          TempatinCard(
            backgroundColor: AppColors.infoBg,
            child: Text(
              'Booking sudah disetujui dan menunggu pelunasan Midtrans oleh penyewa.',
              style: AppTypography.bodySm,
            ),
          ),

        if (booking.status == 'confirmed')
          TempatinButton(
            label: 'Proses Check-In Penghuni',
            icon: LucideIcons.keyRound,
            isLoading: _isActing,
            onPressed: _checkIn,
          ),

        if (booking.status == 'active')
          TempatinButton(
            label: 'Proses Check-Out (Selesai Sewa)',
            variant: TempatinButtonVariant.secondary,
            icon: LucideIcons.doorOpen,
            isLoading: _isActing,
            onPressed: _checkOut,
          ),

        if (booking.rejectionReason != null &&
            booking.rejectionReason!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          TempatinCard(
            backgroundColor: AppColors.dangerBg,
            child: Text(
              'Alasan Penolakan: ${booking.rejectionReason}',
              style: AppTypography.bodySm.copyWith(color: AppColors.dangerText),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySm),
          Text(
            value,
            style: highlight
                ? AppTypography.headingSm.copyWith(color: AppColors.primary)
                : AppTypography.label,
          ),
        ],
      ),
    );
  }
}

class _RejectReasonSheet extends StatefulWidget {
  const _RejectReasonSheet();

  @override
  State<_RejectReasonSheet> createState() => _RejectReasonSheetState();
}

class _RejectReasonSheetState extends State<_RejectReasonSheet> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

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
            label: 'Alasan Penolakan',
            controller: _controller,
            maxLines: 3,
            hintText: 'Contoh: Kamar tipe ini sudah penuh pada tanggal masuk.',
            validator: (v) =>
                AppValidators.requiredField(v, label: 'Alasan penolakan'),
          ),
          const SizedBox(height: AppSpacing.lg),
          TempatinButton(
            label: 'Konfirmasi Tolak Booking',
            variant: TempatinButtonVariant.danger,
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
