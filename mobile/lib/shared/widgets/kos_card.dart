import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/repositories/models.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';
import 'local_image.dart';
import 'tempatin_widgets.dart';

class KosCard extends StatelessWidget {
  const KosCard({
    super.key,
    required this.item,
    required this.onTap,
    this.onToggleFavorite,
    this.compact = false,
  });

  final KosCardData item;
  final VoidCallback onTap;
  final VoidCallback? onToggleFavorite;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final kos = item.kos;
    return TempatinCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: compact ? _buildHorizontal(kos) : _buildVertical(kos),
    );
  }

  Widget _buildVertical(dynamic kos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: LocalImage(
                path: kos.thumbnailAsset as String,
                width: double.infinity,
                cacheWidth: 640,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: StatusBadge(
                label: kos.type as String,
                tone: StatusTone.info,
              ),
            ),
            if (onToggleFavorite != null)
              Positioned(
                top: 8,
                right: 8,
                child: Material(
                  color: AppColors.surface.withValues(alpha: 0.92),
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onToggleFavorite,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        item.isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 18,
                        color: item.isFavorited
                            ? AppColors.dangerText
                            : AppColors.inkCharcoal,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kos.title as String,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.headingSm,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(
                    LucideIcons.mapPin,
                    size: 13,
                    color: AppColors.inkMuted,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      kos.city as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.caption,
                    ),
                  ),
                  if (item.reviewCount > 0) ...[
                    const Icon(
                      Icons.star_rounded,
                      size: 15,
                      color: AppColors.ratingStar,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      item.averageRating.toStringAsFixed(1),
                      style: AppTypography.caption.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.inkCharcoal,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                CurrencyFormatter.monthly(kos.price as num),
                style: AppTypography.headingSm.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontal(dynamic kos) {
    return Row(
      children: [
        SizedBox(
          width: 118,
          height: 108,
          child: LocalImage(
            path: kos.thumbnailAsset as String,
            cacheWidth: 360,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StatusBadge(
                      label: kos.type as String,
                      tone: StatusTone.info,
                    ),
                    if (item.reviewCount > 0)
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: AppColors.ratingStar,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            item.averageRating.toStringAsFixed(1),
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  kos.title as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.headingSm,
                ),
                const SizedBox(height: 2),
                Text(
                  kos.city as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption,
                ),
                const SizedBox(height: 6),
                Text(
                  CurrencyFormatter.monthly(kos.price as num),
                  style: AppTypography.label.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
