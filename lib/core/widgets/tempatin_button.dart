import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';

enum TempatinButtonVariant { primary, secondary, outlined, ghost, danger }

/// Standardized touch-friendly button (48dp height, 8dp radius) matching DESIGN_SYSTEM.md.
class TempatinButton extends StatelessWidget {
  const TempatinButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = TempatinButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final TempatinButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final bool disabled = onPressed == null || isLoading;

    final (Color bg, Color fg, BorderSide? border) = switch (variant) {
      TempatinButtonVariant.primary => (AppColors.primary, Colors.white, null),
      TempatinButtonVariant.secondary => (
        AppColors.primaryTint,
        AppColors.primary,
        null,
      ),
      TempatinButtonVariant.outlined => (
        AppColors.surface,
        AppColors.inkPrimary,
        const BorderSide(color: AppColors.borderStrong, width: 1),
      ),
      TempatinButtonVariant.ghost => (
        Colors.transparent,
        AppColors.inkCharcoal,
        null,
      ),
      TempatinButtonVariant.danger => (
        AppColors.dangerBg,
        AppColors.dangerText,
        const BorderSide(color: AppColors.borderHairline, width: 1),
      ),
    };

    final child = isLoading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18, color: fg),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.label.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 48,
      child: Material(
        color: disabled ? bg.withValues(alpha: 0.55) : bg,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.buttonRadius,
          side: border ?? BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: disabled ? null : onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
