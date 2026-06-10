# 📝 Catatin - Aplikasi Catatan Sederhana

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-3.11+-blue?logo=flutter" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.0+-blue?logo=dart" alt="Dart">
  <img src="https://img.shields.io/badge/Architecture-MVC-green" alt="MVC">
  <img src="https://img.shields.io/badge/Database-SQLite-orange?logo=sqlite" alt="SQLite">
</div>

## 📖 Deskripsi

**Catatin** adalah aplikasi catatan sederhana yang dibuat dengan Flutter menggunakan arsitektur **MVC (Model-View-Controller)**. Aplikasi ini memungkinkan user untuk membuat, membaca, mengupdate, dan menghapus catatan dengan fitur filter kategori dan sorting.

### ✨ Fitur Utama

- 🔐 **Authentication** - Login & Register dengan session management
- 📝 **CRUD Catatan** - Create, Read, Update, Delete catatan
- 🏷️ **Kategori** - Filter catatan berdasarkan kategori (Kuliah, Kerja, Pribadi)
- 🔤 **Sorting** - Sort by Latest, A-Z, Z-A
- 👤 **Profile Management** - Edit username, password, dan nama lengkap
- 🔒 **Data Isolation** - Setiap user hanya bisa lihat catatannya sendiri
- 💾 **Offline First** - Semua data tersimpan lokal dengan SQLite
- 🎨 **Modern UI** - Design bersih dan responsive

## 🏗️ Arsitektur

Project ini menggunakan **MVC (Model-View-Controller)** pattern:

```
lib/
├── models/              # Data models & structure
├── views/               # UI screens & widgets
├── controllers/         # Business logic
├── helpers/            # Database & session helpers
├── utils/              # Constants & utilities
└── main.dart           # Entry point
```

### Architecture Flow
```
View → Controller → Helper → Model → Database
  ↑_________←_________←_______←_______↲
```

📚 **Dokumentasi Lengkap**: [IMPLEMENTASI_MVC.md](IMPLEMENTASI_MVC.md)

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.11 atau lebih baru
- Dart SDK 3.0 atau lebih baru
- Android Studio / VS Code
- Emulator atau Physical Device

### Installation

1. **Clone repository**
   ```bash
   git clone <repository-url>
   cd catatin
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run application**
   ```bash
   flutter run
   ```

4. **IMPORTANT: Hot Restart After First Run**
   
   Setelah app terbuka pertama kali:
   - Tekan **'R'** (capital R, bukan lowercase r) di terminal
   - Ini akan full restart dan initialize database dengan benar
   - Atau stop app dan run ulang dengan `flutter run`
   
   **Why?** FFI initialization butuh full restart, bukan hot reload.

### Default Login
```
Username: admin
Password: password123
```

### Verification
Setelah app running, check console untuk log ini:
```
✅ FFI Database initialized for desktop platform
🔧 Initializing database at: ...
✅ Database opened successfully
```

## 🔧 Known Issues & Fixes

### ✅ Database Initialization Error (FIXED)
Error "databaseFactory not initialized" **sudah di-fix** dengan:
- FFI initialization di `main()` function
- Proper timing dengan `WidgetsFlutterBinding.ensureInitialized()`
- Cross-platform support (Desktop FFI + Mobile Native)

**Detail fix**: Lihat [DATABASE_FIX_GUIDE.md](DATABASE_FIX_GUIDE.md)  
**Troubleshooting**: Lihat [TROUBLESHOOTING.md](TROUBLESHOOTING.md)

## 📱 Screenshots

### Login & Register
- Form login dengan validasi
- Register user baru dengan auto-login
- Session management dengan SharedPreferences

### Dashboard
- List catatan dengan card design
- Filter horizontal chips (Semua, Kuliah, Kerja, Pribadi)
- Sort menu (Latest, A-Z, Z-A)
- FAB button untuk tambah catatan

### Add & Edit Note
- Form title, category dropdown, content textarea
- Input validation
- Category color-coded

### Profile
- Edit nama lengkap, username, password
- Update session setelah perubahan

## 📦 Dependencies

```yaml
dependencies:
  sqflite: ^2.4.1          # SQLite database
  path: ^1.9.0             # Path manipulation  
  shared_preferences: ^2.3.4  # Session storage
  intl: ^0.19.0            # Date formatting
