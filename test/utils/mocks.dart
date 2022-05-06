import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/data/api/api.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/entities/db_version.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockYgoCardBox extends Mock implements Box<YgoCard> {}

class MockYgoSetBox extends Mock implements Box<YgoSet> {}

class MockDbVersionBox extends Mock implements Box<DbVersion> {}

class MockCardOwnedBox extends Mock implements Box<CardOwned> {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockRemoteClient extends Mock implements RemoteClient {}
