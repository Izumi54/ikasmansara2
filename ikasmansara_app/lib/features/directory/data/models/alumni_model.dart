import 'package:pocketbase/pocketbase.dart';
import '../../../../core/utils/image_helper.dart';
import '../../domain/entities/alumni_entity.dart';

class AlumniModel extends AlumniEntity {
  const AlumniModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required super.angkatan,
    required super.role,
    super.jobType,
    super.company,
    super.position,
    super.domicile,
    super.job,
  });

  factory AlumniModel.fromRecord(RecordModel record) {
    return AlumniModel(
      id: record.id,
      name: record.getStringValue('name'),
      email: record.getStringValue('email'),
      avatar: ImageHelper.getPocketBaseImageUrl(
        collectionId: record.collectionId,
        recordId: record.id,
        filename: record.getStringValue('avatar'),
      ),
      angkatan: record.getIntValue('angkatan'),
      role: record.getStringValue('role'),
      jobType: record.getStringValue('job_type'),
      company: record.getStringValue('company'),
      position: record.getStringValue('position'),
      domicile: record.getStringValue('domicile'),
      job: record.getStringValue('job'),
    );
  }

  /// Helper to get full avatar URL if needed, though usually handled by CachedNetworkImage with base URL
  String getAvatarUrl(String baseUrl, String collectionId) {
    if (avatar == null) return '';
    return '$baseUrl/api/files/$collectionId/$id/$avatar';
  }
}
