<div align="center">

<img src="assets/images/logo.png" alt="TEMPATIN Logo" width="190" />

<h3>TEMPATIN MOBILE — 100% Offline Standalone Android Application</h3>

<p>
  <b>Flutter • Dart • Drift SQLite • Local Assets • Zero Network Dependencies</b>
</p>

<img src="assets/images/illustrations/city-skyline.svg" alt="TEMPATIN City Skyline" width="100%" />

</div>

---

## Ringkasan Proyek

**TEMPATIN Offline** adalah aplikasi Android standalone berbasis **Flutter & Dart** untuk pencarian, pemesanan (*booking*), pembuatan invoice simulasi, serta pengelolaan properti kos — berjalan **100% tanpa internet, tanpa server Laravel lokal, dan tanpa HTTP request**.

Seluruh gambar properti dibundel langsung di dalam APK melalui Flutter Assets, sementara seluruh transaksi, autentikasi lokal, ulasan, favorit, dan notifikasi disimpan permanen ke database **SQLite** menggunakan **Drift**.

> **Catatan Keamanan Demo:** Autentikasi lokal menggunakan *salted SHA-256 hash* (`package:crypto`) pada SQLite sebagai **simulasi pembelajaran / demonstrasi offline**, bukan sistem autentikasi produksi multi-perangkat.

---

## Fitur Lengkap

### 1. Splash Screen & Onboarding Anti-Blank Screen
- Native Launch Screen + **Android 12+ SplashScreen API** berlatar putih bersih dengan logo TEMPATIN (menghilangkan layar hitam saat cold start).
- Transisi halus (*Fade + Scale*) menuju Onboarding 3 slide atau langsung ke Home/Dashboard.

### 2. Mode Member (Pencari Kos)
- **Beranda & Pencarian**: Sapaan pengguna, filter kategori (`Putri`, `Putra`, `Campur`, `Eksklusif`), rekomendasi unggulan, kos terbaru.
- **Eksplor & Filter SQLite**: Pencarian judul/kota/alamat, rentang harga min–maks, multi-fasilitas, serta sorting harga & rating.
- **Detail Kos**: Galeri foto lokal geser, deskripsi, fasilitas, info pemilik, favorit, serta ulasan & rating bintang.
- **Booking & Invoice**: Pilih tanggal masuk & durasi sewa, kalkulasi otomatis (`subtotal + Rp 25.000` biaya admin), riwayat booking, nomor invoice `INV-...` otomatis, dan simulasi pembayaran demo.

### 3. Mode Owner (Pemilik Kos)
- **Dashboard Owner**: Total properti, total booking, antrean booking menunggu persetujuan, dan pendapatan simulasi lunas.
- **CRUD Properti Kos**: Tambah, edit, dan hapus kos, pilih fasilitas, serta kelola foto dari aset lokal bawaan maupun galeri HP (disalin ke penyimpanan permanen aplikasi).
- **Manajemen Booking**: Setujui, tolak dengan alasan, proses Check-In, dan Check-Out penghuni.

---

## Akun Demo Bawaan (`DatabaseSeeder`)

| Role | Email | Password |
| :--- | :--- | :--- |
| **Owner** | `owner@tempatin.id` | `password123` |
| **Member** | `dewi@email.com` | `password123` |

*(Tombol isi cepat **Demo Member** dan **Demo Owner** tersedia langsung pada layar Login.)*

---

## Cara Menjalankan & Build APK

```powershell
cd mobile
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter build apk --release
```

Output APK Release tersimpan di:
`mobile/build/app/outputs/flutter-apk/app-release.apk`

---

## Dokumentasi Terkait

- [Arsitektur Aplikasi](docs/ARCHITECTURE.md)
- [Skema Database SQLite (Drift)](docs/DATABASE.md)
- [Panduan Uji Offline & Airplane Mode](docs/OFFLINE_RUN_GUIDE.md)
