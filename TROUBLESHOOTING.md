# 🔧 Troubleshooting Guide - Catatin App

## ❌ Common Errors & Solutions

### 1. "Bad state: databaseFactory not initialized" Error

**Error Message:**
```
Registrasi gagal: Bad state: databaseFactory not initialized
databaseFactory is only initialized when using sqflite. When using sqflite_common_ffi
You must call databaseFactory = databaseFactoryFfi; before using global openDatabase API
```

**Cause:**
- SQLite tidak terinisialisasi dengan benar di platform desktop (Windows/Linux/macOS)
- sqflite memerlukan FFI (Foreign Function Interface) untuk desktop platforms

**Solution:** ✅ SUDAH DIFIX!

File `lib/main.dart` sudah diupdate dengan inisialisasi yang benar:

```dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;

void main() {
  // Initialize sqflite for desktop platforms
  if (!kIsWeb) {
    try {
      if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
      }
    } catch (e) {
      debugPrint('Platform check failed: $e');
    }
  }
  
  runApp(const CatatinApp());
}
```

**Dependencies yang ditambahkan:**
```yaml
dependencies:
  sqflite_common_ffi: ^2.3.4
```

**Cara Apply Fix:**
```bash
# 1. Pull/update code terbaru
# 2. Install dependencies
flutter pub get

# 3. Hot restart app (bukan hot reload)
# Tekan 'R' di terminal

# 4. Atau run ulang
flutter run
```

---

### 2. Hot Reload Tidak Mengapply Changes

**Problem:**
- Perubahan code tidak terlihat setelah hot reload

**Solution:**
```bash
# Gunakan Hot RESTART (capital R)
R

# Atau stop & run ulang
q  # quit
flutter run
```

---

### 3. Build Error After Adding Dependencies

**Error:**
```
Error: Could not resolve dependencies
```

**Solution:**
```bash
# Clean build cache
flutter clean

# Re-install dependencies
flutter pub get

# Run again
flutter run
```

---

### 4. Database Lock Error

**Error:**
```
DatabaseException: database is locked
```

**Solution:**
```bash
# Close all instances of app
# Restart emulator/device
# Run app lagi
```

**Atau:**
- Uninstall app dari device
- Run ulang (akan create database baru)

---

### 5. Emulator Not Detected

**Problem:**
```
No devices found
```

**Solution:**
```bash
# Check available emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator-id>

# Check devices
flutter devices

# Run with specific device
flutter run -d <device-id>
```

---

### 6. SQLite Version Mismatch

**Error:**
```
Version mismatch in SQLite
```

**Solution:**
```bash
# Update dependencies
flutter pub upgrade

# Clean & rebuild
flutter clean
flutter pub get
flutter run
```

---

### 7. SharedPreferences Error

**Error:**
```
Cannot save to SharedPreferences
```

**Solution:**
- Restart app
- Untuk testing, bisa clear app data dari device settings
- Run ulang

---

### 8. Form Validation Not Working

**Problem:**
- Form tidak validate input

**Check:**
1. Pastikan `_formKey.currentState!.validate()` dipanggil
2. Pastikan `validator` ada di TextFormField
3. Pastikan form wrapped dengan `Form(key: _formKey)`

**Example:**
```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: TextFormField(
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Field tidak boleh kosong';
      }
      return null;
    },
  ),
)

// On submit
if (_formKey.currentState!.validate()) {
  // Process form
}
```

---

### 9. Navigation Error

**Error:**
```
Navigator operation requested with a context that does not include a Navigator
```

**Solution:**
- Pastikan `context` yang digunakan adalah dari widget yang wrapped dengan `MaterialApp`
- Gunakan `Navigator.of(context)` atau `Navigator.push(context, ...)`
- Check bahwa widget tree setup dengan benar

---

### 10. "setState called after dispose" Error

**Error:**
```
setState() called after dispose()
```

**Solution:**
```dart
// Always check mounted before setState
if (mounted) {
  setState(() {
    // Update state
  });
}
```

---

## 🛠️ Debug Commands

### Check Flutter Installation
```bash
flutter doctor -v
```

### Analyze Code
```bash
flutter analyze
```

### Clean Build
```bash
flutter clean
```

### Update Dependencies
```bash
flutter pub upgrade
```

### Run with Verbose
```bash
flutter run -v
```

### Check Device Logs (Android)
```bash
flutter logs
```

---

## 📱 Platform-Specific Issues

### Windows

**DLL Missing:**
```bash
# Make sure Visual Studio Build Tools installed
# Or install Visual Studio Community
```

**Firewall:**
- Allow Flutter through Windows Firewall

### Android

**Gradle Build Error:**
```bash
# Clean gradle
cd android
./gradlew clean
cd ..
flutter clean
flutter run
```

**SDK not found:**
- Set `ANDROID_HOME` environment variable
- Update SDK tools

### Web

**CORS Error:**
- Use `flutter run -d chrome --web-renderer html`
- Or configure CORS on backend

---

## 🔍 Debug Mode

Enable debug print untuk see database operations:

```dart
// In DatabaseHelper
Future<int> insertUser(UserModel user) async {
  final db = await database;
  final result = await db.insert(tableUsers, user.toMap());
  print('DEBUG: User inserted with id: $result'); // Debug
  return result;
}
```

---

## 📊 Verify Database

Check if database created correctly:

**Android:**
```bash
# Find database location
flutter run
# Check logs for database path
# Usually: /data/data/com.example.catatin/databases/catatin.db
```

**Windows:**
```bash
# Database location:
# C:\Users\<Username>\AppData\Local\<AppName>\databases\catatin.db
```

**Check tables:**
```bash
# Use SQLite browser tools
# Or add debug query in DatabaseHelper:
final tables = await db.rawQuery(
  "SELECT name FROM sqlite_master WHERE type='table'"
);
print('Tables: $tables');
```

---

## ✅ Post-Fix Verification

Setelah apply fix, verify:

1. ✅ App starts without errors
2. ✅ Can register new user
3. ✅ Can login
4. ✅ Can create notes
5. ✅ Can read/filter/sort notes
6. ✅ Can update notes
7. ✅ Can delete notes
8. ✅ Can update profile
9. ✅ Can logout
10. ✅ Session persists after restart

---

## 🆘 Still Having Issues?

### 1. Check Flutter Version
```bash
flutter --version
# Should be 3.11 or higher
```

### 2. Check Dependencies
```bash
flutter pub deps
```

### 3. Run Doctor
```bash
flutter doctor
# Fix any issues shown
```

### 4. Clean Everything
```bash
flutter clean
rm -rf build/  # or rmdir /s build (Windows)
flutter pub get
flutter run
```

### 5. Restart IDE
- Close VS Code / Android Studio
- Restart
- Run again

### 6. Restart Device/Emulator
- Close emulator
- Start fresh
- Run app

---

## 📝 Report Issue Checklist

Jika masih error, collect info:

- [ ] Flutter version (`flutter --version`)
- [ ] Platform (Windows/Android/etc)
- [ ] Full error message (screenshot atau copy text)
- [ ] Stack trace (dari console)
- [ ] Steps to reproduce
- [ ] What you've tried

---

## 🎯 Quick Fix Summary

**Most Common Issues:**

| Issue | Quick Fix |
|-------|-----------|
| Database error | Hot restart (R) |
| Build error | `flutter clean && flutter pub get` |
| UI not updating | Check `setState()` |
| Navigation error | Check context |
| Emulator not found | `flutter devices` |
| Dependencies error | `flutter pub upgrade` |

---

**Status**: All known issues resolved ✅  
**Last Updated**: June 10, 2026  
**App Version**: 1.0.0
