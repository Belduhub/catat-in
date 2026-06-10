# 📚 Implementasi MVC Pattern - Catatin App

## 🎯 Apa itu MVC?

**MVC (Model-View-Controller)** adalah design pattern yang memisahkan aplikasi menjadi 3 komponen utama:

1. **Model**: Data dan business rules
2. **View**: User Interface (UI)
3. **Controller**: Logic yang menghubungkan Model dan View

## 🏗️ Implementasi dalam Project Catatin

### 📦 Model Layer (lib/models/)

#### Tanggung Jawab:
- Representasi struktur data
- Konversi data ke/dari database (Map)
- Data validation rules

#### Files:
1. **user_model.dart**
   ```dart
   class UserModel {
     final int? id;
     final String username;
     final String password;
     final String? fullName;
     
     // Methods:
     - toMap()      // Convert ke Map untuk database
     - fromMap()    // Convert dari Map database ke object
     - copyWith()   // Create copy dengan perubahan tertentu
   }
   ```

2. **note_model.dart**
   ```dart
   class NoteModel {
     final int? id;
     final String title;
     final String content;
     final String category;
     final DateTime createdAt;
     final int userId;
     
     // Methods:
     - toMap()
     - fromMap()
     - copyWith()
   }
   ```

**Kenapa penting?**
- Single source of truth untuk struktur data
- Type-safe (compile-time checking)
- Mudah di-maintain dan di-test

---

### 🎨 View Layer (lib/views/)

#### Tanggung Jawab:
- Menampilkan UI ke user
- Menerima input dari user
- Tidak boleh ada business logic
- Hanya memanggil Controller

#### Files:
1. **login_page.dart** - Form login
2. **register_page.dart** - Form registrasi
3. **dashboard_page.dart** - List catatan dengan filter & sort
4. **add_note_page.dart** - Form tambah catatan
5. **edit_note_page.dart** - Form edit catatan
6. **profile_page.dart** - Form edit profile
7. **about_page.dart** - Halaman info app

#### Pattern yang Digunakan:
```dart
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1. Initialize Controller
  final AuthController _authController = AuthController();
  
  // 2. Local State (UI only)
  bool _isLoading = false;
  bool _hasError = false;
  
  // 3. Handle User Action
  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    
    // 4. Call Controller (NO direct database access!)
    final user = await _authController.login(username, password);
    
    // 5. Update UI based on result
    if (user != null) {
      // Success: Navigate
      Navigator.push(...);
    } else {
      // Error: Show message
      setState(() => _hasError = true);
      ScaffoldMessenger.showSnackBar(...);
    }
  }
  
  // 6. Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildForm(),
    );
  }
}
```

**Kenapa penting?**
- Separation of concerns (UI terpisah dari logic)
- Mudah diubah tampilan tanpa affect logic
- Reusable widgets

---

### 🎮 Controller Layer (lib/controllers/)

#### Tanggung Jawab:
- Business logic aplikasi
- Orchestrate data flow antara Model dan View
- Validasi input
- Error handling
- Memanggil Helper classes (Database, Session)

#### Files:

1. **auth_controller.dart**
   ```dart
   class AuthController {
     // Dependencies
     final DatabaseHelper _dbHelper = DatabaseHelper();
     final SessionHelper _sessionHelper = SessionHelper();
     
     // Business Methods
     Future<UserModel?> login(username, password) {
       // 1. Validate input
       // 2. Query database via Helper
       // 3. Save session if success
       // 4. Return result
     }
     
     Future<UserModel?> register(...) { }
     Future<void> logout() { }
     Future<bool> isLoggedIn() { }
     Future<UserModel?> getCurrentUser() { }
   }
   ```

2. **note_controller.dart**
   ```dart
   class NoteController {
     final DatabaseHelper _dbHelper = DatabaseHelper();
     
     Future<bool> createNote(...) {
       // 1. Validate
       // 2. Create Model object
       // 3. Save via DatabaseHelper
       // 4. Return success/fail
     }
     
     Future<List<NoteModel>> getNotesFiltered(...) {
       // 1. Get from DatabaseHelper
       // 2. Apply filter & sorting via SQL
       // 3. Return List<NoteModel>
     }
     
     Future<bool> updateNote(...) { }
     Future<bool> deleteNote(...) { }
   }
   ```

