import 'package:hive_flutter/adapters.dart';

part 'db_version_model.g.dart';

@HiveType(typeId: 0)
class DBVersionModel extends HiveObject {
  @HiveField(0)
  final DateTime lastUpdate;

  @HiveField(1)
  final String version;

  DBVersionModel({required this.lastUpdate, required this.version});

  factory DBVersionModel.fromJson(Map<String, dynamic> json) => DBVersionModel(
        lastUpdate: DateTime.parse(json['last_update'] as String),
        version: json['database_version'] as String,
      );
}
