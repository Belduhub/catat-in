/// User Model
/// Model untuk representasi data user dalam database
class UserModel {
  final int? id;
  final String username;
  final String password;
  final String? fullName;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    this.fullName,
  });

  /// Convert UserModel ke Map untuk disimpan ke database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'full_name': fullName,
    };
  }

  /// Convert Map dari database ke UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      username: map['username'] as String,
      password: map['password'] as String,
      fullName: map['full_name'] as String?,
    );
  }

  /// Create copy of UserModel dengan field yang diubah
  UserModel copyWith({
    int? id,
    String? username,
    String? password,
    String? fullName,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  String toString() {
    return 'UserModel{id: $id, username: $username, fullName: $fullName}';
  }
}
