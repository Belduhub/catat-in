# Struktur Project Catatin - Arsitektur MVC

## 📁 Struktur Folder

```
lib/
├── main.dart                    # Entry point aplikasi
├── models/                      # Model Layer - Data representation
│   ├── user_model.dart         # Model untuk User
│   └── note_model.dart         # Model untuk Note/Catatan
│
├── views/                       # View Layer - UI Components
│   ├── login_page.dart         # Halaman Login
│   ├── register_page.dart      # Halaman Register
│   ├── dashboard_page.dart     # Halaman Dashboard (List Catatan)
│   ├── add_note_page.dart      # Halaman Tambah Catatan
│   ├── edit_note_page.dart     # Halaman Edit Catatan
│   ├── profile_page.dart       # Halaman Profile User
│   └── about_page.dart         # Halaman Tentang Kami
│
├── controllers/                 # Controller Layer - Business Logic
│   ├── auth_controller.dart    # Controller untuk Authentication
│   ├── note_controller.dart    # Controller untuk CRUD Note
│   └── profile_controller.dart # Controller untuk Profile Management
│
├── helpers/                     # Helper Classes
│   ├── database_helper.dart    # SQLite Database Management (Singleton)
│   └── session_helper.dart     # Session Management dengan SharedPreferences
│
└── utils/                       # Utilities & Constants
    └── constants.dart          # App Constants, Colors, TextStyles

```

## 🏗️ Arsitektur MVC

### Model Layer
**Tanggung Jawab:** Representasi data dan struktur database
- `UserModel`: Model untuk data user (id, username, password, fullName)
- `NoteModel`: Model untuk data catatan (id, title, content, category, createdAt, userId)

### View Layer  
**Tanggung Jawab:** Tampilan UI dan interaksi user
- `LoginPage`: Form login dengan validasi
- `RegisterPage`: Form registrasi user baru
- `DashboardPage`: List catatan dengan filter kategori & sorting
- `AddNotePage`: Form untuk menambah catatan baru
- `EditNotePage`: Form untuk mengedit catatan existing
- `ProfilePage`: Form untuk update profile user
- `AboutPage`: Informasi tentang aplikasi dan developer

### Controller Layer
**Tanggung Jawab:** Business logic dan orchestration
- `AuthController`: 
  - Login, Register, Logout
  - Check login status
  - Get current user info
  
- `NoteController`:
  - CRUD operations untuk catatan
  - Filter by category
  - Sort (A-Z, Z-A, Latest)
  - Data isolation per user
  
- `ProfileController`:
  - Get user profile
  - Update profile (username, password, fullName)
  - Change password

## 🗄️ Database Schema

### Tabel `users`
```sql
id INTEGER PRIMARY KEY AUTOINCREMENT
username TEXT UNIQUE NOT NULL
password TEXT NOT NULL
full_name TEXT
```

### Tabel `notes`
```sql
id INTEGER PRIMARY KEY AUTOINCREMENT
title TEXT NOT NULL
content TEXT NOT NULL
category TEXT NOT NULL
created_at TEXT NOT NULL
user_id INTEGER NOT NULL
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
```

## 🔑 Fitur Utama

### 1. Authentication
- **Login**: Validasi credentials dari database
- **Register**: Registrasi user baru dengan auto-login
- **Session Management**: Persist login state dengan SharedPreferences
- **Auto Seed**: Default user (admin/password123) untuk testing

### 2. CRUD Catatan
- **Create**: Tambah catatan baru dengan title, content, category
- **Read**: List semua catatan user dengan filter & sorting
- **Update**: Edit catatan existing
- **Delete**: Hapus catatan dengan confirmation
- **Data Isolation**: Setiap user hanya bisa lihat catatannya sendiri

### 3. Filter & Sorting
- **Filter Kategori**: Semua, Kuliah, Kerja, Pribadi
- **Sort Options**: 
  - Latest (created_at DESC)
  - A-Z (title ASC)
  - Z-A (title DESC)

### 4. Profile Management
- View dan edit profile user
- Update username, password, full name
- Validasi username uniqueness

### 5. About Us
- Informasi aplikasi
- Data developer (static)

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.4.1          # SQLite database
  path: ^1.9.0             # Path manipulation
  shared_preferences: ^2.3.4  # Local storage untuk session
  intl: ^0.19.0            # Date formatting
```

## 🎨 Design System

### Colors
- **Primary**: #0061A4 (Blue)
- **Background**: #F8F9FF (Light Blue)
- **Text Primary**: #404752 (Dark Gray)
- **Text Secondary**: #707883 (Gray)
- **Border**: #BFC7D4 (Light Gray)

### Categories Colors
- **Kuliah**: Green (#4CAF50)
- **Kerja**: Orange (#FF9800)
- **Pribadi**: Purple (#9C27B0)

### Typography
- **Font Family**: Inter (body), Hanken Grotesk (title)
- **Title**: 32px, Bold
- **Subtitle**: 14px, Regular
- **Label**: 12px, Medium
- **Input**: 14px, Regular
- **Button**: 14px, Semibold

## 🚀 Cara Menjalankan

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Run Application**
   ```bash
   flutter run
   ```

3. **Default Login**
   - Username: `admin`
   - Password: `password123`

## 📝 Flow Aplikasi

1. **Splash Screen** → Check session
   - Jika login → Dashboard
   - Jika belum → Login Page

2. **Login Page**
   - Input credentials
   - Validasi dari database
   - Save session → Dashboard

3. **Dashboard Page**
   - List catatan dengan filter & sort
   - Tap catatan → Edit Page
   - FAB (+) → Add Note Page
   - Menu → Profile / About / Logout

4. **Add/Edit Note Page**
   - Input title, category, content
   - Save → Back to Dashboard

5. **Profile Page**
   - Edit username, password, full name
   - Save → Update database & session

6. **Logout**
   - Clear session
   - Back to Login Page

## 🔒 Security Notes

- Password disimpan dalam plain text (untuk akademik)
- Production apps harus menggunakan hashing (bcrypt, argon2)
- Session management menggunakan SharedPreferences
- Data isolation berdasarkan user_id

## 🎯 Best Practices Applied

1. **Separation of Concerns**: Model-View-Controller terpisah
2. **Singleton Pattern**: DatabaseHelper & SessionHelper
3. **Async/Await**: Semua database operations
4. **Error Handling**: Try-catch dengan user feedback
5. **State Management**: StatefulWidget dengan setState()
6. **Code Organization**: Folder structure yang jelas
7. **Reusable Components**: Widget extraction
8. **Constants**: Centralized colors, text styles, app constants
9. **Validation**: Form validation di semua input
10. **User Feedback**: SnackBar untuk success/error messages

## 👥 Developers

- Danang Adiwibowo
- Gorga Doli Liberto Napitupulu

---

**Project**: catat.in - Aplikasi Catatan Sederhana  
**Framework**: Flutter  
**Architecture**: MVC (Model-View-Controller)  
**Database**: SQLite (sqflite)  
**Purpose**: Tugas UKPL (Ujian Kompetensi Pemrograman Lanjut)
