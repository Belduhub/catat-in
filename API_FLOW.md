# 🔄 API Flow & Data Architecture

## Arsitektur MVC - Data Flow

```
┌─────────────┐      ┌──────────────┐      ┌─────────────┐
│    View     │ ───> │  Controller  │ ───> │    Model    │
│  (UI Layer) │      │   (Logic)    │      │   (Data)    │
│             │ <─── │              │ <─── │             │
└─────────────┘      └──────────────┘      └─────────────┘
                            │
                            ▼
                     ┌──────────────┐
                     │   Helpers    │
                     │  - Database  │
                     │  - Session   │
                     └──────────────┘
```

## 📊 Database Operations Flow

### 1. Authentication Flow

#### Register Flow
```
RegisterPage
    │
    ├─> AuthController.register()
    │       │
    │       ├─> DatabaseHelper.getUserByUsername() // Check duplikat
    │       │       └─> SQLite Query: SELECT * FROM users WHERE username = ?
    │       │
    │       ├─> DatabaseHelper.insertUser()
    │       │       └─> SQLite Query: INSERT INTO users (username, password, full_name)
    │       │
    │       └─> SessionHelper.saveLoginSession() // Auto login
    │               └─> SharedPreferences.setInt/setString()
    │
    └─> Navigate to DashboardPage
```

#### Login Flow
```
LoginPage
    │
    ├─> AuthController.login()
    │       │
    │       ├─> DatabaseHelper.getUserByCredentials()
    │       │       └─> SQLite Query: 
    │       │           SELECT * FROM users 
    │       │           WHERE username = ? AND password = ?
    │       │
    │       └─> SessionHelper.saveLoginSession()
    │               └─> SharedPreferences:
    │                   - setInt('user_id')
    │                   - setString('username')
    │                   - setBool('is_logged_in')
    │
    └─> Navigate to DashboardPage
```

#### Logout Flow
```
DashboardPage
    │
    ├─> AuthController.logout()
    │       └─> SessionHelper.clearSession()
    │               └─> SharedPreferences.clear()
    │
    └─> Navigate to LoginPage (clear stack)
```

### 2. Notes CRUD Flow

#### Create Note Flow
```
AddNotePage
    │
    ├─> Form Input: title, content, category
    │
    ├─> NoteController.createNote()
    │       │
    │       ├─> Validate inputs
    │       │
    │       ├─> Create NoteModel object
    │       │       └─> new NoteModel(
    │       │               title, content, category,
    │       │               createdAt: DateTime.now(),
    │       │               userId: current_user_id
    │       │           )
    │       │
    │       └─> DatabaseHelper.insertNote()
    │               └─> SQLite Query:
    │                   INSERT INTO notes 
    │                   (title, content, category, created_at, user_id)
    │                   VALUES (?, ?, ?, ?, ?)
    │
    └─> Navigate back to DashboardPage
```

#### Read Notes Flow (with Filter & Sort)
```
DashboardPage
    │
    ├─> Select Category Filter (Semua/Kuliah/Kerja/Pribadi)
    ├─> Select Sort Option (Latest/A-Z/Z-A)
    │
    ├─> NoteController.getNotesFiltered()
    │       │
    │       ├─> AuthController.getCurrentUserId()
    │       │       └─> SessionHelper.getUserId()
    │       │
    │       └─> DatabaseHelper.getNotesFiltered(userId, category, sortBy)
    │               │
    │               └─> SQLite Query (example):
    │                   SELECT * FROM notes
    │                   WHERE user_id = ? AND category = ?
    │                   ORDER BY [title ASC | title DESC | created_at DESC]
    │
    └─> Display List<NoteModel> in UI
```

#### Update Note Flow
```
EditNotePage
    │
    ├─> Load existing note data
    │
    ├─> User edits: title, content, category
    │
    ├─> NoteController.updateNote()
    │       │
    │       ├─> Validate inputs
    │       │
    │       ├─> Create updated NoteModel
    │       │
    │       └─> DatabaseHelper.updateNote()
    │               └─> SQLite Query:
    │                   UPDATE notes
    │                   SET title = ?, content = ?, category = ?
    │                   WHERE id = ?
    │
    └─> Navigate back & refresh DashboardPage
```

#### Delete Note Flow
```
DashboardPage
    │
    ├─> User clicks delete icon
    │
    ├─> Show confirmation dialog
    │
    ├─> NoteController.deleteNote(noteId)
    │       └─> DatabaseHelper.deleteNote()
    │               └─> SQLite Query:
    │                   DELETE FROM notes WHERE id = ?
    │
    └─> Refresh notes list
```

### 3. Profile Management Flow

#### Update Profile Flow
```
ProfilePage
    │
    ├─> Load current user data
    │       ├─> AuthController.getCurrentUserId()
    │       └─> ProfileController.getUserProfile(userId)
    │               └─> DatabaseHelper.getUserById()
    │                       └─> SQLite: SELECT * FROM users WHERE id = ?
    │
    ├─> User edits: fullName, username, password
    │
    ├─> ProfileController.updateProfile()
    │       │
    │       ├─> Check username uniqueness (if changed)
    │       │       └─> DatabaseHelper.getUserByUsername()
    │       │
    │       ├─> DatabaseHelper.updateUser()
    │       │       └─> SQLite Query:
    │       │           UPDATE users
    │       │           SET username = ?, password = ?, full_name = ?
    │       │           WHERE id = ?
    │       │
    │       └─> SessionHelper.saveLoginSession() // Update session
    │               └─> Update SharedPreferences
    │
    └─> Navigate back with success message
```

