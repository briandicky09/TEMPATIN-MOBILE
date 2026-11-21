import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';
import '../../app/theme/app_typography.dart';
import '../../core/utils/facility_icon_mapper.dart';
import '../models/facility_model.dart';

/// Compact facility chip displaying Lucide icon mapped from `facility.slug`.
class FacilityChip extends StatelessWidget {
  const FacilityChip({super.key, required this.facility});

  final FacilityModel facility;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: AppRadii.buttonRadius,
        border: Border.all(color: AppColors.borderHairline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            FacilityIconMapper.fromSlug(facility.slug),
            size: 15,
            color: AppColors.primary,
          ),
          const SizedBox(width: AppSpacing.xs + 2),
          Text(
            facility.name,
            style: AppTypography.caption.copyWith(
              color: AppColors.inkCharcoal,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
