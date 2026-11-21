# Deployment & QA Checklist — TEMPATIN MOBILE

> Verification Baseline: **21 November 2026** | Application ID: `com.tempatin.mobile`

---

## 1. Verified Automated QA Results

| Layer | Command | Result | Scope |
| :--- | :--- | :--- | :--- |
| **Flutter Static Analysis** | `flutter analyze` | **0 issues found** (`3.3s`) | Full `lib/` + `test/` across Phases 1–10 |
| **Flutter Unit & Widget Tests** | `flutter test` | **21/21 passed** (`7s`) | `widget_test.dart`, `phase5_customer_test.dart`, `phase7_transaction_test.dart`, `phase8_9_owner_chat_test.dart` |
| **Android Release APK** | `flutter build apk --release` | **Passed** (`675.4s`) | `build/app/outputs/flutter-apk/app-release.apk` (`63.0 MB` / `66,036,167` bytes) |
| **Android Release App Bundle** | `flutter build appbundle --release` | **Passed** (`101.2s`) | `build/app/outputs/bundle/release/app-release.aab` (`60.9 MB` / `63,886,159` bytes) |
| **Laravel 12 Backend Suite** | `php artisan test` | **261 passed, 934 assertions** (`34.21s`) | Existing web suite + `MobileApiTest` (`feature/mobile-api`) |

---

## 2. Environment & Build Configuration (`--dart-define`)

`lib/core/config/env.dart` reads compile-time constants so no secrets or staging URLs are hardcoded in production binaries:

```powershell
# Local Physical Android Phone + Laravel Artisan Serve (Port 8000)
adb reverse tcp:8000 tcp:8000
flutter run --dart-define=ENV=dev --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1

# Production Release APK / AAB
flutter build appbundle --release `
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
