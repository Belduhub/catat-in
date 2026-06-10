# 🚀 Quick Start Guide - Catatin App

## ⚡ Super Quick (TL;DR)

```bash
# 1. Install dependencies
flutter pub get

# 2. Run app
flutter run

# 3. Login
Username: admin
Password: password123
```

---

## 📋 Step-by-Step Guide

### 1️⃣ Prerequisites Check

Pastikan sudah install:
- ✅ Flutter SDK (3.11+)
- ✅ Dart SDK (3.0+)
- ✅ Android Studio / VS Code
- ✅ Emulator atau device fisik

**Cek versi:**
```bash
flutter --version
dart --version
flutter doctor
```

### 2️⃣ Setup Project

```bash
# Navigate ke folder project
cd catatin

# Install dependencies
flutter pub get

# Verify no issues
flutter doctor -v
```

### 3️⃣ Run Application

#### Option A: Android Emulator
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>
```

#### Option B: Chrome (Web)
```bash
flutter run -d chrome
```

#### Option C: Windows Desktop
```bash
flutter run -d windows
```

### 4️⃣ First Login

Setelah app terbuka:

1. **Splash Screen** akan muncul (2 detik)
2. Navigate otomatis ke **Login Page**
3. Gunakan default credentials:
   ```
   Username: admin
   Password: password123
   ```
4. Klik **"Masuk"**
5. Masuk ke **Dashboard**

---

## 🎮 Testing Features

### ✅ Test Authentication

#### Register User Baru:
1. Dari Login page, klik **"Daftar"**
2. Isi form:
   - Nama Lengkap: `Test User`
   - Username: `testuser`
   - Password: `test123`
3. Klik **"Daftar"**
4. Otomatis login & masuk Dashboard

#### Test Logout:
1. Klik icon **Profile** di AppBar
2. Pilih **"Logout"**
3. Konfirmasi logout
4. Kembali ke Login page

### ✅ Test CRUD Catatan

#### Create Note:
1. Dari Dashboard, klik **FAB (+)**
2. Isi form:
   - Judul: `Tugas UKPL`
   - Kategori: `Kuliah`
   - Isi: `Membuat aplikasi catatan dengan Flutter`
3. Klik **"Simpan Catatan"**
4. Note muncul di Dashboard

#### Read & Filter:
1. Lihat list notes di Dashboard
2. Tap chip **"Kuliah"** untuk filter
3. Tap chip **"Semua"** untuk show all

#### Sort Notes:
1. Klik icon **Sort** di AppBar
2. Pilih **"A-Z"** / **"Z-A"** / **"Latest"**
3. List akan re-sort otomatis

#### Update Note:
1. Tap pada **card note** yang ingin diedit
2. Ubah title / kategori / content
3. Klik **"Simpan Perubahan"**
4. Note terupdate di Dashboard

#### Delete Note:
1. Klik icon **Delete (🗑️)** pada card
2. Konfirmasi delete
3. Note terhapus dari list

### ✅ Test Profile

1. Klik icon **Profile** → **"Profile"**
2. Edit:
   - Nama Lengkap
   - Username
   - Password (optional)
3. Klik **"Simpan Perubahan"**
4. Profile terupdate

### ✅ Test About Us

1. Klik icon **Profile** → **"Tentang Kami"**
2. Lihat info app & developers

---

## 🗂️ Sample Test Data

Setelah login, coba buat beberapa notes untuk testing:

### Note 1:
```
Judul: Materi UKPL Pertemuan 5
Kategori: Kuliah
Isi: Belajar tentang MVC Pattern dan Flutter development
```

### Note 2:
```
Judul: Meeting dengan Client
Kategori: Kerja
Isi: Diskusi requirement untuk project baru, deadline 2 minggu
```

### Note 3:
```
Judul: Daftar Belanja
Kategori: Pribadi
Isi: - Beras 5kg
- Minyak goreng
- Gula
- Kopi
```

### Note 4:
```
Judul: Tugas Basis Data
Kategori: Kuliah
Isi: Membuat ERD dan normalisasi database untuk sistem perpustakaan
```

---

## 🐛 Troubleshooting

### Problem: Dependencies Error
```bash
# Solution:
flutter clean
flutter pub get
flutter pub upgrade
```

### Problem: Build Error
```bash
# Solution:
flutter clean
flutter pub get
flutter run
```

### Problem: Hot Reload Not Working
```bash
# Solution:
# Tekan 'R' (capital R) untuk hot restart
# Atau restart app
```

### Problem: Database Error
```bash
# Solution:
# Uninstall app dari device
# Run ulang
# Database akan di-create ulang fresh
```

### Problem: Emulator Not Detected
```bash
# Solution:
# Check emulator running
flutter devices

