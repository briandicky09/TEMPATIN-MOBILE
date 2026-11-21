import 'package:material_ui/material_ui.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../core/widgets/app_empty_state.dart';

/// Clean placeholder screen for Phase 5–9 feature tabs during Phase 4 foundation.
class PhasePlaceholderScreen extends StatelessWidget {
  const PhasePlaceholderScreen({
    super.key,
    required this.title,
    required this.description,
    this.icon = LucideIcons.layers,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String description;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppEmptyState(
        icon: icon,
        title: title,
        description: description,
        actionLabel: actionLabel,
        onAction: onAction,
      ),
    );
  }
}
