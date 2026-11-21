import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/router/route_names.dart';
import '../../core/widgets/app_empty_state.dart';

/// Prompts guest users to sign in or register before accessing member-only features.
class GuestAuthPrompt extends StatelessWidget {
  const GuestAuthPrompt({
    super.key,
    required this.title,
    required this.description,
    this.icon = LucideIcons.lock,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: icon,
      title: title,
      description: description,
      actionLabel: 'Masuk / Daftar',
      onAction: () => context.push(RoutePaths.login),
    );
  }
}
