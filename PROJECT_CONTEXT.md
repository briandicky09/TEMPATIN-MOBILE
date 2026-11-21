# PROJECT CONTEXT: TEMPATIN MOBILE

> **Dokumentasi Konteks Komprehensif Proyek Aplikasi Mobile Cross-Platform TEMPATIN (Flutter & Dart — Android & iOS)**
>
> *Terakhir diperbarui: 21 November 2026 | Status Proyek: **Phase 1–10 Selesai — Aplikasi Terintegrasi, Lolos Automated QA, & Build Release APK/AAB Terverifikasi***

---

## 1. Ikhtisar Proyek & Visi Bisnis

**TEMPATIN MOBILE** adalah aplikasi mobile cross-platform (Android & iOS) berbasis **Flutter** untuk ekosistem platform pencarian, pemesanan, dan pengelolaan rumah kos **TEMPATIN**.

Aplikasi ini dibangun sebagai produk mobile native yang terpisah dari proyek web referensi Laravel 12 (`C:\Users\Thinkpad\Downloads\TEMPATIN`), bukan sekadar konversi webview responsif.

### Prinsip Utama Proyek
1. **Single Source of Truth**: Seluruh database (MySQL / SQLite dev), autentikasi, kalkulasi harga, payment gateway Midtrans, dan business logic tetap berada di **backend Laravel 12**. Flutter **tidak pernah** terhubung langsung ke database maupun menyimpan secret/API key Midtrans.
2. **Isolasi Proyek Referensi**: Folder `C:\Users\Thinkpad\Downloads\TEMPATIN` tidak dimodifikasi selama fase UI/foundation. Perubahan backend REST API (`/api/v1` + Laravel Sanctum) akan dikerjakan pada branch Git terpisah (`feature/mobile-api`) setelah persetujuan implementasi Phase 6.
3. **Target Platform & Prioritas**: Android dan iOS, dengan prioritas pengembangan, build, dan pengujian langsung pada **perangkat Android fisik** (via USB Debugging + ADB).

---

## 2. Status Progres Fase (`MOBILE_ROADMAP.md`)

| Fase | Nama Fase | Status | Ringkasan Hasil |
| :--- | :--- | :--- | :--- |
| **Phase 1** | Project Discovery | **Selesai** | Audit menyeluruh 17 controller, 15 model, 26 migrasi, 2 seeder, 2 policy, 5 FormRequest, `MidtransService`, `TempatinNotification`, dan CSS/Blade. |
| **Phase 2** | Documentation | **Selesai** | 8 dokumen teknis di `docs/` selesai disusun dan disetujui. |
| **Phase 3** | Mobile Design | **Selesai** | Spesifikasi UI/UX hybrid ([MOBILE_DESIGN_SPEC.md](docs/MOBILE_DESIGN_SPEC.md)) & pembaruan alur *Owner Approval First* di [API_CONTRACT.md](docs/API_CONTRACT.md). |
| **Phase 4** | Flutter Foundation & Env | **Selesai** | Instalasi Flutter `3.50.0` + Dart `3.14.0`, Android SDK minimal, Antigravity IDE setup, arsitektur `lib/`, theme, GoRouter, Dio, Riverpod, dan verifikasi build APK Debug + Release. |
| **Phase 5** | Customer Mobile Core | **Selesai** | Auth UI lengkap (Login, Register, Forgot/Reset Password), Home, Eksplor + Filter Bottom Sheet, Detail Kos + Galeri, Favorit, Profil & Edit Profil, Notifikasi. |
| **Phase 6** | Backend API & Integration | **Selesai** | Laravel Sanctum + `/api/v1` (branch `feature/mobile-api`), normalisasi URL aset, perbaikan bug state machine Midtrans (`approved -> confirmed`), room IDOR, nota/kontrak/SVG guards, 261 PHPUnit tests pass. |
| **Phase 7** | Transaction Features | **Selesai** | Room selection, Booking (*Owner Approval First*), Midtrans Snap WebView + sync, Invoice, Nota PDF (`printing`/`share_plus`), Kontrak Digital & PDF, Survei, Maintenance, Review. |
| **Phase 8** | Owner Mobile | **Selesai** | Owner Dashboard live, CRUD Properti + Foto, Room Inventory, Approve/Reject/Check-In/Check-Out, Penghuni Aktif, Survei, Maintenance, Ulasan + Balasan, Analitik `fl_chart`. |
| **Phase 9** | Advanced Features | **Selesai** | Peta `flutter_map` (OSM + Nominatim), Internal Chat (paginated REST + `after_id` polling saat screen aktif), Notifikasi deep-link routing. |
| **Phase 10** | Quality Assurance | **Selesai** *(Prasyarat eksternal dicatat)* | `flutter analyze` (0 issue), 21/21 Flutter unit/widget tests pass, 261 PHPUnit tests pass, Release APK (`63.0 MB`) & Release AAB (`60.9 MB`) berhasil dibangun. Uji perangkat fisik menunggu HP Android dicolokkan ke ADB & iOS menunggu macOS/Xcode. |