# Start emulator
flutter emulators
flutter emulators --launch <emulator-id>
```

---

## 📊 Verify Installation

Setelah run, pastikan:

✅ Splash screen muncul  
✅ Navigate ke Login page  
✅ Bisa login dengan admin/password123  
✅ Dashboard muncul (empty state normal)  
✅ Bisa create note  
✅ Bisa filter kategori  
✅ Bisa sort notes  
✅ Bisa edit note  
✅ Bisa delete note  
✅ Bisa edit profile  
✅ Bisa logout  
✅ Session persist (tidak perlu login ulang)  

---

## 🔧 Development Commands

### Hot Reload/Restart
```bash
r    # Hot reload (quick refresh)
R    # Hot restart (full restart)
q    # Quit
```

### Build Release
```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# Windows
flutter build windows --release

# Web
flutter build web --release
```

### Analyze Code
```bash
flutter analyze
```

### Format Code
```bash
flutter format lib/
```

---

## 📱 Platform-Specific Notes

### Android
- Min SDK: 21 (Android 5.0)
- Target SDK: Latest
- APK size: ~20-30 MB (release)

### iOS
- Min iOS: 12.0
- Requires Mac for build
- Requires Xcode

### Web
- Tested on Chrome
- Responsive design
- PWA ready

### Windows
- Windows 10 or later
- Desktop app
- Native performance

---

## 🎯 Next Steps

Setelah berhasil run:

1. ✅ **Explore Features** - Try semua fitur yang ada
2. ✅ **Create Test Data** - Buat beberapa notes untuk testing
3. ✅ **Test Edge Cases** - Coba scenario yang unusual
4. ✅ **Check Documentation** - Baca docs untuk understand architecture
5. ✅ **Review Code** - Pelajari implementasi MVC

---

## 📚 Documentation Files

| File | Purpose |
|------|---------|
| `README.md` | Overview & introduction |
| `PROJECT_STRUCTURE.md` | Folder structure detail |
| `IMPLEMENTASI_MVC.md` | MVC architecture explanation |
| `API_FLOW.md` | Data flow & API docs |
| `CARA_PENGGUNAAN.md` | Complete user guide |
| `REQUIREMENTS_CHECKLIST.md` | All requirements check |
| `QUICK_START.md` | This file (quick start) |

---

## 🆘 Need Help?

### Issue? Check:
1. ✅ `flutter doctor` output
2. ✅ Dependencies installed (`flutter pub get`)
3. ✅ Emulator/device connected
4. ✅ Flutter SDK updated
5. ✅ Troubleshooting section above

### Study:
1. 📖 Read `IMPLEMENTASI_MVC.md` untuk understand architecture
2. 📖 Read `API_FLOW.md` untuk understand data flow
3. 📖 Read inline code comments

---

## ✅ Success Checklist

- [ ] Flutter & Dart installed
- [ ] Dependencies installed (`flutter pub get`)
- [ ] App runs successfully
- [ ] Can login with default user
- [ ] Can create notes
- [ ] Can filter & sort
- [ ] Can edit & delete notes
- [ ] Session persists
- [ ] All features working

---

## 🎉 You're Ready!

Kalau sudah sampai sini dan semua working:

**CONGRATULATIONS! 🎊**

Aplikasi Catatin sudah siap digunakan dan di-demo!

Happy coding! 💻✨

---

**Quick Links:**
- 🏠 [Back to README](README.md)
- 📚 [Full Documentation](PROJECT_STRUCTURE.md)
- 🎓 [Learn MVC](IMPLEMENTASI_MVC.md)
- 📖 [User Guide](CARA_PENGGUNAAN.md)
