import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/router/route_names.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/errors/app_exception.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/widgets/app_empty_state.dart';
import '../../../../core/widgets/skeletons.dart';
import '../../../../core/widgets/status_badge.dart';
import '../../../../core/widgets/tempatin_button.dart';
import '../../../../core/widgets/tempatin_card.dart';
import '../../../../shared/models/kos_models.dart';
import '../../../../shared/widgets/facility_chip.dart';
import '../../../../shared/widgets/kos_card.dart';
import '../../../authentication/presentation/providers/auth_session_provider.dart';
import '../../../favorites/presentation/providers/favorites_provider.dart';
import '../../../maps/presentation/widgets/kos_osm_map_card.dart';
import '../../../messaging/data/chat_repository.dart';
import '../../../reviews/presentation/widgets/write_review_bottom_sheet.dart';
import '../../../survey/presentation/widgets/schedule_survey_bottom_sheet.dart';
import '../providers/property_providers.dart';

/// Complete property details screen connected to `GET /api/v1/kos/{slug}`.
class KosDetailScreen extends ConsumerStatefulWidget {
  const KosDetailScreen({super.key, required this.slug});

  final String slug;

  @override
  ConsumerState<KosDetailScreen> createState() => _KosDetailScreenState();
}

class _KosDetailScreenState extends ConsumerState<KosDetailScreen> {
  final _galleryController = PageController();
  int _galleryIndex = 0;
  bool _descExpanded = false;
  int? _selectedRatingFilter;

