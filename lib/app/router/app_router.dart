import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/authentication/domain/auth_state.dart';
import '../../features/authentication/presentation/providers/auth_session_provider.dart';
import '../../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/register_screen.dart';
import '../../features/authentication/presentation/screens/reset_password_screen.dart';
import '../../features/booking/presentation/screens/booking_detail_screen.dart';
import '../../features/booking/presentation/screens/booking_form_screen.dart';
import '../../features/booking/presentation/screens/my_activity_screen.dart';
import '../../features/contracts/presentation/screens/contract_detail_screen.dart';
import '../../features/favorites/presentation/screens/favorites_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/maintenance/presentation/screens/create_maintenance_screen.dart';
import '../../features/messaging/presentation/screens/chat_screens.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/owner/presentation/screens/owner_analytics_and_more_screens.dart';
import '../../features/owner/presentation/screens/owner_booking_detail_screen.dart';
import '../../features/owner/presentation/screens/owner_bookings_screen.dart';
import '../../features/owner/presentation/screens/owner_dashboard_screen.dart';
import '../../features/owner/presentation/screens/owner_kos_form_screen.dart';
import '../../features/owner/presentation/screens/owner_kos_list_screen.dart';
import '../../features/owner/presentation/screens/owner_operations_screens.dart';
import '../../features/owner/presentation/screens/owner_rooms_screen.dart';
import '../../features/payment/presentation/screens/payment_screens.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/property/presentation/screens/explore_screen.dart';
import '../../features/property/presentation/screens/kos_detail_screen.dart';
import '../../features/property/presentation/screens/photo_gallery_viewer_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../shared/models/chat_models.dart';
import '../../shared/models/transaction_models.dart';
import '../../shared/models/user_model.dart';
import 'customer_shell.dart';
import 'owner_shell.dart';
import 'route_names.dart';

/// Listenable bridge so GoRouter refreshes redirects without recreating its instance.
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    ref.listen<AuthState>(authSessionProvider, (_, _) => notifyListeners());
  }
}

