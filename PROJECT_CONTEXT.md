# PROJECT CONTEXT: TEMPATIN MOBILE

> **Dokumentasi Konteks Komprehensif Proyek Aplikasi Mobile Cross-Platform TEMPATIN (Flutter & Dart — Android & iOS)**
>
> *Terakhir diperbarui: 28 November 2026 | Status Proyek: **Phase 1–10 + Final Product Polish & Dual-Mode Offline-First Demo Selesai — Lolos `flutter analyze` (0 issues), 26/26 Tests, Release APK/AAB Build, & Terinstal di Perangkat Android Fisik (`TECNO_LJ6`)***

---

## 1. Ikhtisar Proyek & Visi Bisnis

**TEMPATIN MOBILE** adalah aplikasi mobile cross-platform (**Android & iOS**) berbasis **Flutter & Dart** untuk ekosistem platform pencarian, pemesanan, dan pengelolaan rumah kos **TEMPATIN**.

Aplikasi ini dibangun sebagai produk mobile native tersendiri (terpisah dari proyek web referensi Laravel 12 di `C:\Users\Thinkpad\Downloads\TEMPATIN`), bukan sekadar konversi webview responsif.

### Prinsip Arsitektur Utama (Dual-Mode Operation)
1. **Offline-First Demo Mode (`OFFLINE_DEMO=true` — Default APK Rilis Mandiri)**:
   - Aplikasi berjalan **100% lokal di perangkat** tanpa membutuhkan server Laravel, `localhost`, maupun koneksi internet.
   - Menggunakan database SQLite lokal persisten (`tempatin_demo.db` via `sqflite`, 18 tabel relasional) dan `OfflineDemoInterceptor` pada `Dio` yang menangani seluruh endpoint `/api/v1/*` secara *in-process*.
   - Seluruh foto kos dibundel di APK (`assets/images/kos/*`), pembuatan Nota & Kontrak PDF berjalan lokal (`package:pdf`), runtime HTTP font dinonaktifkan (`GoogleFonts.config.allowRuntimeFetching = false`), pembayaran disimulasikan secara aman tanpa membuka Midtrans WebView, dan peta menggunakan fallback koordinat offline.
   - Mode dapat diubah kapan saja melalui sakelar **Pengaturan & Informasi** pada tab **Profil** (Customer) atau **Lainnya** (Owner), lengkap dengan fitur **Reset Data Demo Offline**.
2. **Connected Live API Mode (`OFFLINE_DEMO=false`)**:
   - Terhubung langsung ke backend **Laravel 12 + Sanctum REST API (`/api/v1`)** sebagai *Single Source of Truth* untuk database MySQL/SQLite server, Midtrans Snap WebView checkout, dan peta OpenStreetMap + Nominatim interaktif.
3. **Isolasi Proyek & Workspace**:
   - Folder `C:\Users\Thinkpad\Downloads\TEMPATIN` (Laravel 12, branch `feature/mobile-api`) tetap terisolasi dan tidak dimodifikasi oleh aplikasi mobile.
   - Folder `mobile/` di dalam repo adalah arsip prototipe standalone awal (Drift) yang terpisah dan tidak ikut dibuild oleh proyek root (`TEMPATIN MOBILE`).

---

## 2. Status Progres Fase (`MOBILE_ROADMAP.md`)