  @override
  void dispose() {
    _galleryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(kosDetailProvider(widget.slug));
    final isAuthenticated = ref.watch(
      authSessionProvider.select((s) => s.isAuthenticated),
    );

    return detailAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('Detail Kos')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            SkeletonBox(height: 220),
            SizedBox(height: AppSpacing.lg),
            SkeletonBox(width: 240, height: 24),
            SizedBox(height: AppSpacing.sm),
            SkeletonBox(width: 180, height: 16),
            SizedBox(height: AppSpacing.xl),
            SkeletonBox(height: 120),
          ],
        ),
      ),
      error: (err, _) => Scaffold(
        appBar: AppBar(title: const Text('Detail Kos')),
        body: AppErrorState(
          message: err.toString(),
          onRetry: () => ref.invalidate(kosDetailProvider(widget.slug)),
        ),
      ),
      data: (kos) => _buildContent(context, kos, isAuthenticated),
    );
  }

  Widget _buildContent(
    BuildContext context,
    KosDetailModel kos,
    bool isAuthenticated,
  ) {
    final galleryUrls = <String>[
      if (kos.photos.isNotEmpty)
        ...kos.photos.map((p) => p.photoUrl)
      else if (kos.thumbnailUrl.isNotEmpty)
        kos.thumbnailUrl,
    ];

    final filteredReviews = _selectedRatingFilter == null
        ? kos.reviews
        : kos.reviews.where((r) => r.rating == _selectedRatingFilter).toList();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppColors.surface,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: _CircleIconBtn(
                icon: Icons.arrow_back_rounded,
                onTap: () => context.pop(),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: _CircleIconBtn(
                  icon: kos.isFavorited
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  iconColor: kos.isFavorited
                      ? AppColors.accentCoral
                      : AppColors.inkCharcoal,
                  onTap: () => _toggleFavorite(kos, isAuthenticated),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (galleryUrls.isEmpty)
                    Container(
                      color: AppColors.neutralBg,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/logo-symbol.png',
                        width: 56,
                      ),
                    )
                  else
                    PageView.builder(
                      controller: _galleryController,
                      itemCount: galleryUrls.length,
                      onPageChanged: (i) => setState(() => _galleryIndex = i),
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () => context.push(
                          RoutePaths.kosGallery(kos.slug),
                          extra: {
                            'urls': galleryUrls,
                            'index': index,
                            'title': kos.title,
                          },
                        ),
                        child: CachedNetworkImage(
                          imageUrl: galleryUrls[index],
                          fit: BoxFit.cover,
                          placeholder: (_, _) =>
                              Container(color: AppColors.skeletonBase),
                          errorWidget: (_, _, _) => Container(
                            color: AppColors.neutralBg,
                            child: const Icon(LucideIcons.imageOff),
                          ),
                        ),
                      ),
                    ),
                  if (galleryUrls.length > 1)
                    Positioned(
                      bottom: AppSpacing.md,
                      right: AppSpacing.md,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.65),
                          borderRadius: AppRadii.pillRadius,
                        ),
                        child: Text(
                          '${_galleryIndex + 1} / ${galleryUrls.length}',
                          style: AppTypography.caption.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            sliver: SliverList.list(
              children: [
                // Overview Card
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.xs,
                        children: [
                          StatusBadge(label: kos.type, tone: StatusTone.info),
                          const StatusBadge(
                            label: 'Terverifikasi',
                            tone: StatusTone.success,
                            icon: LucideIcons.badgeCheck,
                          ),
                          if (kos.availableRooms.isNotEmpty)
                            StatusBadge(
                              label:
                                  '${kos.availableRooms.length} kamar tersedia',
                              tone: StatusTone.success,
                            ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(kos.title, style: AppTypography.headingLg),
                      const SizedBox(height: AppSpacing.xs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              LucideIcons.mapPin,
                              size: 15,
                              color: AppColors.inkSecondary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              [
                                if (kos.address != null &&
                                    kos.address!.isNotEmpty)
                                  kos.address!,
                                kos.city,
                              ].join(', '),
                              style: AppTypography.bodySm,
                            ),
                          ),
                        ],
                      ),
                      if (kos.reviewCount > 0) ...[
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: AppColors.accentMarigold,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              kos.rating.toStringAsFixed(1),
                              style: AppTypography.headingSm,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '(${kos.reviewCount} ulasan penghuni)',
                              style: AppTypography.bodySm,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                // Specifications
                if (_hasSpecs(kos)) ...[
                  const SizedBox(height: AppSpacing.md),
                  TempatinCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spesifikasi Properti',
                          style: AppTypography.headingSm,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: [
                            if (kos.area != null && kos.area!.isNotEmpty)
                              _SpecBadge(
                                icon: LucideIcons.maximize2,
                                label: kos.area!,
                              ),
                            if (kos.roomsSummary != null &&
                                kos.roomsSummary!.isNotEmpty)
                              _SpecBadge(
                                icon: LucideIcons.doorOpen,
                                label: kos.roomsSummary!,
                              ),
                            if (kos.bathrooms != null &&
                                kos.bathrooms!.isNotEmpty)
                              _SpecBadge(
                                icon: LucideIcons.bath,
                                label: kos.bathrooms!,
                              ),
                            if (kos.garages != null && kos.garages!.isNotEmpty)
                              _SpecBadge(
                                icon: LucideIcons.car,
                                label: kos.garages!,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],

                // Facilities
                if (kos.facilities.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  TempatinCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fasilitas', style: AppTypography.headingSm),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.sm,
                          children: kos.facilities
                              .map((f) => FacilityChip(facility: f))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],

                // Description
                if (kos.description != null && kos.description!.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.md),
                  TempatinCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Deskripsi Kos', style: AppTypography.headingSm),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          kos.description!,
                          maxLines: _descExpanded ? null : 4,
                          overflow: _descExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: AppTypography.body,
                        ),
                        if (kos.description!.length > 140)
                          TextButton(
                            onPressed: () =>
                                setState(() => _descExpanded = !_descExpanded),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 32),
                            ),
                            child: Text(
                              _descExpanded ? 'Tutup' : 'Baca selengkapnya',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],

                // Location & Maps Launcher (OSM interactive map embeds here in Phase 9)
                const SizedBox(height: AppSpacing.md),
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lokasi Properti', style: AppTypography.headingSm),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        [
                          if (kos.address != null && kos.address!.isNotEmpty)
                            kos.address!,
                          kos.city,
                        ].join(', '),
                        style: AppTypography.bodySm,
                      ),
                      if (kos.latitude != null && kos.longitude != null) ...[
                        const SizedBox(height: AppSpacing.md),
                        KosOsmMapCard(
                          latitude: kos.latitude!,
                          longitude: kos.longitude!,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TempatinButton(
                          label: 'Buka di Google Maps',
                          variant: TempatinButtonVariant.secondary,
                          icon: LucideIcons.mapPin,
                          onPressed: () =>
                              _openExternalMaps(kos.latitude!, kos.longitude!),
                        ),
                      ],
                    ],
                  ),
                ),

                // Owner Card
                if (kos.owner != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  TempatinCard(
                    child: Row(
                      children: [
                        _OwnerAvatar(
                          name: kos.owner!.name,
                          avatarUrl: kos.owner!.avatarUrl,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pemilik Kos', style: AppTypography.caption),
                              Text(
                                kos.owner!.name,
                                style: AppTypography.headingSm,
                              ),
                            ],
                          ),
                        ),
                        TempatinButton(
                          label: 'Chat',
                          variant: TempatinButtonVariant.secondary,
                          icon: LucideIcons.messageSquare,
                          fullWidth: false,
                          onPressed: () => _startChat(kos, isAuthenticated),
                        ),
                      ],
                    ),
                  ),
                ],

                // Reviews
                const SizedBox(height: AppSpacing.md),
                TempatinCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ulasan Penghuni',
                            style: AppTypography.headingSm,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (kos.reviewCount > 0)
                                Text(
                                  '${kos.rating.toStringAsFixed(1)} ★ (${kos.reviewCount})',
                                  style: AppTypography.label.copyWith(
                                    color: AppColors.inkCharcoal,
                                  ),
                                ),
                              if (kos.canReview && isAuthenticated) ...[
                                const SizedBox(width: AppSpacing.sm),
                                TextButton.icon(
                                  onPressed: () => WriteReviewBottomSheet.show(
                                    context,
                                    kosSlug: kos.slug,
                                  ),
                                  icon: const Icon(
                                    LucideIcons.messageSquarePlus,
                                    size: 16,
                                  ),
                                  label: const Text('Tulis Ulasan'),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                      if (kos.reviews.isEmpty) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Belum ada ulasan untuk properti ini.',
                          style: AppTypography.bodySm,
                        ),
                      ] else ...[
                        const SizedBox(height: AppSpacing.sm),
                        SizedBox(
                          height: 36,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  label: const Text('Semua'),
                                  selected: _selectedRatingFilter == null,
                                  onSelected: (_) => setState(
                                    () => _selectedRatingFilter = null,
                                  ),
                                ),
                              ),
                              for (final star in [5, 4, 3, 2, 1])
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text('$star ★'),
                                    selected: _selectedRatingFilter == star,
                                    onSelected: (_) => setState(
                                      () => _selectedRatingFilter = star,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        for (final review in filteredReviews)
                          _ReviewTile(review: review),
                      ],
                    ],
                  ),
                ),

                // Similar Kos
                if (kos.similarKos.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.xl),
                  Text('Kos Serupa Lainnya', style: AppTypography.headingSm),
                  const SizedBox(height: AppSpacing.sm),
                  for (final sim in kos.similarKos)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: KosCard(
                        kos: sim,
                        layout: KosCardLayout.compactList,
                        onTap: () =>
                            context.push(RoutePaths.kosDetail(sim.slug)),
                      ),
                    ),
                ],
                const SizedBox(height: 96),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _StickyDetailBottomBar(
        price: kos.price,
        onSurveyTap: () {
          if (!isAuthenticated) {
            context.push(RoutePaths.login);
            return;
          }
          ScheduleSurveyBottomSheet.show(context, kosSlug: kos.slug);
        },
        onBookTap: () {
          if (!isAuthenticated) {
            context.push(RoutePaths.login);
            return;
          }
          context.push(RoutePaths.bookingCreate(kos.slug));
        },
      ),
    );
  }

  bool _hasSpecs(KosDetailModel kos) {
    return (kos.area?.isNotEmpty ?? false) ||
        (kos.roomsSummary?.isNotEmpty ?? false) ||
        (kos.bathrooms?.isNotEmpty ?? false) ||
        (kos.garages?.isNotEmpty ?? false);
  }

  Future<void> _toggleFavorite(KosDetailModel kos, bool isAuthenticated) async {
    if (!isAuthenticated) {
      context.push(RoutePaths.login);
      return;
    }
    final summary = KosSummaryModel(
      id: kos.id,
      title: kos.title,
      slug: kos.slug,
      price: kos.price,
      type: kos.type,
      city: kos.city,
      address: kos.address,
      thumbnailUrl: kos.thumbnailUrl,
      status: kos.status,
      rating: kos.rating,
      reviewCount: kos.reviewCount,
      isFavorited: kos.isFavorited,
    );
    try {
      final isFav = await ref
          .read(favoritesProvider.notifier)
          .toggleFavorite(summary);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFav ? 'Ditambahkan ke favorit.' : 'Dihapus dari favorit.',
          ),
        ),
      );
    } on AppException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<void> _openExternalMaps(double lat, double lng) async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      _showPhaseNotice('Tidak dapat membuka aplikasi peta.');
    }
  }

  Future<void> _startChat(KosDetailModel kos, bool isAuthenticated) async {
    if (!isAuthenticated) {
      context.push(RoutePaths.login);
      return;
    }
    try {
      final conv = await ref
          .read(chatRepositoryProvider)
          .startConversation(kos.slug);
      if (!mounted) return;
      context.push(RoutePaths.chatDetail(conv.id), extra: conv);
    } on AppException catch (e) {
      if (!mounted) return;
      _showPhaseNotice(e.message);
    }
  }

  void _showPhaseNotice(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}

