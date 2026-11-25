import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/prefs_storage.dart';
import 'env.dart';

const String _offlineDemoModeKey = 'tempatin_offline_demo_mode';

/// Immutable app connectivity mode state.
class AppModeState {
  const AppModeState({required this.isOfflineDemo});

  final bool isOfflineDemo;

  String get modeLabel =>
      isOfflineDemo ? 'Mode Demo Offline (Lokal SQLite)' : 'Mode Terhubung Server';

  String get shortLabel => isOfflineDemo ? 'Demo Offline' : 'Live API';
}

/// Manages toggling between Offline Demo Mode (SQLite) and Connected Laravel API Mode.
class AppModeNotifier extends Notifier<AppModeState> {
  SharedPreferences? _readPrefsOrNull() {
    try {
      return ref.watch(sharedPreferencesProvider);
    } catch (_) {
      return null;
    }
  }

  @override
  AppModeState build() {
    final prefs = _readPrefsOrNull();
    final isOffline =
        prefs?.getBool(_offlineDemoModeKey) ?? AppEnv.defaultOfflineDemo;
    GoogleFonts.config.allowRuntimeFetching = !isOffline;
    return AppModeState(isOfflineDemo: isOffline);
  }

  Future<void> setOfflineDemo(bool value) async {
    final prefs = _readPrefsOrNull();
    if (prefs != null) {
      await prefs.setBool(_offlineDemoModeKey, value);
    }
    GoogleFonts.config.allowRuntimeFetching = !value;
    state = AppModeState(isOfflineDemo: value);
  }
}

final appModeProvider = NotifierProvider<AppModeNotifier, AppModeState>(
  AppModeNotifier.new,
);