---

## 3. Tech Stack & Dependensi (`pubspec.yaml`)

| Komponen | Teknologi / Paket | Versi Terpasang | Keterangan |
| :--- | :--- | :--- | :--- |
| **Framework & Bahasa** | Flutter & Dart | `3.50.0` (stable) / `^3.14.0` | SDK di `C:\src\flutter` |
| **State Management** | `flutter_riverpod` | `^3.5.0` | Reactive state & dependency injection |
| **Navigasi** | `go_router` | `^18.1.4` | Declarative routing + `StatefulShellRoute` |
| **Networking** | `dio` | `^5.11.1` | HTTP client, interceptor Sanctum, multipart, PDF bytes |
| **Immutability & JSON** | `freezed_annotation` + `json_annotation` | `^3.1.0` / `^4.12.0` | Codegen via `build_runner`, `freezed`, `json_serializable` |
| **Local Storage** | `flutter_secure_storage` & `shared_preferences` | `^11.2.0` / `^2.5.6` | Token Sanctum terenkripsi vs preferensi non-sensitif |
| **UI, Font & Ikon** | `google_fonts`, `lucide_icons_flutter`, `flutter_svg`, `cached_network_image` | `^9.0.0`, `^4.0.3`, `^2.4.0`, `^4.0.7` | Inter + Source Serif 4, Lucide icons, SVG skyline, image caching |
| **Formatting** | `intl` | `^0.20.3` | Format Rupiah (`Rp 850.000`) & tanggal lokal `id_ID` |
| **Maps & Lokasi** | `flutter_map` + `latlong2` | `^8.3.2` / `^0.10.1` | Peta OpenStreetMap & picker koordinat via Nominatim |
| **Pembayaran & WebView** | `webview_flutter` | `^4.14.1` | Midtrans Snap checkout dalam aplikasi + sinkronisasi server |
| **Media, PDF & Chart** | `image_picker`, `flutter_image_compress`, `printing`, `share_plus`, `fl_chart`, `url_launcher`, `path_provider` | `^1.2.4`, `^2.5.1`, `^5.15.1`, `^13.3.1`, `^1.3.1`, `^6.3.3`, `^2.1.6` | Upload foto, viewer/cetak Nota & Kontrak PDF, grafik pendapatan, maps launcher |
| **Testing & Lint** | `flutter_test`, `mocktail`, `flutter_lints` | `^1.0.5` / `^6.0.0` | Unit & widget test |
| **Belum Dikonfigurasi** | Google Sign-In (`google_sign_in`) | — | Memerlukan konfigurasi `GOOGLE_CLIENT_ID` & SHA-1 proyek Google Cloud |

---

## 4. Environment Pengembangan & Workflow Perangkat Fisik

Environment telah dioptimasi untuk workflow **Physical Android Device + APK Compilation** (tanpa emulator/AVD/system-images yang boros storage):

- **OS & IDE**: Windows 10/11 64-bit, **Antigravity IDE** dengan ekstensi `dart-code.flutter` & `dart-code.dart-code` (`v3.146.0`) serta `.vscode/settings.json`.
- **Android SDK Minimal** (`%LOCALAPPDATA%\Android\Sdk`, ~2.87 GB):
  - `platform-tools` (`adb.exe`)
  - `cmdline-tools\latest` (`sdkmanager`)
  - `platforms\android-36` (`compileSdkVersion = 36`, `targetSdkVersion = 36`)
  - `build-tools\36.0.0`
  - `ndk\28.2.13676358` & `cmake\3.22.1`
  - Seluruh lisensi Android SDK sudah diterima.
