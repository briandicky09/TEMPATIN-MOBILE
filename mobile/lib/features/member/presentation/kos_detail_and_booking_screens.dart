import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../app/router/routes.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/repositories/models.dart';
import '../../../shared/widgets/local_image.dart';
import '../../../shared/widgets/tempatin_widgets.dart';

class KosDetailScreen extends ConsumerStatefulWidget {
  const KosDetailScreen({super.key, required this.kosId});

  final int kosId;

  @override
  ConsumerState<KosDetailScreen> createState() => _KosDetailScreenState();
}

class _KosDetailScreenState extends ConsumerState<KosDetailScreen> {
  final _galleryCtrl = PageController();
  int _photoIndex = 0;

  @override
  void dispose() {
    _galleryCtrl.dispose();
    super.dispose();
  }

  Future<void> _openReviewSheet(KosDetailData detail) async {
    final session = ref.read(sessionProvider);
    if (session == null) {
      context.push(AppRoutes.login);
      return;
    }

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      builder: (_) => _WriteReviewSheet(
        kosId: detail.kos.id,
        memberId: session.user.id,
        reviewerName: session.user.name,
      ),
    );

    if (saved == true) {
      ref.invalidate(kosDetailProvider(widget.kosId));
      ref.invalidate(featuredKosProvider);
      ref.invalidate(latestKosProvider);
      ref.invalidate(exploreKosProvider);
    }
  }

  Future<void> _openReplySheet(int reviewId, String? currentReply) async {
    final ctrl = TextEditingController(text: currentReply ?? '');
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Balas Ulasan Penghuni'),
        content: TextField(
          controller: ctrl,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Tulis balasan Anda...'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
    final text = ctrl.text.trim();
    ctrl.dispose();
    if (ok == true && text.isNotEmpty) {
      await ref
          .read(engagementRepositoryProvider)
          .replyToReview(reviewId, text);
      ref.invalidate(kosDetailProvider(widget.kosId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(kosDetailProvider(widget.kosId));
    final session = ref.watch(sessionProvider);

    return detailAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: const Text('Detail Kos')),
        body: Center(child: Text('Error: $err')),
      ),
      data: (detail) {
        if (detail == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Detail Kos')),
            body: const EmptyStateView(
              icon: LucideIcons.building2,
              title: 'Kos Tidak Ditemukan',
              description: 'Data properti mungkin sudah dihapus.',
            ),
          );
        }

        final kos = detail.kos;
        final gallery = detail.images.isNotEmpty
            ? detail.images.map((i) => i.imagePath).toList()
            : [kos.thumbnailAsset];
        final isOwnerOfKos = session?.user.id == kos.ownerId;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              kos.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                tooltip: 'Favorit',
                onPressed: () async {
                  if (session == null) {
                    context.push(AppRoutes.login);
                    return;
                  }
                  await ref
                      .read(engagementRepositoryProvider)
                      .toggleFavorite(session.user.id, kos.id);
                  ref.invalidate(kosDetailProvider(widget.kosId));
                  ref.invalidate(favoritesProvider);
                  ref.invalidate(featuredKosProvider);
                  ref.invalidate(latestKosProvider);
                },
                icon: Icon(
                  detail.isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: detail.isFavorited
                      ? AppColors.dangerText
                      : AppColors.inkCharcoal,
                ),
              ),
            ],
          ),
          body: ListView(
            children: [
              // Gallery Carousel
              SizedBox(
                height: 240,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _galleryCtrl,
                      itemCount: gallery.length,
                      onPageChanged: (i) => setState(() => _photoIndex = i),
                      itemBuilder: (_, index) => LocalImage(
                        path: gallery[index],
                        width: double.infinity,
                        height: 240,
                        cacheWidth: 960,
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: AppRadii.pill,
                        ),
                        child: Text(
                          '${_photoIndex + 1} / ${gallery.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StatusBadge(label: kos.type, tone: StatusTone.info),
                        const SizedBox(width: AppSpacing.sm),
                        StatusBadge(
                          label: kos.status == 'active'
                              ? 'Tersedia'
                              : 'Nonaktif',
                          tone: kos.status == 'active'
                              ? StatusTone.success
                              : StatusTone.neutral,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(kos.title, style: AppTypography.headingLg),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          LucideIcons.mapPin,
                          size: 14,
                          color: AppColors.inkMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '${kos.address}, ${kos.city}',
                            style: AppTypography.bodySm,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      CurrencyFormatter.monthly(kos.price),
                      style: AppTypography.headingLg.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    // Specs
                    TempatinCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _SpecBadge(
                            icon: LucideIcons.maximize2,
                            label: kos.area ?? '-',
                          ),
                          _SpecBadge(
                            icon: LucideIcons.bath,
                            label: 'KM ${kos.bathrooms ?? '-'}',
                          ),
                          _SpecBadge(
                            icon: LucideIcons.bike,
                            label: kos.garages ?? '-',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Description
                    TempatinCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Deskripsi Properti',
                            style: AppTypography.headingSm,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(kos.description, style: AppTypography.body),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Facilities
                    TempatinCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Fasilitas',
                            style: AppTypography.headingSm,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          if (detail.facilities.isEmpty)
                            const Text(
                              'Belum ada data fasilitas.',
                              style: AppTypography.bodySm,
                            )
                          else
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: [
                                for (final f in detail.facilities)
                                  Chip(
                                    avatar: Icon(
                                      facilityIconFor(f.iconKey),
                                      size: 15,
                                      color: AppColors.primary,
                                    ),
                                    label: Text(f.name),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Owner Card
                    TempatinCard(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primaryTint,
                            child: Text(
                              detail.ownerName[0].toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pemilik Kos',
                                  style: AppTypography.caption,
                                ),
                                Text(
                                  detail.ownerName,
                                  style: AppTypography.headingSm,
                                ),
                                Text(
                                  detail.ownerPhone,
                                  style: AppTypography.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Reviews
                    TempatinCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Ulasan',
                                    style: AppTypography.headingSm,
                                  ),
                                  if (detail.reviews.isNotEmpty) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '${detail.averageRating.toStringAsFixed(1)} ★ (${detail.reviews.length})',
                                      style: AppTypography.label,
                                    ),
                                  ],
                                ],
                              ),
                              if (!isOwnerOfKos)
                                TextButton.icon(
                                  onPressed: () => _openReviewSheet(detail),
                                  icon: const Icon(
                                    LucideIcons.messageSquarePlus,
                                    size: 16,
                                  ),
                                  label: const Text('Tulis Ulasan'),
                                ),
                            ],
                          ),
                          if (detail.reviews.isEmpty)
                            const Text(
                              'Belum ada ulasan. Jadilah yang pertama!',
                              style: AppTypography.bodySm,
                            )
                          else
                            for (final rev in detail.reviews)
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: AppSpacing.md,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          rev.reviewerName,
                                          style: AppTypography.label,
                                        ),
                                        Text(
                                          '${rev.rating} ★',
                                          style: AppTypography.label.copyWith(
                                            color: AppColors.ratingStar,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      rev.comment,
                                      style: AppTypography.bodySm,
                                    ),
                                    if (rev.ownerReply != null &&
                                        rev.ownerReply!.isNotEmpty) ...[
                                      const SizedBox(height: 6),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.canvas,
                                          borderRadius: AppRadii.button,
                                        ),
                                        child: Text(
                                          'Balasan Pemilik: ${rev.ownerReply}',
                                          style: AppTypography.caption,
                                        ),
                                      ),
                                    ],
                                    if (isOwnerOfKos)
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () => _openReplySheet(
                                            rev.id,
                                            rev.ownerReply,
                                          ),
                                          child: Text(
                                            rev.ownerReply == null
                                                ? 'Balas'
                                                : 'Edit Balasan',
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.borderHairline)),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Harga Sewa', style: AppTypography.caption),
                        Text(
                          CurrencyFormatter.monthly(kos.price),
                          style: AppTypography.headingSm.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: TempatinButton(
                      label: 'Ajukan Sewa',
                      onPressed: kos.status != 'active' || isOwnerOfKos
                          ? null
                          : () {
                              if (session == null) {
                                context.push(AppRoutes.login);
                                return;
                              }
                              context.push(AppRoutes.bookingForm(kos.id));
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SpecBadge extends StatelessWidget {
  const _SpecBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(height: 4),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}

class _WriteReviewSheet extends ConsumerStatefulWidget {
  const _WriteReviewSheet({
    required this.kosId,
    required this.memberId,
    required this.reviewerName,
  });

  final int kosId;
  final int memberId;
  final String reviewerName;

  @override
  ConsumerState<_WriteReviewSheet> createState() => _WriteReviewSheetState();
}

class _WriteReviewSheetState extends ConsumerState<_WriteReviewSheet> {
  final _commentCtrl = TextEditingController();
  int _rating = 5;
  bool _saving = false;

  @override
  void dispose() {
    _commentCtrl.dispose();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tulis Ulasan Kos', style: AppTypography.headingMd),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (var s = 1; s <= 5; s++)
                IconButton(
                  onPressed: () => setState(() => _rating = s),
                  icon: Icon(
                    s <= _rating ? Icons.star_rounded : Icons.star_border,
                    color: AppColors.ratingStar,
                    size: 28,
                  ),
                ),
            ],
          ),
          TextField(
            controller: _commentCtrl,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: 'Bagikan pengalaman Anda mengenai kos ini...',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TempatinButton(
            label: 'Simpan Ulasan',
            isLoading: _saving,
            onPressed: () async {
              if (_commentCtrl.text.trim().isEmpty) return;
              setState(() => _saving = true);
              await ref
                  .read(engagementRepositoryProvider)
                  .submitReview(
                    kosId: widget.kosId,
                    memberId: widget.memberId,
                    reviewerName: widget.reviewerName,
                    rating: _rating,
                    comment: _commentCtrl.text,
                  );
              if (!context.mounted) return;
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }
}

class BookingFormScreen extends ConsumerStatefulWidget {
  const BookingFormScreen({super.key, required this.kosId});

  final int kosId;

  @override
  ConsumerState<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends ConsumerState<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  DateTime _startDate = DateTime.now().add(const Duration(days: 3));
  int _durationMonths = 1;
  bool _prefilled = false;
  bool _submitting = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(kosDetailProvider(widget.kosId));
    final session = ref.watch(sessionProvider);

    if (!_prefilled && session != null) {
      _prefilled = true;
      _nameCtrl.text = session.user.name;
      _phoneCtrl.text = session.profile?.phone ?? '';
      _emailCtrl.text = session.user.email;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ajukan Sewa Kos')),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (detail) {
          if (detail == null) {
            return const Center(child: Text('Properti tidak ditemukan.'));
          }
          final kos = detail.kos;
          final subtotal = kos.price * _durationMonths;
          final total = subtotal + 25000.0;

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                TempatinCard(
                  child: Row(
                    children: [
                      LocalImage(
                        path: kos.thumbnailAsset,
                        width: 72,
                        height: 72,
                        borderRadius: AppRadii.button,
                        cacheWidth: 240,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(kos.title, style: AppTypography.headingSm),
                            Text(kos.city, style: AppTypography.caption),
                            const SizedBox(height: 4),
                            Text(
                              CurrencyFormatter.monthly(kos.price),
                              style: AppTypography.label.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Periode Sewa',
                        style: AppTypography.headingSm,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(LucideIcons.calendar),
                        title: const Text('Tanggal Mulai Masuk'),
                        subtitle: Text(DateFormatter.shortDate(_startDate)),
                        trailing: const Text('Ubah'),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _startDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (picked != null) {
                            setState(() => _startDate = picked);
                          }
                        },
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Durasi Sewa: $_durationMonths Bulan',
                        style: AppTypography.label,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: [
                          for (final m in const [1, 3, 6, 12])
                            ChoiceChip(
                              label: Text('$m Bulan'),
                              selected: _durationMonths == m,
                              onSelected: (_) =>
                                  setState(() => _durationMonths = m),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Data Penyewa',
                        style: AppTypography.headingSm,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TempatinTextField(
                        label: 'Nama Lengkap',
                        controller: _nameCtrl,
                        validator: (v) =>
                            AppValidators.requiredField(v, label: 'Nama'),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TempatinTextField(
                        label: 'Nomor HP',
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        validator: AppValidators.phone,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TempatinTextField(
                        label: 'Email',
                        controller: _emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidators.email,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TempatinTextField(
                        label: 'Catatan Tambahan (Opsional)',
                        controller: _notesCtrl,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rincian Biaya Lokal',
                        style: AppTypography.headingSm,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _CostRow(
                        label:
                            'Sewa ($_durationMonths × ${CurrencyFormatter.idr(kos.price)})',
                        value: CurrencyFormatter.idr(subtotal),
                      ),
                      const SizedBox(height: 6),
                      _CostRow(
                        label: 'Biaya Admin',
                        value: CurrencyFormatter.idr(25000),
                      ),
                      const Divider(
                        height: 20,
                        color: AppColors.borderHairline,
                      ),
                      _CostRow(
                        label: 'Total Tagihan',
                        value: CurrencyFormatter.idr(total),
                        bold: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                TempatinButton(
                  label: 'Konfirmasi Pengajuan Sewa',
                  isLoading: _submitting,
                  onPressed: () async {
                    if (session == null) {
                      context.push(AppRoutes.login);
                      return;
                    }
                    if (!(_formKey.currentState?.validate() ?? false)) return;
                    setState(() => _submitting = true);
                    await ref
                        .read(bookingRepositoryProvider)
                        .createBooking(
                          kos: kos,
                          memberId: session.user.id,
                          tenantName: _nameCtrl.text,
                          tenantPhone: _phoneCtrl.text,
                          tenantEmail: _emailCtrl.text,
                          startDate: _startDate,
                          durationMonths: _durationMonths,
                          notes: _notesCtrl.text,
                        );
                    ref.invalidate(memberBookingsProvider);
                    ref.invalidate(memberInvoicesProvider);
                    ref.invalidate(notificationsProvider);
                    ref.invalidate(unreadNotificationCountProvider);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Pengajuan booking tersimpan! Invoice otomatis dibuat.',
                        ),
                      ),
                    );
                    context.go(AppRoutes.activity);
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CostRow extends StatelessWidget {
  const _CostRow({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: bold ? AppTypography.label : AppTypography.bodySm),
        Text(
          value,
          style: bold
              ? AppTypography.headingSm.copyWith(color: AppColors.primary)
              : AppTypography.label,
        ),
      ],
    );
  }
}
