import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import 'tempatin_card.dart';

/// Lightweight warm-paper loading placeholder block.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.skeletonBase,
        borderRadius: borderRadius ?? AppRadii.buttonRadius,
      ),
    );
  }
}

/// Skeleton matching vertical KosCard geometry.
class KosCardSkeleton extends StatelessWidget {
  const KosCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return TempatinCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AspectRatio(
            aspectRatio: 16 / 9.5,
            child: SkeletonBox(
              height: 180,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppRadii.card),
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonBox(width: 100, height: 12),
                SizedBox(height: AppSpacing.sm),
                SkeletonBox(width: 220, height: 18),
                SizedBox(height: AppSpacing.xs),
                SkeletonBox(width: 160, height: 14),
                SizedBox(height: AppSpacing.md),
                SkeletonBox(width: 130, height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton matching compact horizontal KosCard geometry.
class KosListCardSkeleton extends StatelessWidget {
  const KosListCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return TempatinCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonBox(width: 108, height: 108),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SkeletonBox(width: 64, height: 20),
                SizedBox(height: AppSpacing.sm),
                SkeletonBox(height: 16),
                SizedBox(height: AppSpacing.xs),
                SkeletonBox(width: 110, height: 12),
                SizedBox(height: AppSpacing.md),
                SkeletonBox(width: 120, height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