| Fase | Nama Fase | Status | Ringkasan Hasil |
| :--- | :--- | :--- | :--- |
| **Phase 1** | Project Discovery | **Selesai** | Audit menyeluruh 17 controller, 15 model, 26 migrasi, 2 seeder, 2 policy, 5 FormRequest, `MidtransService`, `TempatinNotification`, dan CSS/Blade Laravel. |
| **Phase 2** | Documentation | **Selesai** | Dokumen teknis arsitektur, database, API contract, design system, dan roadmap di `docs/`. |
| **Phase 3** | Mobile Design | **Selesai** | Spesifikasi UI/UX *Notion Warm Paper Hybrid* ([MOBILE_DESIGN_SPEC.md](docs/MOBILE_DESIGN_SPEC.md)) & alur *Owner Approval First* di [API_CONTRACT.md](docs/API_CONTRACT.md). |
| **Phase 4** | Flutter Foundation & Env | **Selesai** | Setup Flutter `3.50.0` + Dart `3.14.0`, Android SDK minimal, arsitektur `lib/`, theme, GoRouter, Dio, Riverpod, dan verifikasi build APK Debug + Release. |
| **Phase 5** | Customer Mobile Core | **Selesai** | Auth UI (Login, Register, Forgot/Reset Password), Home, Eksplor + Filter Bottom Sheet, Detail Kos + Galeri, Favorit, Profil & Edit Profil, Notifikasi. |
| **Phase 6** | Backend API & Integration | **Selesai** | Laravel Sanctum + `/api/v1` (branch `feature/mobile-api`), normalisasi URL aset, perbaikan bug Midtrans (`approved -> confirmed`), room IDOR, nota/kontrak/SVG guards, 261 PHPUnit tests pass. |
| **Phase 7** | Transaction Features | **Selesai** | Room selection, Booking (*Owner Approval First*), Midtrans Snap WebView + sync, Invoice, Nota PDF (`printing`/`share_plus`), Kontrak Digital & PDF, Survei, Maintenance, Review. |
| **Phase 8** | Owner Mobile | **Selesai** | Owner Dashboard live, CRUD Properti + Foto, Room Inventory, Approve/Reject/Check-In/Check-Out, Penghuni Aktif, Survei, Maintenance, Ulasan + Balasan, Analitik `fl_chart`. |
| **Phase 9** | Advanced Features | **Selesai** | Peta `flutter_map` (OSM + Nominatim), Internal Chat (paginated REST + `after_id` polling saat screen aktif), Notifikasi deep-link routing. |
| **Phase 10** | Quality Assurance | **Selesai** | `flutter analyze` (0 issue), 21/21 test awal pass, 261 PHPUnit tests pass, Release APK & AAB awal terverifikasi. |
| **Final Polish** | Branding, Splash & Dual-Mode Offline Demo | **Selesai & Terinstal di HP** | Redesain logo vektor & adaptive launcher icon (`flutter_launcher_icons`), native Android 12+ + animated splash (`/splash`, `1.35s`), **Dual-Mode Offline-First Demo** (`sqflite` 18 tabel + `OfflineDemoInterceptor` + `OfflineDemoPdfBuilder` + 13 foto kos lokal `assets/images/kos/`), `AppSmartImage`, pembayaran simulasi offline-safe, peta offline fallback & preset kota, 1-tap demo login, mode switcher & reset demo, `flutter analyze` (0 issue), **26/26** Flutter tests pass, Release APK (`73.8 MB` / `77,374,361` bytes) & Release AAB (`71.5 MB` / `74,947,156` bytes), serta terinstal & diluncurkan di HP fisik **TECNO_LJ6** (`142965556A102985`). |

---

## 3. Tech Stack & Dependensi (`pubspec.yaml`)

| Komponen | Teknologi / Paket | Versi Constraint | Keterangan |
| :--- | :--- | :--- | :--- |
| **Framework & Bahasa** | Flutter & Dart | `3.50.0` (stable) / `^3.14.0` | SDK di `C:\src\flutter` |
| **UI Core** | `material_ui`, `cupertino_icons` | `^1.1.0`, `^1.0.8` | Material 3 + iOS icon compatibility |
| **State Management** | `flutter_riverpod` | `^3.5.0` | Reactive state, DI, dan mode switching |
| **Navigasi** | `go_router` | `^18.1.4` | Declarative routing + `StatefulShellRoute` + fade transition |
| **Networking** | `dio` | `^5.11.1` | HTTP client, `AuthInterceptor`, `OfflineDemoInterceptor`, multipart, PDF bytes |
| **Offline Database** | `sqflite`, `path` | `^2.4.1`, `^1.9.0` | Database SQLite persisten (`tempatin_demo.db`) |
| **Immutability & JSON** | `freezed_annotation`, `json_annotation` | `^3.1.0`, `^4.12.0` | Codegen via `build_runner`, `freezed`, `json_serializable` |
| **Local Storage** | `flutter_secure_storage`, `shared_preferences` | `^11.2.0`, `^2.5.6` | Token terenkripsi & preferensi mode/pencarian |
| **UI, Font, Ikon & Gambar** | `google_fonts`, `lucide_icons_flutter`, `flutter_svg`, `cached_network_image` | `^9.0.0`, `^4.0.3`, `^2.4.0`, `^4.0.7` | Inter + Source Serif 4, Lucide icons, SVG, hybrid image caching |
| **Formatting & Grafik** | `intl`, `fl_chart` | `^0.20.3`, `^1.3.1` | Format Rupiah (`Rp 850.000`), tanggal `id_ID`, grafik pendapatan |
| **Maps & Lokasi** | `flutter_map`, `latlong2`, `url_launcher` | `^8.3.2`, `^0.10.1`, `^6.3.3` | Peta OSM + Nominatim (Live) & grid/preset koordinat (Offline) |
| **Pembayaran & WebView** | `webview_flutter` | `^4.14.1` | Midtrans Snap checkout (Live Mode) |
| **Media & PDF** | `image_picker`, `flutter_image_compress`, `pdf`, `printing`, `share_plus`, `path_provider` | `^1.2.4`, `^2.5.1`, `^3.11.0`, `^5.15.1`, `^13.3.1`, `^2.1.6` | Upload foto, generator PDF lokal offline, viewer/cetak/share PDF |
| **Branding & Splash (Dev)** | `flutter_launcher_icons`, `flutter_native_splash` | `^0.14.3`, `^2.4.4` | Generate adaptive launcher icon & Android 12+/iOS splash |
| **Testing & Lint (Dev)** | `flutter_test`, `mocktail`, `sqflite_common_ffi`, `flutter_lints` | `^1.0.5`, `^2.3.4`, `^6.0.0` | Unit, widget, & in-memory SQLite E2E testing |