3. **profile_controller.dart**
   ```dart
   class ProfileController {
     Future<UserModel?> getUserProfile(userId) { }
     Future<bool> updateProfile(...) {
       // 1. Check username uniqueness
       // 2. Update database
       // 3. Update session
     }
     Future<bool> changePassword(...) { }
   }
   ```

**Kenapa penting?**
- Centralized business logic
- Easy to test (mock dependencies)
- Reusable across multiple views
- Single Responsibility Principle

---

### 🛠️ Helper Layer (lib/helpers/)

#### Tanggung Jawab:
- Low-level operations
- Database access
- Local storage (session)
- Utility functions

#### Files:

1. **database_helper.dart** (Singleton Pattern)
   ```dart
   class DatabaseHelper {
     // Singleton implementation
     static final DatabaseHelper _instance = DatabaseHelper._internal();
     factory DatabaseHelper() => _instance;
     DatabaseHelper._internal();
     
     static Database? _database;
     
     Future<Database> get database async {
       if (_database != null) return _database!;
       _database = await _initDatabase();
       return _database!;
     }
     
     // User CRUD
     Future<int> insertUser(UserModel user) { }
     Future<UserModel?> getUserByCredentials(...) { }
     Future<int> updateUser(UserModel user) { }
     
     // Note CRUD
     Future<int> insertNote(NoteModel note) { }
     Future<List<NoteModel>> getNotesByUserId(userId) { }
     Future<List<NoteModel>> getNotesFiltered(...) { }
     Future<int> updateNote(NoteModel note) { }
     Future<int> deleteNote(id) { }
   }
   ```

2. **session_helper.dart** (Singleton Pattern)
   ```dart
   class SessionHelper {
     static final SessionHelper _instance = SessionHelper._internal();
     factory SessionHelper() => _instance;
     SessionHelper._internal();
     
     Future<void> saveLoginSession(...) {
       // Save to SharedPreferences
     }
     
     Future<bool> isLoggedIn() {
       // Check SharedPreferences
     }
     
     Future<int?> getUserId() { }
     Future<void> clearSession() { }
   }
   ```

**Kenapa Singleton Pattern?**
- Only one instance of database connection
- Prevent multiple database initialization
- Memory efficient

---

### 🎨 Utils Layer (lib/utils/)

#### Tanggung Jawab:
- App-wide constants
- Reusable utilities
- Configuration

#### Files:

1. **constants.dart**
   ```dart
   class AppConstants {
     static const String appName = 'catat.in';
     static const List<String> categories = [
       'Semua', 'Kuliah', 'Kerja', 'Pribadi'
     ];
     static const List<String> sortOptions = [
       'Latest', 'A-Z', 'Z-A'
     ];
     static const List<Map> creators = [...];
   }
   
   class AppColors {
     static const Color primary = Color(0xFF0061A4);
     static const Color background = Color(0xFFF8F9FF);
     static Color getCategoryColor(String category) { }
   }
   
   class AppTextStyles {
     static const TextStyle title = TextStyle(...);
     static const TextStyle subtitle = TextStyle(...);
     static const TextStyle label = TextStyle(...);
   }
   ```

