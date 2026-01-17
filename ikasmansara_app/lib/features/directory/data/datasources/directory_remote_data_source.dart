import 'package:pocketbase/pocketbase.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/alumni_model.dart';

abstract class DirectoryRemoteDataSource {
  Future<List<AlumniModel>> searchAlumni({
    String? query,
    int? angkatan,
    String? jobType,
    String? domicile,
    int page = 1,
    int limit = 20,
  });
}

class DirectoryRemoteDataSourceImpl implements DirectoryRemoteDataSource {
  final PocketBase pb;

  DirectoryRemoteDataSourceImpl(this.pb);

  @override
  Future<List<AlumniModel>> searchAlumni({
    String? query,
    int? angkatan,
    String? jobType,
    String? domicile,
    int page = 1,
    int limit = 20,
  }) async {
    // Build filter string
    final filters = <String>[];

    // Filter by Role (Only Alumni) - Adjust if Public users should also be visible but role is usually 'alumni'
    filters.add('role = "alumni"');

    if (query != null && query.isNotEmpty) {
      // Fuzzy search on name, company, or position
      filters.add(
        '(name ~ "$query" || company ~ "$query" || position ~ "$query")',
      );
    }

    if (angkatan != null) {
      filters.add('angkatan = $angkatan');
    }

    if (jobType != null && jobType.isNotEmpty) {
      filters.add('job_type = "$jobType"');
    }

    if (domicile != null && domicile.isNotEmpty) {
      filters.add('domicile ~ "$domicile"');
    }

    final filterString = filters.join(' && ');

    final result = await pb
        .collection(ApiEndpoints.users)
        .getList(
          page: page,
          perPage: limit,
          filter: filterString,
          sort: '-created', // Default sort
        );

    return result.items.map((r) => AlumniModel.fromRecord(r)).toList();
  }
}