---

## 4. Environment Pengembangan & Verifikasi Perangkat Fisik

Environment dioptimasi untuk workflow **Physical Android Device + APK Compilation** (tanpa emulator/AVD):

- **OS & IDE**: Windows 10/11 64-bit, **Antigravity IDE** dengan ekstensi `dart-code.flutter` & `dart-code.dart-code`.
- **Android SDK Minimal** (`%LOCALAPPDATA%\Android\Sdk`):
  - `platform-tools` (`adb.exe`), `cmdline-tools\latest` (`sdkmanager`)
  - `platforms\android-36` (`compileSdkVersion = 36`, `targetSdkVersion = 36`), `build-tools\36.0.0`
  - `ndk\28.2.13676358` & `cmake\3.22.1`
- **Java / JDK**: Bundled OpenJDK `25.0.4` (`C:\src\android-studio\jbr`).
- **Konfigurasi Android Project**:
  - `applicationId`: `com.tempatin.mobile`
  - `minSdk`: `>= 23` (syarat `flutter_secure_storage`)
  - `android:label`: `TEMPATIN`
- **Perangkat Fisik Terverifikasi**:
  - Perangkat: **TECNO_LJ6** (Serial ADB: `142965556A102985`, `product:LJ6-OP`).
  - Instalasi & peluncuran `build/app/outputs/flutter-apk/app-release.apk` via `adb install -r` berhasil (`Success`, package `com.tempatin.mobile` diluncurkan).

---

## 5. Role Pengguna & Navigasi Utama

| Role (`users.role`) | Scope Mobile | Navigasi Utama |
| :--- | :--- | :--- |
| **Guest / Customer (`customer`)** | **Prioritas Utama (Core)** | 5-Tab Bottom Nav: `Beranda`, `Eksplor`, `Favorit`, `Aktivitas` *(Booking, Invoice, Survei, Kerusakan)*, `Profil`. |
| **Property Owner (`owner`)** | **Prioritas Utama (Core)** | 5-Tab Bottom Nav: `Dashboard`, `Properti`, `Booking` *(Approval, Check-In/Out, Penghuni)*, `Pesan`, `Lainnya` *(Survei, Kerusakan, Ulasan, Statistik, Notifikasi, Pengaturan Mode, Profil)*. |
| **Superadmin (`admin`)** | **Web-First** | Tetap menggunakan website Laravel (`/admin/*`). |

### Akun Demo Offline & Seeder Default
| Role | Email | Password | Keterangan |
| :--- | :--- | :--- | :--- |
| **Customer** | `dewi@email.com` | `password123` | Tersedia tombol isi cepat 1-ketuk di `LoginScreen` saat Mode Demo Offline aktif |
| **Owner** | `owner@tempatin.id` | `password123` | Tersedia tombol isi cepat 1-ketuk di `LoginScreen` saat Mode Demo Offline aktif |
| **Extra Customer** | `rafi@email.com` | `password123` | Akun penyewa/reviewer tambahan pada seed database offline |