## 🔐 Session Management

### Save Session
```dart
SessionHelper.saveLoginSession(
  userId: int,
  username: String,
  fullName: String?
)
    │
    ├─> SharedPreferences.setBool('is_logged_in', true)
    ├─> SharedPreferences.setInt('user_id', userId)
    ├─> SharedPreferences.setString('username', username)
    └─> SharedPreferences.setString('full_name', fullName)
```

### Check Session
```dart
SessionHelper.isLoggedIn()
    │
    └─> SharedPreferences.getBool('is_logged_in') ?? false
```

### Get Current User
```dart
SessionHelper.getUserId()
    │
    └─> SharedPreferences.getInt('user_id')
```

### Clear Session (Logout)
```dart
SessionHelper.clearSession()
    │
    └─> SharedPreferences.clear()
```

## 📦 Data Models

### UserModel
```dart
{
  id: int?,
  username: String,
  password: String,
  fullName: String?
}

Methods:
- toMap() → Map<String, dynamic>
- fromMap(Map) → UserModel
- copyWith() → UserModel
```

### NoteModel
```dart
{
  id: int?,
  title: String,
  content: String,
  category: String,
  createdAt: DateTime,
  userId: int
}

Methods:
- toMap() → Map<String, dynamic>
- fromMap(Map) → NoteModel
- copyWith() → NoteModel
```

## 🎯 Controller Methods

### AuthController
```dart
- login(username, password) → Future<UserModel?>
- register(username, password, fullName) → Future<UserModel?>
- logout() → Future<void>
- isLoggedIn() → Future<bool>
- getCurrentUser() → Future<UserModel?>
- getCurrentUserId() → Future<int?>
```

### NoteController
```dart
- createNote(title, content, category, userId) → Future<bool>
- getNotes(userId) → Future<List<NoteModel>>
- getNotesByCategory(userId, category) → Future<List<NoteModel>>
- getNotesSorted(userId, sortBy) → Future<List<NoteModel>>
- getNotesFiltered(userId, category, sortBy) → Future<List<NoteModel>>
- getNoteById(id) → Future<NoteModel?>
- updateNote(noteId, title, content, category, ...) → Future<bool>
- deleteNote(noteId) → Future<bool>
- getNotesCount(userId) → Future<int>
```

### ProfileController
```dart
- getUserProfile(userId) → Future<UserModel?>
- updateProfile(userId, username, password, fullName) → Future<bool>
- changePassword(userId, oldPassword, newPassword) → Future<bool>
```

## 🗄️ Database Helper Methods

### User Operations
```dart
- insertUser(UserModel) → Future<int>
- getUserByCredentials(username, password) → Future<UserModel?>
- getUserById(id) → Future<UserModel?>
- getUserByUsername(username) → Future<UserModel?>
- updateUser(UserModel) → Future<int>
- deleteUser(id) → Future<int>
```

### Note Operations
```dart
- insertNote(NoteModel) → Future<int>
- getNotesByUserId(userId) → Future<List<NoteModel>>
- getNotesByCategory(userId, category) → Future<List<NoteModel>>
- getNotesSorted(userId, sortBy) → Future<List<NoteModel>>
- getNotesFiltered(userId, category?, sortBy) → Future<List<NoteModel>>
- getNoteById(id) → Future<NoteModel?>
- updateNote(NoteModel) → Future<int>
- deleteNote(id) → Future<int>
- getNotesCount(userId) → Future<int>
```

## 🔄 State Management

Menggunakan **StatefulWidget** dengan **setState()**:

```dart
// Load data
Future<void> _loadData() async {
  setState(() => _isLoading = true);
  
  // Fetch data from controller
  final data = await _controller.getData();
  
  setState(() {
    _data = data;
    _isLoading = false;
  });
}

// Update UI
setState(() {
  _selectedCategory = newCategory;
});
_loadNotes(); // Reload with new filter
```

## 🚨 Error Handling

```dart
try {
  // Database operation
  await _controller.someOperation();
  
  // Success feedback
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Berhasil'))
  );
} catch (e) {
  // Error feedback
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Error: $e'),
      backgroundColor: Colors.red,
    )
  );
}
```

## 🎨 UI Update Pattern

```dart
1. User Action (tap button, input text, etc)
   ↓
2. Call Controller Method
   ↓
3. Controller processes business logic
   ↓
4. Controller calls Database/Helper
   ↓
5. Database returns data
   ↓
6. Controller returns to View
   ↓
7. View calls setState() to update UI
   ↓
8. Flutter rebuilds widget tree
   ↓
9. User sees updated UI
```

## 📱 App Lifecycle

```
Splash Screen
    │
    ├─ Check Session (isLoggedIn?)
    │
    ├─ YES → DashboardPage (load notes)
    │
    └─ NO → LoginPage
            │
            ├─ Login success → DashboardPage
            │
            └─ Register → DashboardPage (auto login)
```

---

**Architecture Pattern**: MVC (Model-View-Controller)  
**Database**: SQLite with sqflite package  
**State Management**: StatefulWidget + setState()  
**Session**: SharedPreferences  
**Navigation**: Navigator with MaterialPageRoute
