import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../theme/app_colors.dart';

/// 5-tab Bottom Navigation Shell for Property Owner role.
class OwnerShell extends StatelessWidget {
  const OwnerShell({super.key, required this.navigationShell});

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
              icon: Icon(LucideIcons.layoutDashboard, size: 22),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.building2, size: 22),
              label: 'Properti',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.clipboardList, size: 22),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.messageSquare, size: 22),
              label: 'Pesan',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.menu, size: 22),
              label: 'Lainnya',
            ),
          ],
        ),
      ),
    );
  }
}
