import '../../../../domain/entities/db_version.dart';

class DbVersionModel extends DbVersion {
  const DbVersionModel({
    required DateTime lastUpdate,
    required String version,
  }) : super(
          lastUpdate: lastUpdate,
          version: version,
        );

  factory DbVersionModel.fromJson(Map<String, dynamic> json) => DbVersionModel(
        lastUpdate: DateTime.parse(json['last_update'] as String),
        version: json['database_version'] as String,
      );
}