---

## 6. Alur Bisnis Terkunci

### 6.1 Alur Booking & Pembayaran (*Owner Approval First*)
1. **Customer** memilih kos (dan opsional kamar `room_id`), menentukan `start_date` dan `duration_months` (1–12).
2. Sistem menghitung `subtotal = price * duration_months`, `admin_fee = 25000`, `total_amount = subtotal + admin_fee`, `end_date`, lalu membuat `Booking` berstatus **`pending`** + `Invoice` **`unpaid`**.
3. **Owner** meninjau booking:
   - **Setujui (`approve`)**: status menjadi **`approved`** (dapat menetapkan `room_id`).
   - **Tolak (`reject`)**: status menjadi **`rejected`** (wajib `rejection_reason`), invoice dibatalkan.
   - *(Customer dapat membatalkan selama masih `pending` -> `cancelled`.)*
4. **Pembayaran** hanya dapat dimulai jika status booking **`approved`**:
   - **Offline Demo Mode**: `PaymentSummaryScreen` menampilkan banner simulasi lokal dan tombol *"Konfirmasi Pembayaran Demo Offline"* tanpa membuka Midtrans WebView, memverifikasi transaksi di SQLite (`payment -> success`, `invoice -> paid`, `booking -> confirmed`), dan otomatis membuat kontrak sewa.
   - **Live API Mode**: membuka `MidtransWebViewScreen` (`snap_redirect_url`) lalu sinkronisasi idempotent `GET /api/v1/payments/{code}/sync`.
5. **Check-In & Check-Out**: Owner memproses check-in (`confirmed` -> `active`, kamar -> `occupied`) dan check-out (`active` -> `completed`, kamar -> `available`).

### 6.2 Fitur Pendukung
- **Kontrak Sewa Digital (`CTR-...`)**: Dibuat otomatis saat booking terkonfirmasi, mendukung tanda tangan elektronik (`is_signed`, `signed_at`, `signer_ip`), dan ekspor PDF (DomPDF di server atau `OfflineDemoPdfBuilder` secara lokal).
- **Nota Pembayaran PDF**: Dapat dilihat, dicetak, dan dibagikan (`PdfViewerScreen` + `printing` + `share_plus`).
- **Survei Lokasi**: Customer menjadwalkan survei; Owner menyetujui/menolak/menyelesaikan; Customer dapat membatalkan selama `pending`.
- **Laporan Kerusakan (`MaintenanceReport`)**: Penghuni mengirim laporan + foto; Owner memperbarui status (`open` -> `in_progress` / `resolved` / `rejected`) + `owner_notes`.
- **Ulasan Terverifikasi (`Review`)**: Penghuni memberi rating 1–5 & komentar; Owner dapat membalas ulasan.
- **Chat Internal**: Percakapan Customer ↔ Owner per properti (polling `after_id` 6 detik aktif di Live Mode dan dinonaktifkan di Offline Demo Mode).
- **Notifikasi**: Daftar notifikasi dengan status baca & deep-link routing per kategori.

---

## 7. Brand Identity, Splash Screen & Sistem Desain (*Notion Warm Paper Hybrid*)

- **Palet Warna (`AppColors`)**:
  - Primary CTA & Brand: `#0075DE` (`AppColors.primary`)
  - Canvas Halaman: `#F6F5F4` (`AppColors.canvas` — *Paper Warmth*)
  - Permukaan Kartu & Bottom Nav: `#FFFFFF` (`AppColors.surface`)
  - Hairline Border: `rgba(0, 0, 0, 0.08)` (`AppColors.borderHairline`)
  - Teks: `#000000` (`inkPrimary`), `#615D59` (`inkBody`), `#757575` (`inkSecondary`)
  - Semantic Badges: Emerald (`#EDF7EE`/`#166534`), Marigold (`#FEF9C3`/`#854D0E`), Coral (`#FEE2E2`/`#991B1B`), Sky Tint (`#E6F3FE`/`#0054A3`)
