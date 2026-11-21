/// Build-time environment configuration supplied via `--dart-define`.
///
/// Physical device (recommended via `adb reverse tcp:8000 tcp:8000`):
/// `flutter run --dart-define=ENV=dev --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1`
///
/// Local LAN IP alternative:
/// `flutter run --dart-define=ENV=dev --dart-define=API_BASE_URL=http://192.168.x.x:8000/api/v1`
abstract final class AppEnv {
  static const String envName = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  /// Defaults to `127.0.0.1:8000` for physical Android USB debugging (`adb reverse tcp:8000 tcp:8000`).
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api/v1',
  );

  static bool get isDev => envName == 'dev';
  static bool get isProd => envName == 'prod';
}
