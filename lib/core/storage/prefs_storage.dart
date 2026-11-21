import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_keys.dart';

/// Non-sensitive local preferences (recent searches, onboarding flag).
class PrefsStorageService {
  const PrefsStorageService(this._prefs);

  final SharedPreferences _prefs;

  List<String> getRecentSearches() =>
      _prefs.getStringList(StorageKeys.recentSearches) ?? const [];

  Future<void> saveRecentSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    final current = List<String>.from(getRecentSearches())
      ..removeWhere((item) => item.toLowerCase() == trimmed.toLowerCase())
      ..insert(0, trimmed);
    await _prefs.setStringList(
      StorageKeys.recentSearches,
      current.take(8).toList(),
    );
  }

  Future<void> clearRecentSearches() =>
      _prefs.remove(StorageKeys.recentSearches);

  bool get onboardingSeen =>
      _prefs.getBool(StorageKeys.onboardingSeen) ?? false;

  Future<void> setOnboardingSeen() =>
      _prefs.setBool(StorageKeys.onboardingSeen, true);
}

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider must be overridden at app bootstrap.',
  ),
);

final prefsStorageProvider = Provider<PrefsStorageService>(
  (ref) => PrefsStorageService(ref.watch(sharedPreferencesProvider)),
);
