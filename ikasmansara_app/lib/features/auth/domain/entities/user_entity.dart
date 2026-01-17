class UserEntity {
  final String id;
  final String email;
  final String name;
  final String? avatar;
  final String role; // 'alumni' or 'guest'
  final bool isVerified;
  final int? angkatan;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    required this.role,
    this.isVerified = false,
    this.angkatan,
  });

  String? get avatarUrl => avatar;
}