- **Java / JDK**: Bundled OpenJDK `25.0.4` (`C:\src\android-studio\jbr`).
- **Environment Variables (User)**: `ANDROID_HOME`, `ANDROID_SDK_ROOT`, `JAVA_HOME`, dan `PATH` (`C:\src\flutter\bin`, `platform-tools`, `cmdline-tools\latest\bin`).
- **Konfigurasi Android Project**:
  - `applicationId`: `com.tempatin.mobile`
  - `minSdk`: `>= 23` (syarat `flutter_secure_storage`)
  - `android:label`: `TEMPATIN` + izin `INTERNET`.

---

## 5. Role Pengguna & Scope Mobile

| Role (`users.role`) | Scope Mobile | Navigasi Utama |
| :--- | :--- | :--- |
| **Guest / Customer (`customer`)** | **Prioritas Utama (Core)** | 5-Tab Bottom Nav: `Beranda`, `Eksplor`, `Favorit`, `Aktivitas` *(Booking, Invoice, Survei, Kerusakan)*, `Profil`. |
| **Property Owner (`owner`)** | **Prioritas Utama (Core)** | 5-Tab Bottom Nav: `Dashboard`, `Properti`, `Booking` *(Approval, Check-In/Out, Penghuni)*, `Pesan`, `Lainnya` *(Survei, Kerusakan, Ulasan, Statistik, Notifikasi, Profil)*. |
| **Superadmin (`admin`)** | **Web-First (Di luar scope awal)** | Tetap menggunakan website Laravel (`/admin/*`). Endpoint API opsional terdokumentasi di `API_CONTRACT.md` untuk kemungkinan ekspansi pasca-stabil. |

---

## 6. Alur Bisnis Terkunci

### 6.1 Alur Booking & Pembayaran (**Owner Approval First**)
Alur ini wajib dipertahankan sesuai keputusan arsitektur:
1. **Customer** memilih kos (dan opsional kamar `room_id` bila tersedia), menentukan `start_date` dan `duration_months` (1–12).
2. Server menghitung `subtotal = kos.price * duration_months`, `admin_fee = 25000`, `total_amount = subtotal + admin_fee`, `end_date`, lalu membuat `Booking` berstatus **`pending`** + `Invoice` berstatus **`unpaid`** (dengan guard anti-double-submit 5 menit).
3. **Owner** meninjau booking:
   - **Setujui (`approve`)**: status menjadi **`approved`** (dapat sekaligus menetapkan `room_id` milik kos tersebut).
   - **Tolak (`reject`)**: status menjadi **`rejected`** (wajib `rejection_reason`), invoice dibatalkan.
   - *(Customer dapat membatalkan booking selama masih `pending` -> `cancelled`.)*
4. **Customer** hanya dapat memulai pembayaran Midtrans (`POST /api/v1/bookings/{code}/pay`) jika status booking **`approved`**.
5. Customer membayar melalui **Midtrans Snap WebView** (`snap_redirect_url`).
6. Webhook `POST /payment/midtrans/notification` (verifikasi SHA-512 + nominal) dan endpoint sinkronisasi `GET /api/v1/payments/{code}/sync` memverifikasi transaksi secara idempotent, mengubah `payment` -> `success`, `invoice` -> `paid`, dan **`booking` (`approved` -> `confirmed`)**.
7. **Check-In & Check-Out**: Owner memproses check-in (`confirmed` -> `active`, kamar -> `occupied`) dan check-out (`active` -> `completed`, kamar -> `available`).

