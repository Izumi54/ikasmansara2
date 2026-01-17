import 'package:pocketbase/pocketbase.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.avatar,
    required super.role,
    super.isVerified,
    super.angkatan,
  });

  factory UserModel.fromRecord(RecordModel record) {
    return UserModel(
      id: record.id,
      email: record.getStringValue('email'),
      name: record.getStringValue('name'),
      avatar: record.getStringValue('avatar').isNotEmpty
          ? record.collectionId.isNotEmpty
                ? Uri.parse(
                    '${const String.fromEnvironment('POCKETBASE_URL', defaultValue: 'http://127.0.0.1:8090')}/api/files/${record.collectionId}/${record.id}/${record.getStringValue('avatar')}',
                  ).toString()
                : null
          : null,
      role: record.getStringValue('role'),
      isVerified: record.getBoolValue('verified'),
      angkatan: record.getIntValue('angkatan'),
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      avatar: entity.avatar,
      role: entity.role,
      isVerified: entity.isVerified,
      angkatan: entity.angkatan,
    );
  }
}
