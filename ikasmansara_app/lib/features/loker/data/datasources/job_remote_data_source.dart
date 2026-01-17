import 'package:pocketbase/pocketbase.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/network/network_exceptions.dart';
import '../models/job_model.dart';

abstract class JobRemoteDataSource {
  Future<List<JobModel>> getJobs({
    String? query,
    String? type,
    int page = 1,
    int perPage = 20,
  });

  Future<JobModel> getJobDetail(String id);
}

class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  final PocketBase pb;

  JobRemoteDataSourceImpl(this.pb);

  @override
  Future<List<JobModel>> getJobs({
    String? query,
    String? type,
    int page = 1,
    int perPage = 20,
  }) async {
    try {
      final filterParts = <String>[];

      // Default filter: only active jobs
      filterParts.add('is_active = true');

      if (query != null && query.isNotEmpty) {
        filterParts.add(
          '(title ~ "$query" || company ~ "$query" || description ~ "$query")',
        );
      }

      if (type != null && type.isNotEmpty && type != 'Semua') {
        filterParts.add('type = "$type"');
      }

      final filter = filterParts.join(' && ');

      final result = await pb
          .collection('jobs')
          .getList(
            page: page,
            perPage: perPage,
            filter: filter,
            sort: '-created',
            expand: 'posted_by',
          );

      return result.items.map((record) => JobModel.fromRecord(record)).toList();
    } catch (e) {
      if (e is ClientException) {
        throw mapPocketBaseError(e);
      }
      throw AppException.unknown(message: e.toString());
    }
  }

  @override
  Future<JobModel> getJobDetail(String id) async {
    try {
      final record = await pb
          .collection('jobs')
          .getOne(id, expand: 'posted_by');
      return JobModel.fromRecord(record);
    } catch (e) {
      if (e is ClientException) {
        throw mapPocketBaseError(e);
      }
      throw AppException.unknown(message: e.toString());
    }
  }
}
