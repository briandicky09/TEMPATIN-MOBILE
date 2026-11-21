/// Centralized route paths for GoRouter across Guest, Customer, and Owner flows.
abstract final class RoutePaths {
  // Customer / Guest 5-tab shell
  static const String home = '/home';
  static const String explore = '/explore';
  static const String favorites = '/favorites';
  static const String activity = '/activity';
  static const String profile = '/profile';

  // Property Detail & Gallery
  static String kosDetail(String slug) => '/kos/$slug';
  static String kosGallery(String slug) => '/kos/$slug/gallery';

  // Profile & Notifications
  static const String editProfile = '/profile/edit';
  static const String notifications = '/notifications';

  // Phase 7 — Customer Transactions
  static String bookingCreate(String slug) => '/bookings/create/$slug';
  static String bookingDetail(String code) => '/bookings/$code';
  static String bookingPay(String code) => '/bookings/$code/pay';
  static String bookingContract(String code) => '/bookings/$code/contract';
  static const String createMaintenance = '/maintenance/create';

  // Phase 9 — Messaging
  static const String chats = '/chats';
  static String chatDetail(int id) => '/chats/$id';

  // Authentication
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // Owner 5-tab shell
  static const String ownerDashboard = '/owner/dashboard';
  static const String ownerProperties = '/owner/kos';
  static const String ownerBookings = '/owner/bookings';
  static const String ownerMessages = '/owner/messages';
  static const String ownerMore = '/owner/more';

  // Phase 8 — Owner Operations & Analytics
  static const String ownerKosCreate = '/owner/kos/create';
  static String ownerKosEdit(String slug) => '/owner/kos/$slug/edit';
  static String ownerKosRooms(String slug) => '/owner/kos/$slug/rooms';
  static String ownerBookingDetail(String code) => '/owner/bookings/$code';
  static const String ownerTenants = '/owner/tenants';
  static const String ownerSurveys = '/owner/surveys';
  static const String ownerMaintenance = '/owner/maintenance';
  static const String ownerReviews = '/owner/reviews';
  static const String ownerAnalytics = '/owner/analytics';
}
