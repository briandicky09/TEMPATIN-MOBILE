/// Centralized REST API endpoints matching `docs/API_CONTRACT.md` (`/api/v1`).
abstract final class ApiEndpoints {
  // Authentication
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String googleAuth = '/auth/google';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String me = '/auth/me';
  static const String logout = '/auth/logout';

  // Profile & Notifications
  static const String profile = '/profile';
  static const String notifications = '/notifications';
  static String markNotificationRead(String id) => '/notifications/$id/read';
  static const String markAllNotificationsRead = '/notifications/read-all';

  // Public & Customer Discovery
  static const String home = '/home';
  static const String facilities = '/facilities';
  static const String kosList = '/kos';
  static String kosDetail(String slug) => '/kos/$slug';
  static String kosReviews(String slug) => '/kos/$slug/reviews';

  // Favorites
  static const String favorites = '/favorites';
  static const String toggleFavorite = '/favorites/toggle';

  // Customer Bookings, Payments, Invoices & Contracts (Owner Approval First)
  static const String bookings = '/bookings';
  static String bookingDetail(String code) => '/bookings/$code';
  static String cancelBooking(String code) => '/bookings/$code/cancel';
  static String payBooking(String code) => '/bookings/$code/pay';
  static String syncPayment(String paymentCode) =>
      '/payments/$paymentCode/sync';
  static String bookingNotaPdf(String code) => '/bookings/$code/nota-pdf';
  static String bookingContract(String code) => '/bookings/$code/contract';
  static String signContract(String contractNumber) =>
      '/contracts/$contractNumber/sign';
  static String contractPdf(String contractNumber) =>
      '/contracts/$contractNumber/pdf';
  static const String invoices = '/invoices';
  static String invoiceDetail(String invoiceNumber) =>
      '/invoices/$invoiceNumber';

  // Surveys, Maintenance & Chat
  static const String surveys = '/surveys';
  static String scheduleSurvey(String slug) => '/kos/$slug/surveys';
  static String cancelSurvey(int id) => '/surveys/$id/cancel';
  static const String maintenanceReports = '/maintenance-reports';
  static const String conversations = '/conversations';
  static String startConversation(String slug) => '/kos/$slug/conversations';
  static String conversationMessages(int id) => '/conversations/$id/messages';

  // Owner Management
  static const String ownerDashboard = '/owner/dashboard';
  static const String ownerKos = '/owner/kos';
  static String ownerKosDetail(String slug) => '/owner/kos/$slug';
  static String ownerKosRooms(String slug) => '/owner/kos/$slug/rooms';
  static String ownerKosRoom(String slug, int roomId) =>
      '/owner/kos/$slug/rooms/$roomId';
  static const String ownerBookings = '/owner/bookings';
  static String ownerBookingDetail(String code) => '/owner/bookings/$code';
  static String ownerBookingApprove(String code) =>
      '/owner/bookings/$code/approve';
  static String ownerBookingReject(String code) =>
      '/owner/bookings/$code/reject';
  static String ownerBookingCheckIn(String code) =>
      '/owner/bookings/$code/checkin';
  static String ownerBookingCheckOut(String code) =>
      '/owner/bookings/$code/checkout';
  static const String ownerTenants = '/owner/tenants';
  static const String ownerSurveys = '/owner/surveys';
  static String ownerSurveyStatus(int id) => '/owner/surveys/$id/status';
  static const String ownerMaintenance = '/owner/maintenance-reports';
  static String ownerMaintenanceStatus(int id) =>
      '/owner/maintenance-reports/$id/status';
  static const String ownerReviews = '/owner/reviews';
  static String ownerReplyReview(int id) => '/owner/reviews/$id/reply';
  static const String ownerAnalytics = '/owner/analytics';
}