### 6.2 Fitur Pendukung Terverifikasi
- **Kontrak Sewa Digital (`CTR-YYYYMM-XXXXX`)**: Dibuat otomatis saat booking `confirmed`/`active`/`completed`, ditandatangani secara elektronik oleh customer (`agree: true`, mencatat `signed_at` & `signer_ip`), dan dapat diunduh dalam format PDF (DomPDF).
- **Nota Pembayaran PDF**: Dapat diunduh setelah `invoice.status == 'paid'`.
- **Survei Lokasi**: Customer mengajukan jadwal survei (`>= hari ini`), Owner menyetujui/menolak/menyelesaikan; Customer dapat membatalkan selama `pending`.
- **Laporan Kerusakan (`MaintenanceReport`)**: Penghuni dengan booking `confirmed`/`active` dapat mengirim laporan disertai foto (maks 3 MB); status: `open` -> `in_progress` / `resolved` / `rejected` dengan `owner_notes`.
- **Ulasan Terverifikasi (`Review`)**: Hanya customer dengan booking `confirmed`/`active`/`completed` yang dapat memberi 1 ulasan (rating 1–5) per kos; Owner dapat membalas ulasan.
- **Chat Internal**: 1 `Conversation` unik per `(kos_id, customer_id, owner_id)` berbasis database.
- **Notifikasi**: Tersimpan di tabel `notifications` (`TempatinNotification`).

---

## 7. Sistem Desain (*Notion Warm Paper Hybrid*)

Mengacu pada `DESIGN.md` dan `tempatin.css`, diadaptasi untuk kenyamanan sentuhan mobile (`DESIGN_SYSTEM.md`):

- **Warna Utama**:
  - Primary CTA & Active Nav: `#0075DE` (`AppColors.primary`)
  - Canvas Halaman: `#F6F5F4` (`AppColors.canvas` — *Paper Warmth*)
  - Permukaan Kartu & Bottom Nav: `#FFFFFF` (`AppColors.surface`)
  - Hairline Border: `rgba(0, 0, 0, 0.08)` (`AppColors.borderHairline`, tanpa drop-shadow berlebihan)
  - Teks: `#000000` (judul), `#615D59` (body hangat), `#757575` (metadata/caption)
  - Semantic Badges: Emerald (`#EDF7EE`/`#166534`), Marigold (`#FEF9C3`/`#854D0E`), Coral (`#FEE2E2`/`#991B1B`), Sky Tint (`#E6F3FE`/`#0054A3`)
- **Tipografi**: **Inter** sebagai font utama (`displaySm 28sp` hingga `caption 12sp`) dan **Source Serif 4** secara selektif untuk subhead editorial.
- **Aturan UI**: Sudut lengkung `12dp` untuk kartu, `8dp` untuk tombol/input, `9999dp` untuk pill/badge, tinggi tombol minimal `48dp`, serta wajib menangani state **Loading (skeleton)**, **Empty**, **Error**, dan **Success**.

---

## 8. Arsitektur Aplikasi & Struktur Direktori (`TEMPATIN MOBILE`)

