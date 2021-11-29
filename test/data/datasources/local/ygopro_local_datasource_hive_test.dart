import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:ygo_collection_manager/data/datasources/local/hive/ygopro_local_datasource_hive.dart';

import 'ygopro_local_datasource_hive_test.mocks.dart';

@GenerateMocks([HiveInterface])
void main() {
  final mockHiveInterface = MockHiveInterface();
  final dataSource = YgoProLocalDataSourceHive(hive: mockHiveInterface);

  group('initDb', () {});

  group('closeDb', () {});

  group('getCards', () {});

  group('getDatabaseVersion', () {});

  group('getSets', () {});
}
