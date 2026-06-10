import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/note_model.dart';

/// DatabaseHelper - Singleton class untuk manajemen SQLite database
/// Menangani semua operasi database untuk users dan notes
class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  // Nama database dan tabel
  static const String _databaseName = 'catatin.db';
  static const int _databaseVersion = 1;
  
  static const String tableUsers = 'users';
  static const String tableNotes = 'notes';

  /// Getter untuk database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database
  Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, _databaseName);

      print('🔧 Initializing database at: $path');
      
      // Use the global openDatabase which respects databaseFactory
      final db = await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onOpen: (db) {
          print('✅ Database opened successfully');
        },
      );
      
      return db;
    } catch (e) {
      print('❌ Database initialization error: $e');
      print('   Stack trace: ${StackTrace.current}');
      rethrow;
    }
  }

  /// Create tables saat database pertama kali dibuat
  Future<void> _onCreate(Database db, int version) async {
    // Create users table
    await db.execute('''
      CREATE TABLE $tableUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE NOT NULL,
        password TEXT NOT NULL,
        full_name TEXT
      )
    ''');

    // Create notes table
    await db.execute('''
      CREATE TABLE $tableNotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        category TEXT NOT NULL,
        created_at TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES $tableUsers (id) ON DELETE CASCADE
      )
    ''');

    // Seed default user untuk testing (admin/password123)
    await db.insert(tableUsers, {
      'username': 'admin',
      'password': 'password123',
      'full_name': 'Administrator',
    });

    print('Database created and seeded with default user (admin/password123)');
  }

  // ==================== USER OPERATIONS ====================

  /// Insert user baru ke database
  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert(
      tableUsers,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
  }

  /// Get user by username dan password (untuk login)
  Future<UserModel?> getUserByCredentials(String username, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableUsers,
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// Get user by id
  Future<UserModel?> getUserById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// Get user by username (untuk cek duplikasi saat register)
  Future<UserModel?> getUserByUsername(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableUsers,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  /// Update user profile
  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      tableUsers,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  /// Delete user
  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==================== NOTE OPERATIONS ====================

  /// Insert note baru ke database
  Future<int> insertNote(NoteModel note) async {
    final db = await database;
    return await db.insert(
      tableNotes,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get semua notes untuk user tertentu
  Future<List<NoteModel>> getNotesByUserId(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableNotes,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) => NoteModel.fromMap(maps[i]));
  }

  /// Get notes dengan filter kategori
  Future<List<NoteModel>> getNotesByCategory(int userId, String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableNotes,
      where: 'user_id = ? AND category = ?',
      whereArgs: [userId, category],
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) => NoteModel.fromMap(maps[i]));
  }

  /// Get notes dengan sorting tertentu
  Future<List<NoteModel>> getNotesSorted(int userId, String sortBy) async {
    final db = await database;
    String orderBy;
    
    switch (sortBy) {
      case 'A-Z':
        orderBy = 'title COLLATE NOCASE ASC';
        break;
      case 'Z-A':
        orderBy = 'title COLLATE NOCASE DESC';
        break;
      case 'Latest':
        orderBy = 'created_at DESC';
        break;
      case 'Oldest':
        orderBy = 'created_at ASC';
        break;
      default:
        orderBy = 'created_at DESC';
    }

    final List<Map<String, dynamic>> maps = await db.query(
      tableNotes,
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: orderBy,
    );

    return List.generate(maps.length, (i) => NoteModel.fromMap(maps[i]));
  }

  /// Get notes dengan filter kategori DAN sorting
  Future<List<NoteModel>> getNotesFiltered(int userId, String? category, String sortBy) async {
    final db = await database;
    String orderBy;
    
    switch (sortBy) {
      case 'A-Z':
        orderBy = 'title COLLATE NOCASE ASC';
        break;
      case 'Z-A':
        orderBy = 'title COLLATE NOCASE DESC';
        break;
      case 'Latest':
        orderBy = 'created_at DESC';
        break;
      case 'Oldest':
        orderBy = 'created_at ASC';
        break;
      default:
        orderBy = 'created_at DESC';
    }

    List<Map<String, dynamic>> maps;
    
    if (category == null || category == 'Semua') {
      maps = await db.query(
        tableNotes,
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: orderBy,
      );
    } else {
      maps = await db.query(
        tableNotes,
        where: 'user_id = ? AND category = ?',
        whereArgs: [userId, category],
        orderBy: orderBy,
      );
    }

    return List.generate(maps.length, (i) => NoteModel.fromMap(maps[i]));
  }

  /// Search notes berdasarkan keyword di title atau content
  Future<List<NoteModel>> searchNotes({
    required int userId,
    required String keyword,
    String? category,
    required String sortBy,
  }) async {
    final db = await database;
    String orderBy;
    
    switch (sortBy) {
      case 'A-Z':
        orderBy = 'title COLLATE NOCASE ASC';
        break;
      case 'Z-A':
        orderBy = 'title COLLATE NOCASE DESC';
        break;
      case 'Latest':
        orderBy = 'created_at DESC';
        break;
      case 'Oldest':
        orderBy = 'created_at ASC';
        break;
      default:
        orderBy = 'created_at DESC';
    }

    String where;
    List<dynamic> whereArgs;
    
    // Build query based on category filter
    if (category == null || category == 'Semua') {
      where = 'user_id = ? AND (title LIKE ? OR content LIKE ?)';
      whereArgs = [userId, '%$keyword%', '%$keyword%'];
    } else {
      where = 'user_id = ? AND category = ? AND (title LIKE ? OR content LIKE ?)';
      whereArgs = [userId, category, '%$keyword%', '%$keyword%'];
    }

    final List<Map<String, dynamic>> maps = await db.query(
      tableNotes,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );

    return List.generate(maps.length, (i) => NoteModel.fromMap(maps[i]));
  }

  /// Get note by id
  Future<NoteModel?> getNoteById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return NoteModel.fromMap(maps.first);
  }

  /// Update note
  Future<int> updateNote(NoteModel note) async {
    final db = await database;
    return await db.update(
      tableNotes,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  /// Delete note
  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete(
      tableNotes,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get total notes count untuk user tertentu
  Future<int> getNotesCount(int userId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableNotes WHERE user_id = ?',
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Close database
  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}
