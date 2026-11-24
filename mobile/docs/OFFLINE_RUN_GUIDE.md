# Panduan Menjalankan & Pengujian Offline (Airplane Mode)

## 1. Perintah Pengembangan & Build

```powershell
cd "C:\Users\Thinkpad\Downloads\TEMPATIN MOBILE\mobile"

# Pasang dependensi
flutter pub get

# Generate kode Drift jika skema diubah
dart run build_runner build --delete-conflicting-outputs

# Analisis statis & unit/widget tests
flutter analyze
flutter test

# Build Release APK (100% offline)
flutter build apk --release
```

Hasil APK berada di:
`mobile/build/app/outputs/flutter-apk/app-release.apk`

---

## 2. Checklist Pengujian Wajib Mode Pesawat (*Airplane Mode*)

1. Instal `app-release.apk` ke HP Android fisik / emulator (`adb install -r build/app/outputs/flutter-apk/app-release.apk`).
2. Matikan Wi-Fi & data seluler, lalu aktifkan **Airplane Mode** pada perangkat.
3. Buka aplikasi **TEMPATIN**:
   - Pastikan tidak ada layar hitam sebelum splash screen tampil.
   - Pastikan seluruh foto kos di Beranda, Eksplor, dan Detail Kos langsung terlihat.
4. Masuk dengan akun demo Member (`dewi@email.com` / `password123`).
5. Cari kos & filter harga/fasilitas di tab **Eksplor**, buka **Detail Kos**, lalu ajukan booking baru.
6. Buka tab **Aktivitas -> Invoice** dan verifikasi invoice otomatis terbentuk.
7. Keluar, lalu masuk dengan akun demo Owner (`owner@tempatin.id` / `password123`).
8. Tambah kos baru, edit kos, hapus kos, serta setujui booking dari tab **Booking**.
9. Tutup paksa (*force close*) atau restart HP, buka aplikasi kembali dalam Airplane Mode, dan pastikan seluruh perubahan database tetap tersimpan.