**Kenapa penting?**
- DRY (Don't Repeat Yourself)
- Easy to maintain
- Consistent design system

---

## 🔄 Complete Flow Example: Login

### Step-by-Step:

```
1. USER ACTION
   └─> LoginPage: User tap "Masuk" button

2. VIEW LAYER (login_page.dart)
   └─> Call: _handleLogin()
       └─> Validate form
       └─> Set loading state: setState(() => _isLoading = true)

3. CONTROLLER LAYER (auth_controller.dart)
   └─> Call: AuthController.login(username, password)
       └─> Validate input (tidak boleh kosong)

4. HELPER LAYER (database_helper.dart)
   └─> Call: DatabaseHelper.getUserByCredentials(username, password)
       └─> Execute SQL Query:
           SELECT * FROM users WHERE username = ? AND password = ?
       └─> Return: Map<String, dynamic> or null

5. MODEL LAYER (user_model.dart)
   └─> Convert: UserModel.fromMap(map)
       └─> Return: UserModel object

6. CONTROLLER LAYER (auth_controller.dart)
   └─> If user found:
       └─> Call: SessionHelper.saveLoginSession(user)
       └─> Return: UserModel to View

7. HELPER LAYER (session_helper.dart)
   └─> Save to SharedPreferences:
       - is_logged_in: true
       - user_id: 1
       - username: "admin"

8. VIEW LAYER (login_page.dart)
   └─> Receive result from Controller
   └─> If success:
       └─> Navigator.pushReplacement(DashboardPage)
   └─> If fail:
       └─> setState(() => _hasError = true)
       └─> Show SnackBar error message

9. UI UPDATE
   └─> Flutter rebuilds widget tree
   └─> User sees result
```

---

## 📊 Data Flow Diagram

```
┌─────────────────────────────────────────────────┐
│                  USER INTERFACE                 │
│              (View Layer - UI)                  │
│  login_page, dashboard_page, add_note_page, ... │
└────────────────────┬────────────────────────────┘
                     │ User Action (tap, input, ...)
                     ▼
┌─────────────────────────────────────────────────┐
│              CONTROLLER LAYER                   │
│          (Business Logic & Validation)          │
│  AuthController, NoteController, ProfileControl │
└────────────────────┬────────────────────────────┘
                     │ Data Operations
                     ▼
┌─────────────────────────────────────────────────┐
│               HELPER LAYER                      │
│       (Low-level Operations & Services)         │
│    DatabaseHelper (SQL), SessionHelper (Local)  │
└────────────────────┬────────────────────────────┘
                     │ CRUD Operations
                     ▼
┌─────────────────────────────────────────────────┐
│                MODEL LAYER                      │
│             (Data Representation)               │
│         UserModel, NoteModel (toMap/fromMap)    │
└────────────────────┬────────────────────────────┘
                     │ Persist Data
                     ▼
┌─────────────────────────────────────────────────┐
│              DATA STORAGE                       │
│     SQLite Database + SharedPreferences         │
│    users table, notes table, session keys       │
└─────────────────────────────────────────────────┘
```

---

## ✅ Benefits of MVC in This Project

### 1. **Separation of Concerns**
   - UI code (View) tidak bercampur dengan logic (Controller)
   - Database queries (Helper) terpisah dari business rules
   - Easy to understand dan maintain

### 2. **Testability**
   - Bisa test Controller tanpa UI
   - Bisa mock DatabaseHelper untuk unit testing
   - Isolated components

### 3. **Reusability**
   - Controller bisa dipanggil dari multiple Views
   - Model bisa digunakan di berbagai context
   - Helper methods reusable

### 4. **Maintainability**
   - Perubahan UI tidak affect logic
   - Ganti database tidak affect View
   - Clear responsibility per layer

### 5. **Scalability**
   - Mudah tambah fitur baru
   - Follow consistent pattern
   - Team collaboration friendly

---

## 🎓 Best Practices Applied

1. ✅ **Singleton Pattern** untuk DatabaseHelper & SessionHelper
2. ✅ **Factory Constructor** untuk Model.fromMap()
3. ✅ **Async/Await** untuk semua database operations
4. ✅ **Try-Catch** untuk error handling
5. ✅ **setState()** untuk reactive UI updates
6. ✅ **const Constructors** untuk widgets yang immutable
7. ✅ **Named Parameters** untuk better readability
8. ✅ **Null Safety** (int?, String?, UserModel?)
9. ✅ **Private Members** (_controller, _isLoading)
10. ✅ **Single Responsibility** - each class has one job

---

## 🚀 Quick Reference

| Layer | Folder | Purpose | Example |
|-------|--------|---------|---------|
| **Model** | `/models` | Data structure | `UserModel`, `NoteModel` |
| **View** | `/views` | UI screens | `LoginPage`, `DashboardPage` |
| **Controller** | `/controllers` | Business logic | `AuthController`, `NoteController` |
| **Helper** | `/helpers` | Low-level ops | `DatabaseHelper`, `SessionHelper` |
| **Utils** | `/utils` | Constants | `AppColors`, `AppTextStyles` |

---

**Conclusion**: Arsitektur MVC membuat aplikasi Catatin menjadi **clean**, **maintainable**, dan **scalable**. Setiap komponen punya tanggung jawab yang jelas, dan perubahan di satu layer tidak akan break layer lainnya.

🎉 **Happy Coding!**
