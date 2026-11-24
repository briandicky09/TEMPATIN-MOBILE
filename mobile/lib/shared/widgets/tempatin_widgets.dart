import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/theme/app_theme.dart';
import '../../core/utils/formatters.dart';

enum ButtonVariant { primary, secondary, outlined, danger }

class TempatinButton extends StatelessWidget {
  const TempatinButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color:
                  variant == ButtonVariant.outlined ||
                      variant == ButtonVariant.secondary
                  ? AppColors.primary
                  : Colors.white,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ] else if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: AppSpacing.sm),
        ],
        Flexible(
          child: Text(
            label,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );

    final effectiveAction = isLoading ? null : onPressed;

    final button = switch (variant) {
      ButtonVariant.primary => FilledButton(
        onPressed: effectiveAction,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.button),
        ),
        child: child,
      ),
      ButtonVariant.secondary => FilledButton(
        onPressed: effectiveAction,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryTint,
          foregroundColor: AppColors.primaryDark,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.button),
        ),
        child: child,
      ),
      ButtonVariant.outlined => OutlinedButton(
        onPressed: effectiveAction,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.inkCharcoal,
          side: const BorderSide(color: AppColors.borderStrong),
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.button),
        ),
        child: child,
      ),
      ButtonVariant.danger => FilledButton(
        onPressed: effectiveAction,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.dangerBg,
          foregroundColor: AppColors.dangerText,
          minimumSize: const Size(0, 48),
          shape: RoundedRectangleBorder(borderRadius: AppRadii.button),
        ),
        child: child,
      ),
    };

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class TempatinCard extends StatelessWidget {
  const TempatinCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
    this.backgroundColor = AppColors.surface,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(padding: padding, child: child);
    return Material(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.card,
        side: const BorderSide(color: AppColors.borderHairline, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap != null ? InkWell(onTap: onTap, child: content) : content,
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label, required this.tone});

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = StatusHelper.colorsFor(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: AppRadii.pill),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}

class TempatinTextField extends StatelessWidget {
  const TempatinTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: obscureText ? 1 : maxLines,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 18) : null,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String description;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryTint,
                borderRadius: AppRadii.pill,
              ),
              child: Icon(icon, size: 26, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              style: AppTypography.headingMd,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              description,
              style: AppTypography.bodySm,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              TempatinButton(
                label: actionLabel!,
                onPressed: onAction,
                fullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

IconData facilityIconFor(String iconKey) {
  return switch (iconKey) {
    'wifi' => LucideIcons.wifi,
    'wind' => LucideIcons.wind,
    'bath' => LucideIcons.bath,
    'bed' => LucideIcons.bedDouble,
    'archive' => LucideIcons.archive,
    'laptop' => LucideIcons.laptop,
    'armchair' => LucideIcons.armchair,
    'bike' => LucideIcons.bike,
    'car' => LucideIcons.car,
    'utensils' => LucideIcons.utensils,
    'video' => LucideIcons.video,
    'shirt' => LucideIcons.shirt,
    'zap' => LucideIcons.zap,
    _ => LucideIcons.check,
  };
}