/// Role-aware GoRouter configuration separating Customer and Owner 5-tab shells.
final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  return GoRouter(
    initialLocation: RoutePaths.splash,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authSessionProvider);
      final path = state.uri.path;
      if (path == RoutePaths.splash) {
        return null;
      }

      final isAuthenticated = authState.isAuthenticated;
      final isOwner = authState.role == UserRole.owner;
      final isOwnerRoute = path.startsWith('/owner');
      final isAuthRoute =
          path == RoutePaths.login ||
          path == RoutePaths.register ||
          path == RoutePaths.forgotPassword ||
          path == RoutePaths.resetPassword;
      final requiresAuth =
          path == RoutePaths.editProfile ||
          path == RoutePaths.notifications ||
          path.startsWith('/bookings') ||
          path.startsWith('/chats') ||
          path.startsWith('/owner') ||
          path == RoutePaths.createMaintenance;

      if (requiresAuth && !isAuthenticated) {
        return RoutePaths.login;
      }

      if (isAuthRoute && isAuthenticated) {
        return isOwner ? RoutePaths.ownerDashboard : RoutePaths.home;
      }

      // Guard Owner routes from Guest/Customer
      if (isOwnerRoute && !isOwner) {
        return RoutePaths.home;
      }

      // Route authenticated Owners directly into the Owner shell from Customer home
      if (isOwner && path == RoutePaths.home) {
        return RoutePaths.ownerDashboard;
      }

      return null;
    },
    routes: [
      // Launch Splash Screen
      GoRoute(
        path: RoutePaths.splash,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 280),
          transitionsBuilder: (_, animation, _, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      ),

      // Customer / Guest 5-Tab Shell
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) =>
            CustomTransitionPage<void>(
              key: state.pageKey,
              child: CustomerShell(navigationShell: navigationShell),
              transitionDuration: const Duration(milliseconds: 320),
              transitionsBuilder: (_, animation, _, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.explore,
                builder: (context, state) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.favorites,
                builder: (context, state) => const FavoritesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.activity,
                builder: (context, state) => const MyActivityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.profile,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Property Owner 5-Tab Shell
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) =>
            CustomTransitionPage<void>(
              key: state.pageKey,
              child: OwnerShell(navigationShell: navigationShell),
              transitionDuration: const Duration(milliseconds: 320),
              transitionsBuilder: (_, animation, _, child) =>
                  FadeTransition(opacity: animation, child: child),
            ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerDashboard,
                builder: (context, state) => const OwnerDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerProperties,
                builder: (context, state) => const OwnerKosListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerBookings,
                builder: (context, state) => const OwnerBookingsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerMessages,
                builder: (context, state) => const ChatListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerMore,
                builder: (context, state) => const OwnerMoreScreen(),
              ),
            ],
          ),
        ],
      ),

      // Standalone Property Detail & Gallery
      GoRoute(
        path: '/kos/:slug',
        builder: (context, state) =>
            KosDetailScreen(slug: state.pathParameters['slug'] ?? ''),
      ),
      GoRoute(
        path: '/kos/:slug/gallery',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? const {};
          return PhotoGalleryViewerScreen(
            photoUrls: (extra['urls'] as List<String>?) ?? const [],
            initialIndex: (extra['index'] as int?) ?? 0,
            title: (extra['title'] as String?) ?? 'Galeri Foto',
          );
        },
      ),

      // Profile Edit & Notifications
      GoRoute(
        path: RoutePaths.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: RoutePaths.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),

      // Customer Transaction Flows (Owner Approval First)
      GoRoute(
        path: '/bookings/create/:slug',
        builder: (context, state) =>
            BookingFormScreen(kosSlug: state.pathParameters['slug'] ?? ''),
      ),
      GoRoute(
        path: '/bookings/:code',
        builder: (context, state) => BookingDetailScreen(
          bookingCode: state.pathParameters['code'] ?? '',
        ),
      ),
      GoRoute(
        path: '/bookings/:code/pay',
        builder: (context, state) => PaymentSummaryScreen(
          bookingCode: state.pathParameters['code'] ?? '',
          booking: state.extra is BookingModel
              ? state.extra as BookingModel
              : null,
        ),
      ),
      GoRoute(
        path: '/bookings/:code/contract',
        builder: (context, state) => ContractDetailScreen(
          bookingCode: state.pathParameters['code'] ?? '',
        ),
      ),
      GoRoute(
        path: RoutePaths.createMaintenance,
        builder: (context, state) => CreateMaintenanceScreen(
          initialBooking: state.extra is BookingModel
              ? state.extra as BookingModel
              : null,
        ),
      ),

      // Shared Messaging Routes
      GoRoute(
        path: RoutePaths.chats,
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: '/chats/:id',
        builder: (context, state) => ChatDetailScreen(
          conversationId: int.tryParse(state.pathParameters['id'] ?? '') ?? 0,
          initialConversation: state.extra is ConversationModel
              ? state.extra as ConversationModel
              : null,
        ),
      ),

      // Owner Operations & Management Routes
      GoRoute(
        path: RoutePaths.ownerKosCreate,
        builder: (context, state) => const OwnerKosFormScreen(),
      ),
      GoRoute(
        path: '/owner/kos/:slug/edit',
        builder: (context, state) => OwnerKosFormScreen(
          existingSlug: state.pathParameters['slug'] ?? '',
        ),
      ),
      GoRoute(
        path: '/owner/kos/:slug/rooms',
        builder: (context, state) =>
            OwnerRoomsScreen(kosSlug: state.pathParameters['slug'] ?? ''),
      ),
      GoRoute(
        path: '/owner/bookings/:code',
        builder: (context, state) => OwnerBookingDetailScreen(
          bookingCode: state.pathParameters['code'] ?? '',
        ),
      ),
      GoRoute(
        path: RoutePaths.ownerTenants,
        builder: (context, state) => const OwnerTenantsScreen(),
      ),
      GoRoute(
        path: RoutePaths.ownerSurveys,
        builder: (context, state) => const OwnerSurveysScreen(),
      ),
      GoRoute(
        path: RoutePaths.ownerMaintenance,
        builder: (context, state) => const OwnerMaintenanceScreen(),
      ),
      GoRoute(
        path: RoutePaths.ownerReviews,
        builder: (context, state) => const OwnerReviewsScreen(),
      ),
      GoRoute(
        path: RoutePaths.ownerAnalytics,
        builder: (context, state) => const OwnerAnalyticsScreen(),
      ),

      // Standalone Authentication Routes
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.resetPassword,
        builder: (context, state) =>
            ResetPasswordScreen(initialEmail: state.extra as String?),
      ),
    ],
  );
});
