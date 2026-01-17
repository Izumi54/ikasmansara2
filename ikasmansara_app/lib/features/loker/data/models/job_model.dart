import 'package:pocketbase/pocketbase.dart';

import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    required super.company,
    required super.title,
    required super.description,
    required super.location,
    required super.type,
    super.salaryRange,
    super.link,
    super.isActive,
    super.postedBy,
    super.created,
    super.updated,
  });

  factory JobModel.fromRecord(RecordModel record) {
    return JobModel(
      id: record.id,
      collectionId: record.collectionId,
      collectionName: record.collectionName,
      company: record.data['company'] ?? '',
      title: record.data['title'] ?? '',
      description: record.data['description'] ?? '',
      location: record.data['location'] ?? '',
      type: record.data['type'] ?? 'Fulltime',
      salaryRange: record.data['salary_range'],
      link: record.data['link'],
      isActive: record.data['is_active'] ?? true,
      postedBy:
          record.expand['posted_by'] != null &&
              record.expand['posted_by']!.isNotEmpty
          ? UserModel.fromRecord(record.expand['posted_by']!.first)
          : null,
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'company': company,
      'title': title,
      'description': description,
      'location': location,
      'type': type,
      'salary_range': salaryRange,
      'link': link,
      'is_active': isActive,
      'created': created?.toIso8601String(),
      'updated': updated?.toIso8601String(),
    };
  }
}
