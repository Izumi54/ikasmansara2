class AlumniEntity {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final int angkatan;
  final String role;
  final String? jobType;
  final String? company;
  final String? position;
  final String? domicile;
  final String? job;

  const AlumniEntity({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.angkatan,
    required this.role,
    this.jobType,
    this.company,
    this.position,
    this.domicile,
    this.job,
  });

  // Helper getters
  String get fullJobTitle {
    // Priority: Structured data -> Simple job string -> Job Type -> '-'
    if (position != null &&
        company != null &&
        position!.isNotEmpty &&
        company!.isNotEmpty) {
      return '$position at $company';
    } else if (position != null && position!.isNotEmpty) {
      return position!;
    } else if (job != null && job!.isNotEmpty) {
      return job!;
    } else if (company != null && company!.isNotEmpty) {
      return company!;
    } else {
      return jobType ?? '-';
    }
  }
}
