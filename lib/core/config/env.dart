/// Build-time environment configuration supplied via `--dart-define`.
///
/// Offline Demo Mode defaults to `true` so standalone APK/bundle installs
/// operate completely offline with local SQLite persistence, bundled assets,
/// and zero localhost/server requirements. Pass `--dart-define=OFFLINE_DEMO=false`
/// (or toggle from App Settings) to connect to a live Laravel REST backend.
abstract final class AppEnv {
  static const String envName = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  static const bool defaultOfflineDemo = bool.fromEnvironment(
    'OFFLINE_DEMO',
    defaultValue: true,
  );

  /// Defaults to `127.0.0.1:8000` for physical Android USB debugging (`adb reverse tcp:8000 tcp:8000`).
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api/v1',
  );

  static bool get isDev => envName == 'dev';
  static bool get isProd => envName == 'prod';
}
