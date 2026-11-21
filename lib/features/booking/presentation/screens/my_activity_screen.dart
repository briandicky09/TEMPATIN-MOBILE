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
import '../../../../core/widgets/skeletons.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/widgets/guest_auth_prompt.dart';
import '../../../../shared/widgets/pdf_viewer_screen.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../../invoice/presentation/providers/invoice_providers.dart';
import '../../../maintenance/presentation/providers/maintenance_providers.dart';
import '../../../survey/presentation/providers/survey_providers.dart';
import '../../data/booking_repository.dart';
import '../providers/booking_providers.dart';

/// Tab 4 Customer Activity Hub uniting Bookings, Invoices, Surveys, and Maintenance Reports.
class MyActivityScreen extends ConsumerWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authSessionProvider);
    if (!auth.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: const Text('Aktivitas Sewa')),
        body: const GuestAuthPrompt(
          icon: LucideIcons.calendarCheck,
          title: 'Kelola Booking & Tagihan Anda',
          description: 'Masuk untuk memantau pengajuan sewa, pembayaran Midtrans, kontrak digital, survei, dan laporan kerusakan.',
        ),
      );
    }

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aktivitas Sewa'),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.inkSecondary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Booking'),
              Tab(text: 'Invoice'),
              Tab(text: 'Survei'),
              Tab(text: 'Kerusakan'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _BookingsTab(),
            _InvoicesTab(),
            _SurveysTab(),
            _MaintenanceTab(),
          ],
        ),
      ),
    );
  }
}