```text
TEMPATIN MOBILE/
├── android/                        # Konfigurasi Android (com.tempatin.mobile, minSdk >= 23)
├── ios/                            # Konfigurasi iOS (siap build di macOS/Xcode)
├── assets/
│   └── images/                     # logo.png, logo-symbol.png, city-skyline.svg
├── docs/                           # Dokumentasi lengkap Phase 1-3 (9 file MD)
├── lib/
│   ├── app/
│   │   ├── app.dart                # Root MaterialApp.router + AppTheme
│   │   ├── router/
│   │   │   ├── app_router.dart     # GoRouter + role-aware redirect guards
│   │   │   ├── route_names.dart    # Konstanta RoutePaths
│   │   │   ├── customer_shell.dart # 5-tab Customer bottom nav shell
│   │   │   └── owner_shell.dart    # 5-tab Owner bottom nav shell
│   │   └── theme/
│   │       ├── app_colors.dart
│   │       ├── app_spacing.dart
│   │       ├── app_typography.dart
│   │       └── app_theme.dart
│   ├── core/
│   │   ├── config/env.dart         # --dart-define ENV & API_BASE_URL
│   │   ├── constants/
│   │   │   ├── api_endpoints.dart  # Seluruh endpoint /api/v1/...
│   │   │   └── storage_keys.dart
│   │   ├── errors/
│   │   │   ├── app_exception.dart  # Sealed AppException hierarchy
│   │   │   └── error_mapper.dart   # DioException -> pesan error Bahasa Indonesia
│   │   ├── network/
│   │   │   ├── api_response.dart   # ApiResponse<T> & PaginationMeta
│   │   │   ├── auth_interceptor.dart # Bearer token injection & 401 handler
│   │   │   └── dio_client.dart     # Riverpod dioProvider
│   │   ├── storage/
│   │   │   ├── secure_storage.dart # FlutterSecureStorage (Sanctum token)
│   │   │   └── prefs_storage.dart  # SharedPreferences
│   │   ├── utils/
│   │   │   ├── currency_formatter.dart
│   │   │   ├── date_formatter.dart
│   │   │   └── validators.dart
│   │   └── widgets/                # TempatinButton, TempatinCard, StatusBadge,
│   │                               # TempatinTextField, AppEmptyState, AppErrorState, SkeletonBox
│   ├── features/
│   │   ├── authentication/         # AuthSessionNotifier, Login, Register, Forgot/Reset Password
│   │   ├── booking/                # BookingFormScreen, BookingDetailScreen, MyActivityScreen
│   │   ├── contracts/              # ContractDetailScreen (signing & PDF export)
│   │   ├── favorites/              # FavoritesScreen & toggle provider
│   │   ├── home/                   # HomeScreen + featured/city discovery
│   │   ├── invoice/                # Invoice providers & repository
│   │   ├── maintenance/            # CreateMaintenanceScreen (photo upload)
│   │   ├── maps/                   # KosOsmMapCard + MapLocationPickerScreen (OSM & Nominatim)
│   │   ├── messaging/              # ChatListScreen + ChatDetailScreen (after_id polling)
│   │   ├── notifications/          # NotificationsScreen + category deep-link routing
│   │   ├── owner/                  # OwnerDashboard, OwnerKosList/Form, OwnerRooms, OwnerBookings/Detail,
│   │   │                           # OwnerTenants, OwnerSurveys, OwnerMaintenance, OwnerReviews, OwnerAnalytics, OwnerMore
│   │   ├── payment/                # PaymentSummaryScreen, MidtransWebViewScreen, PaymentResultScreen
│   │   ├── profile/                # ProfileScreen & EditProfileScreen
│   │   ├── property/               # ExploreScreen, FilterBottomSheet, KosDetailScreen, PhotoGalleryViewerScreen
│   │   ├── reviews/                # WriteReviewBottomSheet (verified tenants)
│   │   └── survey/                 # ScheduleSurveyBottomSheet
│   ├── shared/
│   │   ├── models/                 # Freezed models: user, facility, kos, home, notification,
│   │   │                           # transaction, owner, chat, paginated_list_state
│   │   └── widgets/                # kos_card, facility_chip, guest_auth_prompt, pdf_viewer_screen
│   └── main.dart
├── test/
│   ├── widget_test.dart
│   ├── phase5_customer_test.dart
│   ├── phase7_transaction_test.dart
│   └── phase8_9_owner_chat_test.dart
├── pubspec.yaml
└── PROJECT_CONTEXT.md
```

---

## 9. Kontrak Backend & Implementasi Phase 6 (`feature/mobile-api`)

Implementasi backend telah dikerjakan di `C:\Users\Thinkpad\Downloads\TEMPATIN` pada Git branch **`feature/mobile-api`** *(uncommitted — menunggu persetujuan user untuk commit/push)* dengan seluruh 261 PHPUnit tests lulus (`934 assertions`):
1. Instalasi **Laravel Sanctum** (`laravel/sanctum ^4.5`, `HasApiTokens` pada `User`, tabel `personal_access_tokens` pada `database.sqlite` & `database/testing.sqlite`) dan JSON `401`/`403`/`404`/`422` pada `EnsureUserHasRole` & `bootstrap/app.php`.
2. Pembuatan `App\Http\Controllers\Api\V1\*` (14 controller termasuk `ApiResponseTrait`) & `App\Http\Resources\V1\*` (13 resource) dengan `App\Support\AssetUrlResolver` untuk URL absolut aset dan pemisahan `rooms_summary` vs `available_rooms`.
3. **Perbaikan Bug Kritis yang Telah Diterapkan & Diuji**:
   - `MidtransService::handleNotification()`: izinkan transisi `approved -> confirmed` (bukan hanya `pending`).
   - `MidtransService::syncTransactionStatus()`: endpoint server-to-server `GET /api/v1/payments/{code}/sync` berbagi logika `applyTransactionUpdate` yang idempotent.
   - `OwnerBookingController::approve()`: validasi `room_id` milik `booking.kos_id` & cegah double-booking kamar.
   - Guard PDF Nota (`invoice.status === 'paid'`), API Kontrak Sewa (`confirmed`/`active`/`completed`), Survey/Chat role `customer`, blokir upload SVG pada profil, dan kesetaraan profil untuk `owner`.

