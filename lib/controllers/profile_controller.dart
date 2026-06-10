import '../helpers/database_helper.dart';
import '../helpers/session_helper.dart';
import '../models/user_model.dart';

/// ProfileController - Controller untuk menangani operasi profile user
class ProfileController {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final SessionHelper _sessionHelper = SessionHelper();

  /// Get user profile by id
  Future<UserModel?> getUserProfile(int userId) async {
    try {
      return await _dbHelper.getUserById(userId);
    } catch (e) {
      print('Get user profile error: $e');
      return null;
    }
  }

  /// Update user profile
  Future<bool> updateProfile({
    required int userId,
    String? username,
    String? password,
    String? fullName,
  }) async {
    try {
      // Get current user data
      final currentUser = await _dbHelper.getUserById(userId);
      if (currentUser == null) {
        throw Exception('User tidak ditemukan');
      }

      // Jika username diubah, cek apakah sudah digunakan
      if (username != null && username != currentUser.username) {
        final existingUser = await _dbHelper.getUserByUsername(username);
        if (existingUser != null) {
          throw Exception('Username sudah digunakan');
        }
      }

      // Create updated user
      final updatedUser = currentUser.copyWith(
        username: username ?? currentUser.username,
        password: password ?? currentUser.password,
        fullName: fullName ?? currentUser.fullName,
      );

      // Update di database
      final result = await _dbHelper.updateUser(updatedUser);
      
      if (result > 0) {
        // Update session juga
        await _sessionHelper.saveLoginSession(
          userId: userId,
          username: updatedUser.username,
          fullName: updatedUser.fullName,
        );
        print('Profile updated successfully');
        return true;
      }
      return false;
    } catch (e) {
      print('Update profile error: $e');
      rethrow;
    }
  }

  /// Change password
  Future<bool> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      // Get current user
      final currentUser = await _dbHelper.getUserById(userId);
      if (currentUser == null) {
        throw Exception('User tidak ditemukan');
      }

      // Verify old password
      if (currentUser.password != oldPassword) {
        throw Exception('Password lama tidak sesuai');
      }

      // Update password
      final updatedUser = currentUser.copyWith(password: newPassword);
      final result = await _dbHelper.updateUser(updatedUser);
      
      print('Password changed successfully');
      return result > 0;
    } catch (e) {
      print('Change password error: $e');
      rethrow;
    }
  }
}