class _BookingsTab extends ConsumerWidget {
  const _BookingsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(myBookingsProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.read(myBookingsProvider.notifier).refresh(),
      child: bookingsAsync.when(
        loading: () => ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: 4,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (_, _) => const SkeletonBox(height: 112),
        ),
        error: (err, _) => ListView(
          children: [
            const SizedBox(height: 48),
            AppErrorState(
              message: err.toString(),
              onRetry: () => ref.read(myBookingsProvider.notifier).refresh(),
            ),
          ],
        ),
        data: (paginated) {
          if (paginated.items.isEmpty) {
            return ListView(
              children: [
                const SizedBox(height: 48),
                AppEmptyState(
                  icon: LucideIcons.calendarCheck,
                  title: 'Belum Ada Pengajuan Sewa',
                  description: 'Cari kos favorit Anda lalu tekan Ajukan Sewa untuk memulai.',
                  actionLabel: 'Eksplor Kos',
                  onAction: () => context.go(RoutePaths.explore),
                ),
              ],
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: paginated.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final b = paginated.items[index];
              final (label, tone) = StatusMapper.booking(b.status);

              return TempatinCard(
                onTap: () =>
                    context.push(RoutePaths.bookingDetail(b.bookingCode)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(b.bookingCode, style: AppTypography.caption),
                        StatusBadge(label: label, tone: tone),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      b.kos?.title ?? 'Properti Kos',
                      style: AppTypography.headingSm,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${b.startDate} • ${b.durationMonths} Bulan',
                      style: AppTypography.bodySm,
                    ),
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
                        if (b.status == 'approved')
                          const StatusBadge(
                            label: 'Bayar Sekarang →',
                            tone: StatusTone.info,
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
    );
  }
}

class _InvoicesTab extends ConsumerWidget {
  const _InvoicesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(myInvoicesProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.read(myInvoicesProvider.notifier).refresh(),
      child: invoicesAsync.when(
        loading: () => ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: 4,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (_, _) => const SkeletonBox(height: 100),
        ),
        error: (err, _) => ListView(
          children: [
            const SizedBox(height: 48),
            AppErrorState(
              message: err.toString(),
              onRetry: () => ref.read(myInvoicesProvider.notifier).refresh(),
            ),
          ],
        ),
        data: (paginated) {
          if (paginated.items.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 48),
                AppEmptyState(
                  icon: LucideIcons.receipt,
                  title: 'Belum Ada Invoice',
                  description: 'Tagihan sewa Anda akan muncul di sini.',
                ),
              ],
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: paginated.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final inv = paginated.items[index];
              final (label, tone) = StatusMapper.invoice(inv.status);

              return TempatinCard(
                onTap: inv.bookingCode != null
                    ? () => context.push(
                        RoutePaths.bookingDetail(inv.bookingCode!),
                      )
                    : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(inv.invoiceNumber, style: AppTypography.caption),
                        StatusBadge(label: label, tone: tone),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      inv.kosTitle ?? inv.bookingCode ?? 'Tagihan Sewa',
                      style: AppTypography.headingSm,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          CurrencyFormatter.formatIdr(inv.totalAmount),
                          style: AppTypography.label.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (inv.status == 'paid' && inv.bookingCode != null)
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => PdfViewerScreen(
                                    title: 'Nota Pembayaran',
                                    fileName: 'Nota-${inv.bookingCode}.pdf',
                                    loadBytes: () => ref
                                        .read(bookingRepositoryProvider)
                                        .downloadNotaPdfBytes(inv.bookingCode!),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(LucideIcons.fileText, size: 16),
                            label: const Text('Nota PDF'),
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
    );
  }
}

class _SurveysTab extends ConsumerWidget {
  const _SurveysTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surveysAsync = ref.watch(mySurveysProvider);

    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () => ref.read(mySurveysProvider.notifier).refresh(),
      child: surveysAsync.when(
        loading: () => ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: 4,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (_, _) => const SkeletonBox(height: 96),
        ),
        error: (err, _) => ListView(
          children: [
            const SizedBox(height: 48),
            AppErrorState(
              message: err.toString(),
              onRetry: () => ref.read(mySurveysProvider.notifier).refresh(),
            ),
          ],
        ),
        data: (paginated) {
          if (paginated.items.isEmpty) {
            return ListView(
              children: const [
                SizedBox(height: 48),
                AppEmptyState(
                  icon: LucideIcons.mapPin,
                  title: 'Belum Ada Jadwal Survei',
                  description: 'Ajukan kunjungan lokasi langsung dari halaman detail kos.',
                ),
              ],
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: paginated.items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final s = paginated.items[index];
              final (label, tone) = StatusMapper.survey(s.status);

              return TempatinCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${s.surveyDate} • ${s.surveyTime}',
                          style: AppTypography.caption,
                        ),
                        StatusBadge(label: label, tone: tone),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      s.kos?.title ?? 'Properti Kos',
                      style: AppTypography.headingSm,
                    ),
                    if (s.rejectionReason != null &&
                        s.rejectionReason!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Alasan: ${s.rejectionReason}',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.dangerText,
                        ),
                      ),
                    ],
                    if (s.status == 'pending') ...[
                      const SizedBox(height: AppSpacing.sm),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            try {
                              await ref
                                  .read(mySurveysProvider.notifier)
                                  .cancel(s.id);
                            } on AppException catch (e) {
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)),
                              );
                            }
                          },
                          child: Text(
                            'Batalkan Survei',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.dangerText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _MaintenanceTab extends ConsumerWidget {
  const _MaintenanceTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maintAsync = ref.watch(myMaintenanceProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        onPressed: () => context.push(RoutePaths.createMaintenance),
        icon: const Icon(LucideIcons.plus, size: 18),
        label: const Text('Lapor Kendala'),
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () => ref.read(myMaintenanceProvider.notifier).refresh(),
        child: maintAsync.when(
          loading: () => ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (_, _) => const SkeletonBox(height: 96),
          ),
          error: (err, _) => ListView(
            children: [
              const SizedBox(height: 48),
              AppErrorState(
                message: err.toString(),
                onRetry: () =>
                    ref.read(myMaintenanceProvider.notifier).refresh(),
              ),
            ],
          ),
          data: (paginated) {
            if (paginated.items.isEmpty) {
              return ListView(
                children: [
                  const SizedBox(height: 48),
                  AppEmptyState(
                    icon: LucideIcons.wrench,
                    title: 'Belum Ada Laporan Kerusakan',
                    description: 'Laporkan kendala kamar Anda agar segera ditangani pemilik kos.',
                    actionLabel: 'Buat Laporan',
                    onAction: () => context.push(RoutePaths.createMaintenance),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                84,
              ),
              itemCount: paginated.items.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final m = paginated.items[index];
                final (label, tone) = StatusMapper.maintenance(m.status);

                return TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            m.bookingCode ?? m.kos?.title ?? '',
                            style: AppTypography.caption,
                          ),
                          StatusBadge(label: label, tone: tone),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(m.title, style: AppTypography.headingSm),
                      const SizedBox(height: 4),
                      Text(m.description, style: AppTypography.bodySm),
                      if (m.ownerNotes != null && m.ownerNotes!.isNotEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: AppColors.canvas,
                            borderRadius: AppRadii.buttonRadius,
                          ),
                          child: Text(
                            'Catatan Pemilik: ${m.ownerNotes}',
                            style: AppTypography.caption,
                          ),
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
    );
  }
}
