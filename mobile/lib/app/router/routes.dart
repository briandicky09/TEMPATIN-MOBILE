abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';

  static const String home = '/home';
  static const String explore = '/explore';
  static const String favorites = '/favorites';
  static const String activity = '/activity';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String notifications = '/notifications';

  static String kosDetail(int id) => '/kos/$id';
  static String bookingForm(int kosId) => '/kos/$kosId/book';
  static String invoiceDetail(int invoiceId) => '/invoices/$invoiceId';

  static const String ownerDashboard = '/owner/dashboard';
  static const String ownerKos = '/owner/kos';
  static const String ownerKosCreate = '/owner/kos/create';
  static String ownerKosEdit(int kosId) => '/owner/kos/$kosId/edit';
  static const String ownerBookings = '/owner/bookings';
  static const String ownerProfile = '/owner/profile';
}