class _CircleIconBtn extends StatelessWidget {
  const _CircleIconBtn({
    required this.icon,
    required this.onTap,
    this.iconColor = AppColors.inkCharcoal,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface.withValues(alpha: 0.92),
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.borderHairline),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 20, color: iconColor),
        ),
      ),
    );
  }
}

class _SpecBadge extends StatelessWidget {
  const _SpecBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: AppRadii.buttonRadius,
        border: Border.all(color: AppColors.borderHairline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.inkSecondary),
          const SizedBox(width: 6),
          Text(label, style: AppTypography.caption),
        ],
      ),
    );
  }
}

class _OwnerAvatar extends StatelessWidget {
  const _OwnerAvatar({required this.name, this.avatarUrl});

  final String name;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatarUrl!,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          errorWidget: (_, _, _) => _initialCircle(),
        ),
      );
    }
    return _initialCircle();
  }

  Widget _initialCircle() {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'O';
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.primaryTint,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderHairline),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: AppTypography.headingSm.copyWith(color: AppColors.primary),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.borderHairline, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  review.reviewerName,
                  style: AppTypography.label.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (review.isVerifiedTenant) ...[
                const StatusBadge(
                  label: 'Penghuni Terverifikasi',
                  tone: StatusTone.success,
                ),
                const SizedBox(width: 6),
              ],
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 15,
                    color: AppColors.accentMarigold,
                  ),
                  Text(' ${review.rating}', style: AppTypography.caption),
                ],
              ),
            ],
          ),
          if (review.createdAt != null) ...[
            const SizedBox(height: 2),
            Text(
              DateFormatter.shortDate(review.createdAt!),
              style: AppTypography.caption,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Text(review.comment, style: AppTypography.bodySm),
          if (review.reply != null && review.reply!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: AppRadii.buttonRadius,
                border: Border.all(color: AppColors.borderHairline),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balasan Pemilik',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(review.reply!, style: AppTypography.bodySm),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StickyDetailBottomBar extends StatelessWidget {
  const _StickyDetailBottomBar({
    required this.price,
    required this.onSurveyTap,
    required this.onBookTap,
  });

  final double price;
  final VoidCallback onSurveyTap;
  final VoidCallback onBookTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.borderHairline, width: 1),
        ),
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
                  Text('Harga Sewa', style: AppTypography.caption),
                  Text(
                    CurrencyFormatter.formatMonthly(price),
                    style: AppTypography.headingSm.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            TempatinButton(
              label: 'Survei',
              variant: TempatinButtonVariant.secondary,
              fullWidth: false,
              onPressed: onSurveyTap,
            ),
            const SizedBox(width: AppSpacing.sm),
            TempatinButton(
              label: 'Ajukan Sewa',
              fullWidth: false,
              onPressed: onBookTap,
            ),
          ],
        ),
      ),
    );
  }
}
