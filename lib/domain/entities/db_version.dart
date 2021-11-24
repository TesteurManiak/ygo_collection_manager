import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'db_version.g.dart';

@HiveType(typeId: 0)
class DbVersion extends Equatable {
  @HiveField(0)
  final DateTime lastUpdate;

  @HiveField(1)
  final String version;

  const DbVersion({
    required this.lastUpdate,
    required this.version,
  });

  @override
  List<Object?> get props => [lastUpdate, version];
}
