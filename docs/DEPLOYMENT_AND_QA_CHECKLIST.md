# Deployment & QA Checklist — TEMPATIN MOBILE

> Verification Baseline: **25 November 2026** | Application ID: `com.tempatin.mobile`

---

## 1. Verified Automated QA Results

| Layer | Command | Result | Scope |
| :--- | :--- | :--- | :--- |
| **Flutter Static Analysis** | `flutter analyze` | **0 issues found** (`11.8s`) | Full `lib/` + `test/` (incl. Final Polish & Offline Demo SQLite layer) |
| **Flutter Unit, E2E & Widget Tests** | `flutter test` | **26/26 passed** (`11s`) | `offline_demo_polish_test.dart`, `widget_test.dart`, `phase5_customer_test.dart`, `phase7_transaction_test.dart`, `phase8_9_owner_chat_test.dart` |
| **Android Release APK** | `flutter build apk --release` | **Passed** (`295.6s`) | `build/app/outputs/flutter-apk/app-release.apk` (`73.8 MB` / `77,374,361` bytes) |
| **Android Release App Bundle** | `flutter build appbundle --release` | **Passed** (`66.0s`) | `build/app/outputs/bundle/release/app-release.aab` (`71.5 MB` / `74,947,156` bytes) |
| **Physical Device Check** | `adb devices -l` | **0 devices attached** | Hardware USB runtime check pending physical Android device attachment |
| **Laravel 12 Backend Suite** | `php artisan test` | **261 passed, 934 assertions** *(prior Phase 6 run)* | Existing web suite + `MobileApiTest` (`feature/mobile-api`) |

---

## 2. Final Polish & Dual-Mode Architecture Summary

- **Branding & Icons**: Vector SVG masters in `assets/branding/` (`tempatin_symbol.svg`, `tempatin_logo.svg`, `tempatin_icon_foreground.svg`), supersampled raster exports (`app_icon_1024.png`, `app_icon_foreground_1024.png`, `splash_symbol_512.png`, `assets/images/logo.png`, `logo-symbol.png`), and Android/iOS launcher icons generated via `flutter_launcher_icons`.
- **Native & Animated Splash**: Android 12+ splash & launch background configured via `flutter_native_splash` (`#F6F5F4`), transitioning seamlessly into animated `SplashScreen` (`/splash`, 1.35s fade/scale/accent-line/wordmark) with session restore timeout safety.
- **Offline-First Demo Mode (Default)**: Persistent local SQLite database (`OfflineDemoDatabase` via `sqflite`) seeded idempotently with realistic Indonesian kos listings, bundled photos (`assets/images/kos/*`), full `/api/v1/*` in-process handling (`OfflineDemoInterceptor`), offline PDF generation (`OfflineDemoPdfBuilder` via `pdf`), simulated Demo Offline payment confirmation, offline architectural coordinate map fallback/preset picker, runtime font HTTP disabled offline (`GoogleFonts.config.allowRuntimeFetching = false`), 1-tap demo login helpers, and runtime *Mode Switcher* + *Reset Data Demo*.

---

## 3. Environment & Build Configuration (`--dart-define`)

`lib/core/config/env.dart` reads compile-time constants (`OFFLINE_DEMO` defaults to `true` for standalone offline APK/demo usage):

```powershell
# Standalone Offline Demo Build (Default)
flutter build apk --release

# Local Physical Android Phone + Laravel Artisan Serve (Port 8000, Live API Mode)
adb reverse tcp:8000 tcp:8000
flutter run --dart-define=OFFLINE_DEMO=false --dart-define=ENV=dev --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1

# Production Release APK / AAB Connected to Live Server
flutter build appbundle --release `
  --dart-define=OFFLINE_DEMO=false `
  --dart-define=ENV=prod `
  --dart-define=API_BASE_URL=https://api.tempatin.example.com/api/v1
```

> **Security Note**: `android/app/src/debug/AndroidManifest.xml` enables `usesCleartextTraffic="true"` strictly for **debug** builds (`127.0.0.1` over `adb reverse`). Production release manifests keep HTTPS enforcement active. Midtrans Server Key never leaves Laravel.

---

## 3. Android Release Keystore Setup (Required Before Play Console Upload)

Currently `android/app/build.gradle.kts` references `signingConfigs.getByName("debug")` so local release compilation succeeds. Before publishing to Google Play:

1. Generate upload keystore outside Git:
   ```powershell
   keytool -genkey -v -keystore android/app/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```
2. Create `android/key.properties` (git-ignored):
   ```properties
   storePassword=<YOUR_STORE_PASSWORD>
   keyPassword=<YOUR_KEY_PASSWORD>
   keyAlias=upload
   storeFile=upload-keystore.jks
   ```
3. Configure `signingConfigs { create("release") { ... } }` inside `android/app/build.gradle.kts` to load `key.properties`.

---

## 4. Pending External / Hardware Prerequisites

1. **Physical Android Runtime Verification**: `adb devices -l` reported `0` devices attached during final QA. Connect a physical Android device with USB Debugging enabled, run `adb reverse tcp:8000 tcp:8000`, and verify live login, booking approval, Midtrans Sandbox WebView payment + sync, camera/gallery photo upload, and OSM map rendering.
2. **Backend Git Review & Merge**: Changes in `C:\Users\Thinkpad\Downloads\TEMPATIN` are uncommitted on branch `feature/mobile-api` awaiting owner review before commit/merge.
3. **Production Database & Midtrans Keys**: Local dev & PHPUnit run on SQLite (`database/database.sqlite` & `database/testing.sqlite`). Production server `.env` must configure MySQL 8 and live/sandbox `MIDTRANS_SERVER_KEY`, `MIDTRANS_CLIENT_KEY`, and `MIDTRANS_IS_PRODUCTION`.
4. **Google OAuth Sign-In (`google_sign_in`)**: Excluded cleanly from `pubspec.yaml` and `/api/v1` because `GOOGLE_CLIENT_ID` / SHA-1 credentials were absent from environment configuration.
5. **iOS Release Archive**: `ios/Runner/Info.plist` includes camera and photo library usage descriptions, while IPA archiving requires macOS + Xcode + Apple Developer certificates.
