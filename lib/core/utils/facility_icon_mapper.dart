import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Maps Laravel `facilities.slug` values to consistent Lucide icons.
abstract final class FacilityIconMapper {
  static IconData fromSlug(String slug) {
    return switch (slug.toLowerCase()) {
      'wifi' => LucideIcons.wifi,
      'ac' => LucideIcons.airVent,
      'kamar-mandi-dalam' => LucideIcons.bath,
      'kasur' => LucideIcons.bedDouble,
      'lemari' => LucideIcons.archive,
      'meja' => LucideIcons.lampDesk,
      'kursi' => LucideIcons.armchair,
      'parkir-motor' => LucideIcons.bike,
      'parkir-mobil' => LucideIcons.car,
      'dapur' => LucideIcons.utensils,
      'cctv' => LucideIcons.cctv,
      'laundry' => LucideIcons.shirt,
      'listrik' => LucideIcons.zap,
      _ => LucideIcons.circleCheck,
    };
  }
}