- **Tipografi (`AppTypography`)**: **Inter** (`displaySm 28sp` hingga `caption 12sp`) dan **Source Serif 4** untuk subhead editorial.
- **Logo & Ikon Aplikasi (`assets/branding/`)**:
  - Master vektor SVG (`tempatin_symbol.svg`, `tempatin_icon_foreground.svg`, `tempatin_logo.svg`) dan raster *4x-supersampled* (`app_icon_1024.png`, `app_icon_foreground_1024.png`, `splash_symbol_512.png`, `assets/images/logo.png`, `assets/images/logo-symbol.png`).
  - Adaptive Android launcher icon & iOS app icon dihasilkan via `flutter_launcher_icons`.
- **Native & Animated Splash (`SplashScreen` -> `/splash`)**:
  - Native launch background `#F6F5F4` + `splash_symbol_512.png` (Android 12+ & iOS via `flutter_native_splash`).
  - Transisi mulus ke `SplashScreen` dengan animasi `1350ms` (fade + scale logo, progress garis aksen `#0075DE`, slide + fade wordmark `"TEMPATIN"`, serta badge `"Offline-First Demo Ready"`), terkoordinasi aman dengan `AuthSessionNotifier.restoreSession()` (timeout guard `500ms`/`800ms`) sebelum fade ke `/home` atau `/owner/dashboard`.

---

## 8. Arsitektur Aplikasi & Struktur Direktori (`TEMPATIN MOBILE`)

```text
TEMPATIN MOBILE/
├── android/                                # Konfigurasi Android (com.tempatin.mobile, minSdk >= 23, adaptive icons & splash)
├── ios/                                    # Konfigurasi iOS (runner icons & splash)
├── assets/
│   ├── branding/                           # tempatin_symbol.svg, tempatin_logo.svg, tempatin_icon_foreground.svg,
│   │                                       # app_icon_1024.png, app_icon_foreground_1024.png, splash_symbol_512.png
│   └── images/
│       ├── logo.png, logo-symbol.png, city-skyline.svg
│       └── kos/                            # kos_001.png..kos_007.png, detail_01.jpg..detail_05.jpg, placeholder.jpg
├── docs/                                   # 10 dokumen teknis Phase 1–10 & Deployment/QA
├── lib/
│   ├── app/
│   │   ├── app.dart                        # Root TempatinApp (MaterialApp.router + AppTheme.light)
│   │   ├── router/
│   │   │   ├── app_router.dart             # GoRouter, initialLocation: /splash, fade transitions, role guards
│   │   │   ├── route_names.dart            # Konstanta RoutePaths
│   │   │   ├── customer_shell.dart         # 5-tab Customer bottom nav shell
│   │   │   └── owner_shell.dart            # 5-tab Owner bottom nav shell
│   │   └── theme/                          # app_colors.dart, app_spacing.dart, app_typography.dart, app_theme.dart
│   ├── core/
│   │   ├── config/
│   │   │   ├── env.dart                    # --dart-define ENV, OFFLINE_DEMO (default true), API_BASE_URL
│   │   │   └── app_mode_provider.dart      # AppModeNotifier (toggle Offline Demo <-> Live API, font HTTP guard)
│   │   ├── constants/                      # api_endpoints.dart, storage_keys.dart
│   │   ├── errors/                         # app_exception.dart, error_mapper.dart
│   │   ├── network/
│   │   │   ├── api_response.dart           # ApiResponse<T> & PaginationMeta
│   │   │   ├── auth_interceptor.dart       # Bearer token injection & 401 handler
│   │   │   └── dio_client.dart             # dioProvider (AuthInterceptor + OfflineDemoInterceptor)
│   │   ├── offline/
│   │   │   ├── offline_demo_database.dart  # SQLite 18 tabel + seed data + resetDemoData()
│   │   │   ├── offline_demo_interceptor.dart # Handler in-process seluruh endpoint /api/v1/*
│   │   │   └── offline_demo_pdf_builder.dart # Generator PDF Nota & Kontrak offline (package:pdf)
│   │   ├── storage/                        # secure_storage.dart, prefs_storage.dart
│   │   ├── utils/                          # currency_formatter, date_formatter, facility_icon_mapper, json_converters, status_mapper, validators
│   │   └── widgets/                        # app_bottom_sheet, app_empty_state, skeletons, status_badge, tempatin_button (press scale), tempatin_card, tempatin_text_field
│   ├── features/
│   │   ├── splash/                         # SplashScreen (/splash)
│   │   ├── authentication/                 # AuthSessionNotifier (memoized restoreSession), Login (1-tap demo), Register, Forgot/Reset Password
│   │   ├── home/                           # HomeScreen + Demo Offline badge + chat shortcut
│   │   ├── property/                       # ExploreScreen, FilterBottomSheet, KosDetailScreen, PhotoGalleryViewerScreen
│   │   ├── favorites/                      # FavoritesScreen & toggle provider
│   │   ├── booking/                        # BookingFormScreen, BookingDetailScreen, MyActivityScreen
│   │   ├── payment/                        # PaymentSummaryScreen (offline-safe sim + Midtrans WebView), PaymentResultScreen
│   │   ├── invoice/                        # Invoice providers & repository
│   │   ├── contracts/                      # ContractDetailScreen (electronic sign & PDF export)
│   │   ├── survey/                         # ScheduleSurveyBottomSheet & provider
│   │   ├── maintenance/                    # CreateMaintenanceScreen (photo upload)
│   │   ├── reviews/                        # WriteReviewBottomSheet (verified tenants)
│   │   ├── maps/                           # KosOsmMapCard + MapLocationPickerScreen (OSM/Nominatim + Offline preset picker)
│   │   ├── messaging/                      # ChatListScreen + ChatDetailScreen (polling skipped when offline)
│   │   ├── notifications/                  # NotificationsScreen + category deep-link routing
│   │   ├── profile/                        # ProfileScreen (+ AppModeSettingsCard) & EditProfileScreen
│   │   └── owner/                          # OwnerDashboardScreen, OwnerKosListScreen, OwnerKosFormScreen, OwnerRoomsScreen,
│   │                                       # OwnerBookingsScreen, OwnerBookingDetailScreen, OwnerOperationsScreens, OwnerAnalyticsScreen, OwnerMoreScreen
│   ├── shared/
│   │   ├── models/                         # Freezed models: user, facility, kos, home_data, notification, transaction, owner, chat, paginated_list_state
│   │   └── widgets/                        # app_smart_image, app_mode_settings_card, kos_card, facility_chip, guest_auth_prompt, pdf_viewer_screen
│   └── main.dart                           # Bootstrap Riverpod, intl id_ID, SharedPreferences, GoogleFonts offline guard
├── test/
│   ├── offline_demo_polish_test.dart       # E2E SQLite + Interceptor, Splash transition, AppSmartImage, Offline Payment & Login UI tests
│   ├── widget_test.dart                    # Core formatters, validators, TempatinApp boot test
│   ├── phase5_customer_test.dart           # Customer discovery & detail widget tests
│   ├── phase7_transaction_test.dart        # Booking & Owner Approval First tests
│   └── phase8_9_owner_chat_test.dart       # Owner dashboard, analytics chart, & chat timer tests
├── mobile/                                 # (Terpisah) Arsip prototipe standalone Drift — bukan bagian dari build root
├── pubspec.yaml
├── README.md
└── PROJECT_CONTEXT.md
```