```

## 🗄️ Database Schema

### Users Table
```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  full_name TEXT
)
```

### Notes Table
```sql
CREATE TABLE notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  category TEXT NOT NULL,
  created_at TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
)
```

## 📂 Project Structure

```
catatin/
│
├── lib/
│   ├── main.dart                    # Entry point
│   │
│   ├── models/                      # 📊 Data Models
│   │   ├── user_model.dart
│   │   └── note_model.dart
│   │
│   ├── views/                       # 🎨 UI Screens
│   │   ├── login_page.dart
│   │   ├── register_page.dart
│   │   ├── dashboard_page.dart
│   │   ├── add_note_page.dart
│   │   ├── edit_note_page.dart
│   │   ├── profile_page.dart
│   │   └── about_page.dart
│   │
│   ├── controllers/                 # 🎮 Business Logic
│   │   ├── auth_controller.dart
│   │   ├── note_controller.dart
│   │   └── profile_controller.dart
│   │
│   ├── helpers/                     # 🛠️ Helpers
│   │   ├── database_helper.dart     # SQLite operations
│   │   └── session_helper.dart      # Session management
│   │
│   └── utils/                       # 🎨 Utilities
│       └── constants.dart           # Colors, styles, constants
│
├── docs/                            # 📚 Documentation
│   ├── PROJECT_STRUCTURE.md
│   ├── IMPLEMENTASI_MVC.md
│   ├── API_FLOW.md
│   └── CARA_PENGGUNAAN.md
│
├── pubspec.yaml
└── README.md
```

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) | Struktur folder & file lengkap |
| [IMPLEMENTASI_MVC.md](IMPLEMENTASI_MVC.md) | Penjelasan MVC pattern detail |
| [API_FLOW.md](API_FLOW.md) | Data flow & API reference |
| [CARA_PENGGUNAAN.md](CARA_PENGGUNAAN.md) | User guide lengkap |
| [QUICK_START.md](QUICK_START.md) | Quick start guide |
| [DATABASE_FIX_GUIDE.md](DATABASE_FIX_GUIDE.md) | ⭐ Database fix complete guide |
| [TROUBLESHOOTING.md](TROUBLESHOOTING.md) | Common issues & solutions |
| [FIX_NOTES.md](FIX_NOTES.md) | Recent fixes & updates |

## 🎯 Features Detail

### Authentication
- ✅ Login dengan username & password
- ✅ Register user baru
- ✅ Session persistence (auto-login)
- ✅ Logout dengan clear session
- ✅ Default user seeding untuk testing

### Notes Management  
- ✅ Create note dengan title, content, category
- ✅ Read notes list dengan filter & sort
- ✅ Update existing note
- ✅ Delete note dengan confirmation
- ✅ Category filter (Semua/Kuliah/Kerja/Pribadi)
- ✅ Sort options (Latest/A-Z/Z-A)

### Profile
- ✅ View user profile
- ✅ Update nama lengkap
- ✅ Update username (with uniqueness check)
- ✅ Change password
- ✅ Session update after changes

### About Us
- ✅ App information
- ✅ Developers info
- ✅ Version display

## 🎨 Design System

### Color Palette
```dart
Primary:     #0061A4  // Blue
Background:  #F8F9FF  // Light Blue
Text:        #404752  // Dark Gray
Secondary:   #707883  // Gray
Border:      #BFC7D4  // Light Gray
```

### Category Colors
```dart
Kuliah:   #4CAF50  // Green
Kerja:    #FF9800  // Orange
Pribadi:  #9C27B0  // Purple
```

## 🧪 Testing

```bash
# Run flutter analyze
flutter analyze

# Build release APK
flutter build apk --release

# Build for web
flutter build web --release
```

## 👥 Team

- **Danang Adiwibowo** - Developer
- **Gorga Doli Liberto Napitupulu** - Developer

## 📄 License

This project is created for educational purposes (UKPL - Ujian Kompetensi Pemrograman Lanjut).

## 🙏 Acknowledgments

- Flutter Team untuk framework yang luar biasa
- sqflite package untuk SQLite integration
- shared_preferences untuk local storage
- Material Design untuk design guidelines

---

<div align="center">
  <strong>Made with ❤️ using Flutter & MVC Architecture</strong>
</div>
