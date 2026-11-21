/// Storage keys for FlutterSecureStorage and SharedPreferences.
abstract final class StorageKeys {
  // Secure storage (sensitive)
  static const String authToken = 'tempatin_sanctum_token';

  // SharedPreferences (non-sensitive)
  static const String recentSearches = 'tempatin_recent_searches';
  static const String onboardingSeen = 'tempatin_onboarding_seen';
}
