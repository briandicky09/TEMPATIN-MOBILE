import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/router/routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/kos_card.dart';
import '../../../shared/widgets/local_image.dart';
import '../../../shared/widgets/tempatin_widgets.dart';

class MyActivityScreen extends ConsumerWidget {
  const MyActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    if (session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Booking & Invoice')),
        body: EmptyStateView(
          icon: LucideIcons.calendarCheck,
          title: 'Masuk untuk Melihat Transaksi',
          description: 'Login menggunakan akun lokal atau akun demo untuk mengelola booking dan invoice.',
          actionLabel: 'Masuk Sekarang',
          onAction: () => context.push(AppRoutes.login),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Aktivitas Sewa'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Booking Saya'),
              Tab(text: 'Invoice'),
            ],
          ),
        ),
        body: const TabBarView(children: [_BookingsTab(), _InvoicesTab()]),
      ),
    );
  }
}

class _BookingsTab extends ConsumerWidget {
  const _BookingsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(memberBookingsProvider);
    final session = ref.watch(sessionProvider);

    return bookingsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (items) {
        if (items.isEmpty) {
          return EmptyStateView(
            icon: LucideIcons.calendarCheck,
            title: 'Belum Ada Pengajuan Sewa',
            description: 'Pilih kos favorit Anda dan ajukan sewa kapan saja.',
            actionLabel: 'Eksplor Kos',
            onAction: () => context.go(AppRoutes.explore),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final row = items[index];
            final b = row.booking;
            final (label, tone) = StatusHelper.booking(b.status);

            return TempatinCard(
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
                  Row(
                    children: [
                      LocalImage(
                        path: row.kosThumbnail,
                        width: 56,
                        height: 56,
                        borderRadius: AppRadii.button,
                        cacheWidth: 180,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(row.kosTitle, style: AppTypography.headingSm),
                            Text(
                              '${DateFormatter.formatStringDate(b.startDate)} • ${b.durationMonths} bln',
                              style: AppTypography.caption,
                            ),
                            Text(
                              CurrencyFormatter.idr(b.totalAmount),
                              style: AppTypography.label.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (b.rejectionReason != null &&
                      b.rejectionReason!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Alasan Ditolak: ${b.rejectionReason}',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.dangerText,
                      ),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      if (row.invoice != null)
                        Expanded(
                          child: TempatinButton(
                            label: b.status == 'approved'
                                ? 'Bayar Demo'
                                : 'Lihat Invoice',
                            variant: b.status == 'approved'
                                ? ButtonVariant.primary
                                : ButtonVariant.secondary,
                            onPressed: () => context.push(
                              AppRoutes.invoiceDetail(row.invoice!.id),
                            ),
                          ),
                        ),
                      if (b.status == 'pending' && session != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: TempatinButton(
                            label: 'Batalkan',
                            variant: ButtonVariant.danger,
                            onPressed: () async {
                              await ref
                                  .read(bookingRepositoryProvider)
                                  .cancelBooking(b.id, session.user.id);
                              ref.invalidate(memberBookingsProvider);
                              ref.invalidate(memberInvoicesProvider);
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _InvoicesTab extends ConsumerWidget {
  const _InvoicesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.watch(memberInvoicesProvider);

    return invoicesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (items) {
        if (items.isEmpty) {
          return const EmptyStateView(
            icon: LucideIcons.receiptText,
            title: 'Belum Ada Invoice',
            description:
                'Invoice otomatis dibuat setelah Anda mengajukan sewa.',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.lg),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final item = items[index];
            final inv = item.invoice;
            final (label, tone) = StatusHelper.invoice(inv.status);

            return TempatinCard(
              onTap: () => context.push(AppRoutes.invoiceDetail(inv.id)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(inv.invoiceNumber, style: AppTypography.label),
                      StatusBadge(label: label, tone: tone),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(item.kosTitle, style: AppTypography.headingSm),
                  Text(
                    'Kode Booking: ${item.bookingCode}',
                    style: AppTypography.caption,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    CurrencyFormatter.idr(inv.totalAmount),
                    style: AppTypography.headingSm.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class InvoiceDetailScreen extends ConsumerStatefulWidget {
  const InvoiceDetailScreen({super.key, required this.invoiceId});

  final int invoiceId;

  @override
  ConsumerState<InvoiceDetailScreen> createState() =>
      _InvoiceDetailScreenState();
}

class _InvoiceDetailScreenState extends ConsumerState<InvoiceDetailScreen> {
  String _selectedMethod = 'Simulasi Transfer BCA (Offline)';
  bool _paying = false;

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(invoiceDetailProvider(widget.invoiceId));
    final session = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Invoice')),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (detail) {
          if (detail == null) {
            return const Center(child: Text('Invoice tidak ditemukan.'));
          }
          final inv = detail.invoice;
          final (label, tone) = StatusHelper.invoice(inv.status);

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
                        Image.asset('assets/images/logo.png', height: 24),
                        StatusBadge(label: label, tone: tone),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(inv.invoiceNumber, style: AppTypography.headingLg),
                    Text(
                      'Booking: ${detail.bookingCode}',
                      style: AppTypography.caption,
                    ),
                    const Divider(height: 24, color: AppColors.borderHairline),
                    _InvRow('Properti', detail.kosTitle),
                    _InvRow('Penyewa', detail.tenantName),
                    _InvRow(
                      'Periode',
                      '${DateFormatter.formatStringDate(detail.startDate)} - ${DateFormatter.formatStringDate(detail.endDate)} (${detail.durationMonths} bln)',
                    ),
                    _InvRow(
                      'Jatuh Tempo',
                      DateFormatter.formatStringDate(inv.dueDate),
                    ),
                    const Divider(height: 24, color: AppColors.borderHairline),
                    _InvRow('Biaya Sewa', CurrencyFormatter.idr(inv.amount)),
                    _InvRow('Biaya Admin', CurrencyFormatter.idr(inv.adminFee)),
                    const Divider(height: 24, color: AppColors.borderHairline),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: AppTypography.headingSm),
                        Text(
                          CurrencyFormatter.idr(inv.totalAmount),
                          style: AppTypography.headingLg.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    if (inv.status == 'paid') ...[
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.successBg,
                          borderRadius: AppRadii.button,
                        ),
                        child: Text(
                          'Lunas via ${inv.paymentMethod ?? 'Simulasi Lokal'}${inv.paidAt != null ? ' • ${DateFormatter.dateTime(inv.paidAt!)}' : ''}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.successText,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (inv.status == 'unpaid' && session != null) ...[
                const SizedBox(height: AppSpacing.lg),
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Simulasi Pembayaran Demo (Offline)',
                        style: AppTypography.headingSm,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: [
                          for (final m in const [
                            'Simulasi Transfer BCA (Offline)',
                            'Simulasi QRIS (Offline)',
                            'Tunai di Tempat',
                          ])
                            ChoiceChip(
                              label: Text(m),
                              selected: _selectedMethod == m,
                              onSelected: (_) =>
                                  setState(() => _selectedMethod = m),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TempatinButton(
                        label: 'Tandai Lunas (Simulasi Demo)',
                        icon: LucideIcons.check,
                        isLoading: _paying,
                        onPressed: () async {
                          setState(() => _paying = true);
                          await ref
                              .read(bookingRepositoryProvider)
                              .payDemoInvoice(
                                inv.id,
                                session.user.id,
                                _selectedMethod,
                              );
                          ref.invalidate(
                            invoiceDetailProvider(widget.invoiceId),
                          );
                          ref.invalidate(memberInvoicesProvider);
                          ref.invalidate(memberBookingsProvider);
                          ref.invalidate(notificationsProvider);
                          ref.invalidate(unreadNotificationCountProvider);
                          if (!context.mounted) return;
                          setState(() => _paying = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Pembayaran demo berhasil! Booking terkonfirmasi.',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _InvRow extends StatelessWidget {
  const _InvRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: AppTypography.caption),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTypography.label,
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    if (session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Kos Favorit')),
        body: EmptyStateView(
          icon: Icons.favorite_border,
          title: 'Masuk untuk Menyimpan Favorit',
          description: 'Simpan kos incaran Anda di database lokal.',
          actionLabel: 'Masuk Sekarang',
          onAction: () => context.push(AppRoutes.login),
        ),
      );
    }

    final favAsync = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Kos Favorit')),
      body: favAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty) {
            return EmptyStateView(
              icon: Icons.favorite_border,
              title: 'Belum Ada Favorit',
              description: 'Ketuk ikon hati pada kartu kos untuk menyimpan.',
              actionLabel: 'Cari Kos',
              onAction: () => context.go(AppRoutes.explore),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (context, index) {
              final item = items[index];
              return KosCard(
                item: item,
                compact: true,
                onTap: () => context.push(AppRoutes.kosDetail(item.kos.id)),
                onToggleFavorite: () async {
                  await ref
                      .read(engagementRepositoryProvider)
                      .toggleFavorite(session.user.id, item.kos.id);
                  ref.invalidate(favoritesProvider);
                  ref.invalidate(featuredKosProvider);
                  ref.invalidate(latestKosProvider);
                  ref.invalidate(exploreKosProvider);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final notifsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        actions: [
          if (session != null)
            TextButton(
              onPressed: () async {
                await ref
                    .read(engagementRepositoryProvider)
                    .markAllAsRead(session.user.id);
                ref.invalidate(notificationsProvider);
                ref.invalidate(unreadNotificationCountProvider);
              },
              child: const Text('Tandai Dibaca'),
            ),
        ],
      ),
      body: notifsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (items) {
          if (items.isEmpty) {
            return const EmptyStateView(
              icon: LucideIcons.bellOff,
              title: 'Belum Ada Notifikasi',
              description:
                  'Notifikasi booking dan status pembayaran tampil di sini.',
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final n = items[index];
              return TempatinCard(
                backgroundColor: n.isRead
                    ? AppColors.surface
                    : AppColors.primaryTint,
                onTap: () async {
                  await ref.read(engagementRepositoryProvider).markAsRead(n.id);
                  ref.invalidate(notificationsProvider);
                  ref.invalidate(unreadNotificationCountProvider);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(n.title, style: AppTypography.label),
                    const SizedBox(height: 4),
                    Text(n.message, style: AppTypography.bodySm),
                    const SizedBox(height: 4),
                    Text(
                      DateFormatter.dateTime(n.createdAt),
                      style: AppTypography.caption,
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

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          TempatinCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primaryTint,
                      child: Image.asset(
                        'assets/images/logo-symbol.png',
                        height: 28,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            session?.user.name ?? 'Mode Tamu (Offline)',
                            style: AppTypography.headingSm,
                          ),
                          Text(
                            session?.user.email ??
                                'Masuk untuk booking, favorit, & invoice',
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                if (session == null)
                  TempatinButton(
                    label: 'Masuk / Daftar Lokal',
                    onPressed: () => context.push(AppRoutes.login),
                  )
                else ...[
                  StatusBadge(
                    label: session.isOwner
                        ? 'Akun Demo / Lokal: Owner'
                        : 'Akun Demo / Lokal: Member',
                    tone: StatusTone.info,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TempatinButton(
                    label: 'Edit Profil',
                    variant: ButtonVariant.secondary,
                    onPressed: () => context.push(AppRoutes.editProfile),
                  ),
                ],
              ],
            ),
          ),
          if (session != null) ...[
            const SizedBox(height: AppSpacing.lg),
            TempatinCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(LucideIcons.bell, size: 20),
                    title: const Text('Notifikasi Lokal'),
                    trailing: const Icon(LucideIcons.chevronRight, size: 16),
                    onTap: () => context.push(AppRoutes.notifications),
                  ),
                  if (session.isMember) ...[
                    const Divider(height: 1, color: AppColors.borderHairline),
                    ListTile(
                      leading: const Icon(LucideIcons.calendarCheck, size: 20),
                      title: const Text('Riwayat Booking & Invoice'),
                      trailing: const Icon(LucideIcons.chevronRight, size: 16),
                      onTap: () => context.go(AppRoutes.activity),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TempatinButton(
              label: 'Keluar dari Akun',
              variant: ButtonVariant.danger,
              icon: LucideIcons.logOut,
              onPressed: () async {
                await ref.read(sessionProvider.notifier).logout();
                if (!context.mounted) return;
                context.go(AppRoutes.login);
              },
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          TempatinCard(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tentang Mode Offline', style: AppTypography.headingSm),
                SizedBox(height: 4),
                Text(
                  'Aplikasi berjalan 100% di perangkat Android menggunakan SQLite (Drift) dan Flutter Assets tanpa koneksi internet maupun server eksternal.',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addrCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final session = ref.read(sessionProvider);
    _nameCtrl.text = session?.user.name ?? '';
    _phoneCtrl.text = session?.profile?.phone ?? '';
    _addrCtrl.text = session?.profile?.address ?? '';
    _bioCtrl.text = session?.profile?.bio ?? '';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addrCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil Lokal')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            TempatinTextField(
              label: 'Nama Lengkap',
              controller: _nameCtrl,
              validator: (v) => AppValidators.requiredField(v, label: 'Nama'),
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Nomor HP',
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(
              label: 'Alamat',
              controller: _addrCtrl,
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.md),
            TempatinTextField(label: 'Bio', controller: _bioCtrl, maxLines: 2),
            const SizedBox(height: AppSpacing.xl),
            TempatinButton(
              label: 'Simpan Profil',
              isLoading: _saving,
              onPressed: () async {
                if (!(_formKey.currentState?.validate() ?? false)) return;
                setState(() => _saving = true);
                await ref
                    .read(sessionProvider.notifier)
                    .updateProfile(
                      name: _nameCtrl.text,
                      phone: _phoneCtrl.text,
                      address: _addrCtrl.text,
                      bio: _bioCtrl.text,
                    );
                if (!context.mounted) return;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
