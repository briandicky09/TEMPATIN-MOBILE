import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/providers/app_providers.dart';
import '../../core/theme/app_theme.dart';
import '../../data/repositories/models.dart';
import '../../features/entry/presentation/entry_screens.dart';
import '../../features/member/presentation/activity_invoice_and_profile_screens.dart';
import '../../features/member/presentation/home_and_explore_screens.dart';
import '../../features/member/presentation/kos_detail_and_booking_screens.dart';
import '../../features/owner/presentation/owner_screens.dart';
import 'routes.dart';

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    ref.listen<AuthenticatedUser?>(
      sessionProvider,
      (_, _) => notifyListeners(),
    );
  }
}

CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 280),
    child: child,
    transitionsBuilder: (_, animation, _, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final session = ref.read(sessionProvider);
      final path = state.uri.path;
      final isOwner = session?.isOwner ?? false;

      if (path == AppRoutes.splash || path == AppRoutes.onboarding) {
        return null;
      }

      if (path.startsWith('/owner') && !isOwner) {
        return session == null ? AppRoutes.login : AppRoutes.home;
      }

      if (isOwner && path == AppRoutes.home) {
        return AppRoutes.ownerDashboard;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (context, state) => _fadePage(state, const SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        pageBuilder: (context, state) =>
            _fadePage(state, const OnboardingScreen()),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),

      // Member 5-Tab Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _MemberShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) =>
                    _fadePage(state, const HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.explore,
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.favorites,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.activity,
                builder: (context, state) => const MyActivityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Owner 4-Tab Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => _OwnerShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ownerDashboard,
                pageBuilder: (context, state) =>
                    _fadePage(state, const OwnerDashboardScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ownerKos,
                builder: (context, state) => const OwnerKosListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ownerBookings,
                builder: (context, state) => const OwnerBookingsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.ownerProfile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Detail & Transaction Standalone Routes
      GoRoute(
        path: '/kos/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return KosDetailScreen(kosId: id);
        },
      ),
      GoRoute(
        path: '/kos/:id/book',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return BookingFormScreen(kosId: id);
        },
      ),
      GoRoute(
        path: '/invoices/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return InvoiceDetailScreen(invoiceId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.ownerKosCreate,
        builder: (context, state) => const OwnerKosFormScreen(),
      ),
      GoRoute(
        path: '/owner/kos/:id/edit',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return OwnerKosFormScreen(existingKosId: id);
        },
      ),
    ],
  );
});

class _MemberShell extends StatelessWidget {
  const _MemberShell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.borderHairline)),
        ),
        child: BottomNavigationBar(
          currentIndex: shell.currentIndex,
          onTap: (i) =>
              shell.goBranch(i, initialLocation: i == shell.currentIndex),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.house, size: 20),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.search, size: 20),
              label: 'Eksplor',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.heart, size: 20),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.calendarCheck, size: 20),
              label: 'Aktivitas',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user, size: 20),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

class _OwnerShell extends StatelessWidget {
  const _OwnerShell({required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.borderHairline)),
        ),
        child: BottomNavigationBar(
          currentIndex: shell.currentIndex,
          onTap: (i) =>
              shell.goBranch(i, initialLocation: i == shell.currentIndex),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.layoutDashboard, size: 20),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.building2, size: 20),
              label: 'Properti',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.clipboardList, size: 20),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(LucideIcons.user, size: 20),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