---

## 9. Kontrak Backend (`feature/mobile-api`) & Parity Offline

Backend Laravel 12 berada di `C:\Users\Thinkpad\Downloads\TEMPATIN` pada branch **`feature/mobile-api`** dengan **261 PHPUnit tests (`934 assertions`)** lulus:
- **Laravel Sanctum** (`personal_access_tokens`) dan 14 API controller (`App\Http\Controllers\Api\V1\*`) + 13 API Resource (`App\Http\Resources\V1\*`).
- `OfflineDemoInterceptor` menjaga paritas penuh terhadap seluruh skema JSON `snake_case`, pagination `meta`, dan HTTP status error (`401`, `403`, `404`, `422`) sehingga repository dan provider Riverpod tidak perlu dibedakan antara mode offline dan mode server.

---

## 10. Skema Database (Offline SQLite vs Backend Laravel)

### 10.1 Database Demo Offline Lokal (`tempatin_demo.db` — 18 Tabel SQLite)
Dikelola oleh `OfflineDemoDatabase` dengan foreign key aktif (`PRAGMA foreign_keys = ON`):
- **Pengguna & Sesi**: `users`, `sessions`
- **Properti & Kamar**: `facilities`, `kos` *(7 properti seed across Yogyakarta, Bandung, Jakarta Selatan, Depok, Surabaya)*, `kos_photos`, `kos_facilities`, `rooms`
- **Transaksi & Operasional**: `favorites`, `bookings`, `invoices`, `payments`, `rental_contracts`, `surveys`, `maintenance_reports`
- **Interaksi**: `reviews`, `conversations`, `messages`, `notifications`

