import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_colors.dart';

/// 5-tab Bottom Navigation Shell for Guest & Customer roles.
class CustomerShell extends StatelessWidget {
  const CustomerShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.borderHairline, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.house, size: 22),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.search, size: 22),
              label: 'Eksplor',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.heart, size: 22),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.calendarCheck, size: 22),
              label: 'Aktivitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user, size: 22),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
