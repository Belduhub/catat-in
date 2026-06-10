# 📱 Cara Penggunaan Aplikasi Catatin

## 🚀 Menjalankan Aplikasi

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Jalankan Aplikasi
```bash
flutter run
```

### 3. Pilih Device
- Untuk Android: Pilih emulator atau device Android
- Untuk Web: Pilih Chrome
- Untuk Windows: Pilih Windows

## 🔐 Login Pertama Kali

Aplikasi sudah menyediakan **default user** untuk testing:

```
Username: admin
Password: password123
```

## 📝 Fitur-Fitur Aplikasi

### 1. Register (Daftar Akun Baru)
1. Di halaman login, klik **"Daftar"**
2. Isi form:
   - Nama Lengkap
   - Username (harus unique)
   - Password (minimal 6 karakter)
3. Klik tombol **"Daftar"**
4. Otomatis login dan masuk ke Dashboard

### 2. Login
1. Masukkan Username dan Password
2. (Opsional) Centang "Ingat saya"
3. Klik tombol **"Masuk"**
4. Jika berhasil, akan masuk ke Dashboard

### 3. Dashboard - Melihat Catatan
- **List Catatan**: Semua catatan Anda tampil di sini
- **Filter Kategori**: Tap chip kategori (Semua, Kuliah, Kerja, Pribadi)
- **Sort**: Klik icon sort di AppBar
  - Latest: Catatan terbaru dulu
  - A-Z: Urut judul A ke Z
  - Z-A: Urut judul Z ke A
- **Lihat Detail**: Tap pada card catatan untuk edit
- **Hapus**: Klik icon delete (🗑️) pada card

### 4. Tambah Catatan Baru
1. Klik tombol **FAB (+)** di pojok kanan bawah
2. Isi form:
   - **Judul**: Judul catatan
   - **Kategori**: Pilih dari dropdown (Kuliah/Kerja/Pribadi)
   - **Isi Catatan**: Konten catatan Anda
3. Klik **"Simpan Catatan"**
4. Catatan baru akan muncul di Dashboard

### 5. Edit Catatan
1. Dari Dashboard, tap pada catatan yang ingin diedit
2. Ubah judul, kategori, atau isi catatan
3. Klik **"Simpan Perubahan"**
4. Perubahan akan tersimpan

### 6. Hapus Catatan
1. Klik icon delete (🗑️) pada card catatan
2. Konfirmasi dengan klik **"Hapus"**
3. Catatan akan terhapus permanent

### 7. Profile
1. Klik icon profile di AppBar → Pilih **"Profile"**
2. Bisa edit:
   - Nama Lengkap
   - Username
   - Password (opsional, kosongkan jika tidak ingin ubah)
3. Klik **"Simpan Perubahan"**
4. Profile akan terupdate

### 8. Tentang Kami
1. Klik icon profile di AppBar → Pilih **"Tentang Kami"**
2. Lihat informasi aplikasi dan developer

### 9. Logout
1. Klik icon profile di AppBar → Pilih **"Logout"**
2. Konfirmasi logout
3. Kembali ke halaman login

## 🎯 Tips Penggunaan

1. **Kategori warna berbeda**:
   - 🟢 Kuliah = Hijau
   - 🟠 Kerja = Orange
   - 🟣 Pribadi = Purple
   - 🔵 Semua = Biru

2. **Sorting otomatis apply** setelah pilih option

3. **Filter kategori** bisa dikombinasi dengan sorting

4. **Setiap user hanya bisa lihat catatannya sendiri** (data isolation)

5. **Session tersimpan**, jadi tidak perlu login ulang setiap buka app

## 🐛 Troubleshooting

### Error saat build
```bash
flutter clean
flutter pub get
flutter run
```

### Database error
- Delete dan reinstall aplikasi
- Database akan dibuat ulang dengan default user

### Lupa password
- Gunakan default user: admin/password123
- Atau register akun baru

## 📱 Tested On

- ✅ Android Emulator
- ✅ Android Physical Device
- ✅ Web (Chrome)
- ✅ Windows Desktop

## 🔧 Development Mode

### Hot Reload
- Tekan `r` di terminal untuk hot reload
- Tekan `R` untuk hot restart

### Debug Mode
- App berjalan dalam debug mode secara default
- Lihat console untuk log

### Build Release
```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# Windows
flutter build windows --release

# Web
flutter build web --release
```

## 📊 Data Test

Setelah install, coba buat beberapa catatan untuk testing:

**Catatan Kuliah:**
- Materi UKPL Pertemuan 5
- Tugas Basis Data
- Presentasi Proyek Akhir

**Catatan Kerja:**
- Meeting dengan Client
- Task Development Sprint 2
- Code Review Notes

**Catatan Pribadi:**
- Daftar Belanja
- Ide Project Pribadi
- Catatan Harian

## 💡 Catatan Penting

1. **Password** disimpan dalam plain text untuk keperluan akademik
2. **Database** disimpan lokal di device
3. **Session** menggunakan SharedPreferences
4. **Setiap user** punya data catatan terpisah
5. **Delete cascade**: Jika user dihapus, semua catatannya ikut terhapus

---

Selamat menggunakan **catat.in**! 🎉
