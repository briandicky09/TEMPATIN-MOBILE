import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/widgets/status_badge.dart';
import '../../core/widgets/tempatin_card.dart';
import '../models/kos_models.dart';

enum KosCardLayout { vertical, compactList }

/// Reusable TEMPATIN property card preserving Warm Paper 1px hairline styling.
class KosCard extends StatelessWidget {
  const KosCard({
    super.key,
    required this.kos,
    required this.onTap,
    this.onFavoriteTap,
    this.layout = KosCardLayout.vertical,
  });

  final KosSummaryModel kos;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteTap;
  final KosCardLayout layout;

  @override
  Widget build(BuildContext context) {
    return layout == KosCardLayout.vertical
        ? _buildVerticalCard()
        : _buildCompactListCard();
  }

  Widget _buildVerticalCard() {
    return TempatinCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9.5,
                child: _KosThumbnailImage(url: kos.thumbnailUrl),
              ),
              Positioned(
                top: AppSpacing.md,
                left: AppSpacing.md,
                child: _KosTypePill(type: kos.type),
              ),
              if (onFavoriteTap != null)
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: _FavoriteCircleButton(
                    isFavorited: kos.isFavorited,
                    onTap: onFavoriteTap!,
                  ),
                ),
            ],
          ),
          Padding(
            padding: AppSpacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      LucideIcons.mapPin,
                      size: 13,
                      color: AppColors.inkSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        kos.city,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption,
                      ),
                    ),
                    if (kos.reviewCount > 0) ...[
                      const Icon(
                        Icons.star_rounded,
                        size: 15,
                        color: AppColors.accentMarigold,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${kos.rating.toStringAsFixed(1)} (${kos.reviewCount})',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.inkCharcoal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.xs + 2),
                Text(
                  kos.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.headingSm,
                ),
                if (kos.address != null && kos.address!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    kos.address!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySm,
                  ),
                ],
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CurrencyFormatter.formatMonthly(kos.price),
                      style: AppTypography.headingSm.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    if (kos.availableRoomsCount != null)
                      StatusBadge(
                        label: kos.availableRoomsCount! > 0
                            ? '${kos.availableRoomsCount} kamar tersedia'
                            : 'Penuh',
                        tone: kos.availableRoomsCount! > 0
                            ? StatusTone.success
                            : StatusTone.neutral,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactListCard() {
    return TempatinCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: AppRadii.buttonRadius,
            child: SizedBox(
              width: 108,
              height: 108,
              child: _KosThumbnailImage(url: kos.thumbnailUrl),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _KosTypePill(type: kos.type),
                    const Spacer(),
                    if (onFavoriteTap != null)
                      InkResponse(
                        onTap: onFavoriteTap,
                        radius: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            kos.isFavorited
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 20,
                            color: kos.isFavorited
                                ? AppColors.accentCoral
                                : AppColors.inkSecondary,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  kos.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.headingSm.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      LucideIcons.mapPin,
                      size: 12,
                      color: AppColors.inkSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        kos.city,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.caption,
                      ),
                    ),
                    if (kos.reviewCount > 0) ...[
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: AppColors.accentMarigold,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        kos.rating.toStringAsFixed(1),
                        style: AppTypography.caption.copyWith(
                          color: AppColors.inkCharcoal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  CurrencyFormatter.formatMonthly(kos.price),
                  style: AppTypography.label.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KosThumbnailImage extends StatelessWidget {
  const _KosThumbnailImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return _fallbackBox();
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, _) => Container(color: AppColors.skeletonBase),
      errorWidget: (context, _, _) => _fallbackBox(),
    );
  }

  Widget _fallbackBox() {
    return Container(
      color: AppColors.neutralBg,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/logo-symbol.png',
        width: 36,
        height: 36,
        opacity: const AlwaysStoppedAnimation(0.5),
      ),
    );
  }
}

class _KosTypePill extends StatelessWidget {
  const _KosTypePill({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final tone = switch (type.toLowerCase()) {
      'putri' => StatusTone.danger,
      'putra' => StatusTone.info,
      'eksklusif' => StatusTone.warning,
      _ => StatusTone.neutral,
    };
    return StatusBadge(label: type, tone: tone);
  }
}

class _FavoriteCircleButton extends StatelessWidget {
  const _FavoriteCircleButton({required this.isFavorited, required this.onTap});

  final bool isFavorited;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface.withValues(alpha: 0.94),
      shape: const CircleBorder(
        side: BorderSide(color: AppColors.borderHairline),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            isFavorited
                ? Icons.favorite_rounded
                : Icons.favorite_border_rounded,
            size: 18,
            color: isFavorited ? AppColors.accentCoral : AppColors.inkCharcoal,
          ),
        ),
      ),
    );
  }
}
