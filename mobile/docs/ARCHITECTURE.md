# Architecture — TEMPATIN MOBILE FULL OFFLINE

## 1. Prinsip Arsitektur

Aplikasi dibangun sebagai **100% Standalone Offline Android App** tanpa dependensi jaringan (`dio`, `http`, `cached_network_image`, `google_fonts`, maupun izin `INTERNET` pada `AndroidManifest.xml`).

```text
mobile/lib/
├── main.dart                     # Init WidgetsBinding, Intl id_ID, SharedPreferences
├── app/router/
│   ├── routes.dart               # Konstanta rute GoRouter
│   └── app_router.dart           # Role-aware routing + transisi fade splash
├── core/
│   ├── providers/app_providers.dart  # Riverpod providers (DB, Repos, Session, Queries)
│   ├── security/password_hasher.dart # Salted SHA-256 multi-round hashing
│   ├── theme/app_theme.dart          # TEMPATIN Black / White / Blue Material 3 theme
│   └── utils/formatters.dart         # Rupiah, Tanggal id_ID, Validator, Status Helper
├── data/
│   ├── database/
│   │   ├── app_database.dart         # Schema Drift 11 tabel + indeks + FK
│   │   ├── app_database.g.dart       # Codegen Drift
│   │   └── database_seeder.dart      # Seeding lokal idempoten
│   └── repositories/
│       ├── models.dart               # DTO/View models komposit
│       ├── auth_repository.dart      # Login, register, profil, session lokal
│       ├── kos_repository.dart       # Search, filter, detail, CRUD kos & foto lokal
│       ├── booking_repository.dart   # Transaksi booking, invoice, demo payment, approval
│       └── engagement_repository.dart# Favorit, ulasan, dan notifikasi lokal
├── features/
│   ├── entry/presentation/           # Splash, Onboarding, Login, Register
│   ├── member/presentation/          # Home, Explore, KosDetail, Booking, Activity, Invoice, Profile
│   └── owner/presentation/           # OwnerDashboard, OwnerKosList, OwnerKosForm, OwnerBookings
└── shared/widgets/
    ├── local_image.dart              # Image.asset & Image.file offline dengan placeholder
    ├── kos_card.dart
    └── tempatin_widgets.dart         # Button, Card, StatusBadge, TextField, EmptyState
```

---

## 2. Alur Cold Start Tanpa Layar Hitam

1. **Android 12+ Native Splash (`flutter_native_splash`)**: `styles.xml` dan `launch_background.xml` langsung merender latar `#FFFFFF` dan logo TEMPATIN sejak frame pertama OS.
2. **`main()` Minimalis**: Hanya menginisialisasi `SharedPreferences` dan locale tanggal sebelum memanggil `runApp(...)`. Database belum dibuka di UI thread.
3. **Flutter `SplashScreen`**: Menampilkan animasi `FadeTransition` + `ScaleTransition` pada logo sambil menjalankan `DatabaseSeeder.seedIfEmpty()` dan `restoreSession()` secara asinkron, lalu berpindah dengan fade transition ke `/onboarding`, `/home`, atau `/owner/dashboard`.

---

## 3. Sistem Gambar 100% Lokal

- Seluruh foto bawaan disalin dari referensi Laravel ke `assets/images/` dan didaftarkan di `pubspec.yaml`.
- Widget `LocalImage` memilih `Image.asset` untuk path `assets/...` dan `Image.file` untuk foto baru yang dipilih pemilik melalui `image_picker` (disalin ke `<ApplicationDocumentsDirectory>/kos_photos/` agar permanen meski cache OS dibersihkan).