### 10.2 Referensi Database Backend Laravel (21 Tabel Efektif)
- **Inti Properti**: `users`, `kos` *(SoftDeletes)*, `facilities`, `facility_kos`, `kos_photos`, `rooms`
- **Transaksi**: `bookings`, `invoices`, `payments`, `rental_contracts`
- **Interaksi & Monitoring**: `favorites`, `reviews`, `surveys`, `maintenance_reports`, `conversations`, `messages`, `notifications`
- **Sistem**: `sessions`, `cache`, `cache_locks`, `password_reset_tokens`, `personal_access_tokens`

---

## 11. Verifikasi QA, Build & Perintah Penting

### Hasil Verifikasi Terakhir
- **`flutter analyze`**: `No issues found!`
- **`flutter test`**: **`26 / 26 passed`** (seluruh 5 file suite di `test/`)
- **Release APK**: `build/app/outputs/flutter-apk/app-release.apk` (`73.8 MB` / `77,374,361` bytes)
- **Release AAB**: `build/app/outputs/bundle/release/app-release.aab` (`71.5 MB` / `74,947,156` bytes)
- **Perangkat Fisik Android (`TECNO_LJ6` / `142965556A102985`)**: Terinstal (`Success`) & diluncurkan via ADB (`com.tempatin.mobile`)
- **Backend Laravel (`php artisan test`)**: `261 passed (934 assertions)`

### Perintah Development & Build
```powershell
# 1. Analisis statis & seluruh automated tests
flutter pub get
flutter analyze
flutter test

# 2. Build APK & AAB Release (Offline-First Demo Mode aktif secara default)
flutter build apk --release
flutter build appbundle --release

# 3. Instal & jalankan langsung di HP Android yang terhubung USB
adb devices -l
adb install -r "build\app\outputs\flutter-apk\app-release.apk"

# 4. Jalankan mode Live Server Laravel (port 8000 via USB Debugging)
adb reverse tcp:8000 tcp:8000
flutter run --dart-define=OFFLINE_DEMO=false --dart-define=ENV=dev --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1
```

---

## 12. Indeks Dokumentasi Lengkap (`docs/`)

- [DEPLOYMENT_AND_QA_CHECKLIST.md](docs/DEPLOYMENT_AND_QA_CHECKLIST.md) — Ringkasan QA terverifikasi, konfigurasi `--dart-define`, panduan keystore release Android/iOS, dan prasyarat deployment.
- [PROJECT_ANALYSIS.md](docs/PROJECT_ANALYSIS.md) — Hasil audit website Laravel 12, temuan bug, dan mitigasi risiko.
- [FEATURE_MAPPING.md](docs/FEATURE_MAPPING.md) — Pemetaan fitur Guest, Customer, Owner, Admin serta inventaris layar mobile.
- [DATABASE_REFERENCE.md](docs/DATABASE_REFERENCE.md) — Skema database backend Laravel, ERD Mermaid, dan generator kode.
- [DESIGN_SYSTEM.md](docs/DESIGN_SYSTEM.md) — Token warna, tipografi, spacing, radii, dan spesifikasi komponen UI.
- [MOBILE_DESIGN_SPEC.md](docs/MOBILE_DESIGN_SPEC.md) — Information architecture, user journey, navigasi 5-tab, bottom sheets, dan wireframe.
- [MOBILE_ARCHITECTURE.md](docs/MOBILE_ARCHITECTURE.md) — Struktur folder `lib/`, Riverpod lifecycle, GoRouter guards, Dio, OSM, Midtrans WebView, dan PDF.
- [API_CONTRACT.md](docs/API_CONTRACT.md) — Kontrak endpoint `/api/v1` lengkap beserta aturan *Owner Approval First*.
- [MOBILE_ROADMAP.md](docs/MOBILE_ROADMAP.md) — Rencana eksekusi bertahap Phase 1–10.
- [TECHNICAL_DECISIONS.md](docs/TECHNICAL_DECISIONS.md) — Architecture Decision Records (ADRs) dan daftar paket Flutter/Dart.
