import '../helpers/database_helper.dart';
import '../helpers/session_helper.dart';
import '../models/user_model.dart';

/// AuthController - Controller untuk menangani autentikasi
/// Mengatur logic untuk login, register, dan logout
class AuthController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final SessionHelper _sessionHelper = SessionHelper();

  /// Login user dengan username dan password
  /// Returns: UserModel jika berhasil, null jika gagal
  Future<UserModel?> login(String username, String password) async {
    try {
      // Validasi input
      if (username.isEmpty || password.isEmpty) {
        throw Exception('Username dan password tidak boleh kosong');
      }

      // Query user dari database
      final user = await _dbHelper.getUserByCredentials(username, password);
      
      if (user != null) {
        // Save session
        await _sessionHelper.saveLoginSession(
          userId: user.id!,
          username: user.username,
          fullName: user.fullName,
        );
        print('Login successful: ${user.username}');
        return user;
      } else {
        print('Login failed: Invalid credentials');
        return null;
      }
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  /// Register user baru
  /// Returns: UserModel jika berhasil, null jika gagal
  Future<UserModel?> register({
    required String username,
    required String password,
    String? fullName,
  }) async {
    try {
      // Validasi input
      if (username.isEmpty || password.isEmpty) {
        throw Exception('Username dan password tidak boleh kosong');
      }

      // Cek apakah username sudah digunakan
      final existingUser = await _dbHelper.getUserByUsername(username);
      if (existingUser != null) {
        throw Exception('Username sudah digunakan');
      }

      // Create user baru
      final newUser = UserModel(
        username: username,
        password: password,
        fullName: fullName,
      );

      // Insert ke database
      final userId = await _dbHelper.insertUser(newUser);
      
      if (userId > 0) {
        final user = newUser.copyWith(id: userId);
        
        // Auto login setelah register
        await _sessionHelper.saveLoginSession(
          userId: user.id!,
          username: user.username,
          fullName: user.fullName,
        );
        
        print('Register successful: ${user.username}');
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('Register error: $e');
      rethrow;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await _sessionHelper.clearSession();
      print('Logout successful');
    } catch (e) {
      print('Logout error: $e');
      rethrow;
    }
  }

  /// Check apakah user sudah login
  Future<bool> isLoggedIn() async {
    return await _sessionHelper.isLoggedIn();
  }

  /// Get current logged in user
  Future<UserModel?> getCurrentUser() async {
    try {
      final userId = await _sessionHelper.getUserId();
      if (userId != null) {
        return await _dbHelper.getUserById(userId);
      }
      return null;
    } catch (e) {
      print('Get current user error: $e');
      return null;
    }
  }

  /// Get current user id
  Future<int?> getCurrentUserId() async {
    return await _sessionHelper.getUserId();
  }
}
