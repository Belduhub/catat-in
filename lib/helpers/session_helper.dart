import 'package:shared_preferences/shared_preferences.dart';

/// SessionHelper - Singleton class untuk mengelola session user
/// Menggunakan SharedPreferences untuk persist login state
class SessionHelper {
  // Singleton instance
  static final SessionHelper _instance = SessionHelper._internal();
  factory SessionHelper() => _instance;
  SessionHelper._internal();

  // Keys untuk SharedPreferences
  static const String _keyIsLoggedIn = 'is_logged_in';
  static const String _keyUserId = 'user_id';
  static const String _keyUsername = 'username';
  static const String _keyFullName = 'full_name';

  /// Save login session
  Future<void> saveLoginSession({
    required int userId,
    required String username,
    String? fullName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setInt(_keyUserId, userId);
    await prefs.setString(_keyUsername, username);
    if (fullName != null) {
      await prefs.setString(_keyFullName, fullName);
    }
    print('Session saved: userId=$userId, username=$username');
  }

  /// Check apakah user sudah login
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// Get user id dari session
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  /// Get username dari session
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }

  /// Get full name dari session
  Future<String?> getFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFullName);
  }

  /// Update full name di session
  Future<void> updateFullName(String fullName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFullName, fullName);
  }

  /// Update username di session
  Future<void> updateUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username);
  }

  /// Clear session (logout)
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('Session cleared');
  }
}
