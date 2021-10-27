import 'package:equatable/equatable.dart';

class DbVersion extends Equatable {
  final DateTime lastUpdate;
  final String version;

  const DbVersion({
    required this.lastUpdate,
    required this.version,
  });

  @override
  List<Object?> get props => [lastUpdate, version];
}
