import 'package:pocketbase/pocketbase.dart';
import '../../../../core/utils/image_helper.dart';
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
    super.bio,
    super.job,
    super.phone,
    super.linkedin,
    super.instagram,
  });

  factory UserModel.fromRecord(RecordModel record) {
    return UserModel(
      id: record.id,
      email: record.getStringValue('email'),
      name: record.getStringValue('name'),
      avatar: ImageHelper.getPocketBaseImageUrl(
        collectionId: record.collectionId,
        recordId: record.id,
        filename: record.getStringValue('avatar'),
      ),
      role: record.getStringValue('role'),
      isVerified: record.getBoolValue('verified'),
      angkatan: record.getIntValue('angkatan'),
      bio: record.getStringValue('bio'),
      job: record.getStringValue('job'), // Note: this maps to 'job' field in DB
      phone: record.getStringValue('phone'),
      linkedin: record.getStringValue('linkedin'),
      instagram: record.getStringValue('instagram'),
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
      bio: entity.bio,
      job: entity.job,
      phone: entity.phone,
      linkedin: entity.linkedin,
      instagram: entity.instagram,
    );
  }
}