---

## 10. Referensi Database Backend (21 Tabel Efektif)

- **Inti Properti**: `users`, `kos` *(SoftDeletes)*, `facilities`, `facility_kos`, `kos_photos`, `rooms`.
- **Transaksi**: `bookings` (`BKG-YYYYMM-XXXXX`), `invoices` (`INV-YYYYMM-XXXX`), `payments` (`PAY-YYYYMM-XXXXX`), `rental_contracts` (`CTR-YYYYMM-XXXXX`).
- **Interaksi & Monitoring**: `favorites`, `reviews`, `surveys`, `maintenance_reports`, `conversations`, `messages`, `notifications`.
- **Sistem**: `sessions`, `cache`, `cache_locks`, `password_reset_tokens` *(ditambah `personal_access_tokens` saat Sanctum dipasang)*.

**Akun Uji Seeder Default (`DatabaseSeeder.php`)**:
- **Owner**: `owner@tempatin.id` / `password123`
- **Customer**: `dewi@email.com` / `password123`

---

## 11. Perintah Penting Development, Testing & Build

```powershell
# 1. Verifikasi kualitas kode & test
flutter pub get
flutter analyze
flutter test

# 2. Koneksi HP Android fisik via USB Debugging + akses Laravel lokal (port 8000)
adb devices
flutter devices
adb reverse tcp:8000 tcp:8000
flutter run --dart-define=ENV=dev --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1

# 3. Build APK & App Bundle Android (terverifikasi pada 21 Nov 2026)
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk (63.0 MB)
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab (60.9 MB)
```

---

## 12. Indeks Dokumentasi Lengkap (`docs/`)

- [DEPLOYMENT_AND_QA_CHECKLIST.md](docs/DEPLOYMENT_AND_QA_CHECKLIST.md) — Ringkasan QA terverifikasi, panduan signing rilis Android/iOS, konfigurasi `--dart-define`, dan prasyarat deployment.

- [PROJECT_ANALYSIS.md](docs/PROJECT_ANALYSIS.md) — Hasil audit website Laravel 12, gap dokumentasi lama vs kode aktual, 8 temuan bug, dan mitigasi risiko.
- [FEATURE_MAPPING.md](docs/FEATURE_MAPPING.md) — Pemetaan fitur Guest, Customer, Owner, Admin serta inventaris 36 layar mobile.
- [DATABASE_REFERENCE.md](docs/DATABASE_REFERENCE.md) — Skema lengkap 21 tabel, ERD Mermaid, generator kode, dan catatan SQLite vs MySQL.
- [DESIGN_SYSTEM.md](docs/DESIGN_SYSTEM.md) — Token warna, tipografi, spacing, radii, dan spesifikasi komponen UI.
- [MOBILE_DESIGN_SPEC.md](docs/MOBILE_DESIGN_SPEC.md) — Information architecture, user journey, navigasi 5-tab, bottom sheets, dan wireframe layar prioritas.
- [MOBILE_ARCHITECTURE.md](docs/MOBILE_ARCHITECTURE.md) — Struktur folder `lib/`, Riverpod lifecycle, GoRouter guards, Dio, OSM, Midtrans WebView, dan PDF.
- [API_CONTRACT.md](docs/API_CONTRACT.md) — Kontrak endpoint `/api/v1` lengkap beserta aturan *Owner Approval First* dan daftar perubahan backend.
- [MOBILE_ROADMAP.md](docs/MOBILE_ROADMAP.md) — Rencana eksekusi bertahap Phase 1–10.
- [TECHNICAL_DECISIONS.md](docs/TECHNICAL_DECISIONS.md) — 9 Architecture Decision Records (ADRs) dan daftar paket Flutter/Dart.
