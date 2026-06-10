/// Note Model
/// Model untuk representasi data catatan dalam database
class NoteModel {
  final int? id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final int userId;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.userId,
  });

  /// Convert NoteModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
    };
  }

  /// Convert Map dari database ke NoteModel
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      category: map['category'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      userId: map['user_id'] as int,
    );
  }

  /// Create copy of NoteModel dengan field yang diubah
  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    String? category,
    DateTime? createdAt,
    int? userId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'NoteModel{id: $id, title: $title, category: $category, userId: $userId}';
  }
}
