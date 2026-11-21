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
import '../../../../core/utils/status_mapper.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/models/transaction_models.dart';
import '../../../../shared/widgets/pdf_viewer_screen.dart';
import '../../data/booking_repository.dart';
import '../providers/booking_providers.dart';

/// Customer booking detail enforcing Owner Approval First action gates.
class BookingDetailScreen extends ConsumerStatefulWidget {
  const BookingDetailScreen({super.key, required this.bookingCode});

  final String bookingCode;

  @override
  ConsumerState<BookingDetailScreen> createState() =>
      _BookingDetailScreenState();
}

class _BookingDetailScreenState extends ConsumerState<BookingDetailScreen> {
  bool _isCancelling = false;

  Future<void> _cancelBooking() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Batalkan Pengajuan?'),
        content: const Text(
          'Pengajuan sewa dan tagihan terkait akan dibatalkan secara permanen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Kembali'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
    if (confirm != true) return;

    setState(() => _isCancelling = true);
    try {
      await ref
          .read(bookingRepositoryProvider)
          .cancelBooking(widget.bookingCode);
      ref.invalidate(bookingDetailProvider(widget.bookingCode));
      ref.invalidate(myBookingsProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengajuan booking dibatalkan.')),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isCancelling = false);
    }
  }

  void _openNotaPdf() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => PdfViewerScreen(
          title: 'Nota Pembayaran',
          fileName: 'Nota-${widget.bookingCode}.pdf',
          loadBytes: () => ref
              .read(bookingRepositoryProvider)
              .downloadNotaPdfBytes(widget.bookingCode),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingAsync = ref.watch(bookingDetailProvider(widget.bookingCode));

    return Scaffold(
      appBar: AppBar(title: Text(widget.bookingCode)),
      body: bookingAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => AppErrorState(
          message: err.toString(),
          onRetry: () =>
              ref.invalidate(bookingDetailProvider(widget.bookingCode)),
        ),
        data: (booking) => RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async =>
              ref.invalidate(bookingDetailProvider(widget.bookingCode)),
          child: _buildBody(context, booking),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, BookingModel booking) {
    final (label, tone) = StatusMapper.booking(booking.status);
    final isPaid = booking.invoice?.status == 'paid';

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
                  StatusBadge(label: label, tone: tone),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                booking.kos?.title ?? 'Properti Kos',
                style: AppTypography.headingMd,
              ),
              if (booking.kos?.city != null) ...[
                const SizedBox(height: 2),
                Text(booking.kos!.city, style: AppTypography.bodySm),
              ],
              if (booking.room != null) ...[
                const SizedBox(height: AppSpacing.sm),
                StatusBadge(
                  label: 'Kamar ${booking.room!.roomNumber}',
                  tone: StatusTone.info,
                  icon: LucideIcons.doorOpen,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        if (booking.status == 'pending') ...[
          _NoticeBox(
            bg: AppColors.warningBg,
            fg: AppColors.warningText,
            icon: LucideIcons.clock,
            text: 'Booking Anda sedang ditinjau oleh pemilik kos. Tombol pembayaran akan terbuka setelah disetujui.',
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        if (booking.status == 'rejected' &&
            booking.rejectionReason != null) ...[
          _NoticeBox(
            bg: AppColors.dangerBg,
            fg: AppColors.dangerText,
            icon: LucideIcons.circleX,
            text: 'Alasan penolakan: ${booking.rejectionReason}',
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        TempatinCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Detail Masa Sewa', style: AppTypography.headingSm),
              const SizedBox(height: AppSpacing.md),
              _DetailRow('Penyewa', booking.tenantName),
              _DetailRow('No. HP', booking.tenantPhone),
              _DetailRow('Mulai Huni', booking.startDate),
              _DetailRow('Berakhir', booking.endDate),
              _DetailRow('Durasi', '${booking.durationMonths} Bulan'),
              if (booking.notes != null && booking.notes!.isNotEmpty)
                _DetailRow('Catatan', booking.notes!),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        TempatinCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rincian Tagihan', style: AppTypography.headingSm),
              const SizedBox(height: AppSpacing.md),
              _DetailRow(
                'Subtotal Sewa',
                CurrencyFormatter.formatIdr(booking.subtotal),
              ),
              _DetailRow(
                'Biaya Admin',
                CurrencyFormatter.formatIdr(booking.adminFee),
              ),
              const Divider(height: 16, color: AppColors.borderHairline),
              _DetailRow(
                'Total Tagihan',
                CurrencyFormatter.formatIdr(booking.totalAmount),
                highlight: true,
              ),
              if (booking.invoice != null) ...[
                const SizedBox(height: AppSpacing.sm),
                _DetailRow('No. Invoice', booking.invoice!.invoiceNumber),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Contextual Actions (Owner Approval First)
        if (booking.status == 'approved')
          TempatinButton(
            label: 'Bayar Sekarang (Midtrans)',
            icon: LucideIcons.creditCard,
            onPressed: () => context.push(
              RoutePaths.bookingPay(booking.bookingCode),
              extra: booking,
            ),
          ),

        if (booking.status == 'pending')
          TempatinButton(
            label: 'Batalkan Pengajuan',
            variant: TempatinButtonVariant.danger,
            icon: LucideIcons.x,
            isLoading: _isCancelling,
            onPressed: _cancelBooking,
          ),

        if (isPaid) ...[
          TempatinButton(
            label: 'Lihat & Unduh Nota PDF',
            variant: TempatinButtonVariant.secondary,
            icon: LucideIcons.fileText,
            onPressed: _openNotaPdf,
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        if (booking.status == 'confirmed' ||
            booking.status == 'active' ||
            booking.status == 'completed') ...[
          TempatinButton(
            label: 'Kontrak Sewa Digital',
            icon: LucideIcons.fileSignature,
            onPressed: () =>
                context.push(RoutePaths.bookingContract(booking.bookingCode)),
          ),
          if (booking.status == 'confirmed' || booking.status == 'active') ...[
            const SizedBox(height: AppSpacing.md),
            TempatinButton(
              label: 'Laporkan Kerusakan Kamar',
              variant: TempatinButtonVariant.outlined,
              icon: LucideIcons.wrench,
              onPressed: () =>
                  context.push(RoutePaths.createMaintenance, extra: booking),
            ),
          ],
        ],
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value, {this.highlight = false});

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTypography.bodySm),
          const SizedBox(width: AppSpacing.md),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: highlight
                  ? AppTypography.headingSm.copyWith(color: AppColors.primary)
                  : AppTypography.label,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoticeBox extends StatelessWidget {
  const _NoticeBox({
    required this.bg,
    required this.fg,
    required this.icon,
    required this.text,
  });

  final Color bg;
  final Color fg;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadii.buttonRadius,
        border: Border.all(color: AppColors.borderHairline),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(text, style: AppTypography.bodySm.copyWith(color: fg)),
          ),
        ],
      ),
    );
  }
}
