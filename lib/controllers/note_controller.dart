import '../helpers/database_helper.dart';
import '../models/note_model.dart';

/// NoteController - Controller untuk menangani operasi CRUD catatan
class NoteController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  /// Create note baru
  Future<bool> createNote({
    required String title,
    required String content,
    required String category,
    required int userId,
  }) async {
    try {
      // Validasi input
      if (title.isEmpty || content.isEmpty || category.isEmpty) {
        throw Exception('Semua field harus diisi');
      }

      final note = NoteModel(
        title: title,
        content: content,
        category: category,
        createdAt: DateTime.now(),
        userId: userId,
      );

      final noteId = await _dbHelper.insertNote(note);
      print('Note created with id: $noteId');
      return noteId > 0;
    } catch (e) {
      print('Create note error: $e');
      rethrow;
    }
  }

  /// Get semua notes untuk user tertentu
  Future<List<NoteModel>> getNotes(int userId) async {
    try {
      return await _dbHelper.getNotesByUserId(userId);
    } catch (e) {
      print('Get notes error: $e');
      return [];
    }
  }

  /// Get notes dengan filter kategori
  Future<List<NoteModel>> getNotesByCategory(int userId, String category) async {
    try {
      if (category == 'Semua') {
        return await _dbHelper.getNotesByUserId(userId);
      }
      return await _dbHelper.getNotesByCategory(userId, category);
    } catch (e) {
      print('Get notes by category error: $e');
      return [];
    }
  }

  /// Get notes dengan sorting
  Future<List<NoteModel>> getNotesSorted(int userId, String sortBy) async {
    try {
      return await _dbHelper.getNotesSorted(userId, sortBy);
    } catch (e) {
      print('Get notes sorted error: $e');
      return [];
    }
  }

  /// Get notes dengan filter DAN sorting
  Future<List<NoteModel>> getNotesFiltered({
    required int userId,
    String? category,
    required String sortBy,
  }) async {
    try {
      return await _dbHelper.getNotesFiltered(userId, category, sortBy);
    } catch (e) {
      print('Get notes filtered error: $e');
      return [];
    }
  }

  /// Search notes berdasarkan keyword
  Future<List<NoteModel>> searchNotes({
    required int userId,
    required String keyword,
    String? category,
    required String sortBy,
  }) async {
    try {
      return await _dbHelper.searchNotes(
        userId: userId,
        keyword: keyword,
        category: category,
        sortBy: sortBy,
      );
    } catch (e) {
      print('Search notes error: $e');
      return [];
    }
  }

  /// Get note by id
  Future<NoteModel?> getNoteById(int id) async {
    try {
      return await _dbHelper.getNoteById(id);
    } catch (e) {
      print('Get note by id error: $e');
      return null;
    }
  }

  /// Update note
  Future<bool> updateNote({
    required int noteId,
    required String title,
    required String content,
    required String category,
    required DateTime createdAt,
    required int userId,
  }) async {
    try {
      // Validasi input
      if (title.isEmpty || content.isEmpty || category.isEmpty) {
        throw Exception('Semua field harus diisi');
      }

      final note = NoteModel(
        id: noteId,
        title: title,
        content: content,
        category: category,
        createdAt: createdAt,
        userId: userId,
      );

      final result = await _dbHelper.updateNote(note);
      print('Note updated: $noteId');
      return result > 0;
    } catch (e) {
      print('Update note error: $e');
      rethrow;
    }
  }

  /// Delete note
  Future<bool> deleteNote(int noteId) async {
    try {
      final result = await _dbHelper.deleteNote(noteId);
      print('Note deleted: $noteId');
      return result > 0;
    } catch (e) {
      print('Delete note error: $e');
      return false;
    }
  }

  /// Get total notes count
  Future<int> getNotesCount(int userId) async {
    try {
      return await _dbHelper.getNotesCount(userId);
    } catch (e) {
      print('Get notes count error: $e');
      return 0;
    }
  }
}
