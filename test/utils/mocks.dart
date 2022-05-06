import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ygo_collection_manager/data/api/api.dart';
import 'package:ygo_collection_manager/data/datasources/local/ygopro_local_datasource.dart';
import 'package:ygo_collection_manager/data/datasources/remote/ygopro_remote_data_source.dart';
import 'package:ygo_collection_manager/data/platform/network_info.dart';
import 'package:ygo_collection_manager/domain/entities/card_owned.dart';
import 'package:ygo_collection_manager/domain/entities/db_version.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/domain/entities/ygo_set.dart';
import 'package:ygo_collection_manager/domain/repository/ygopro_repository.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_sets.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/should_reload_db.dart';

class MockConnectivity extends Mock implements Connectivity {}

class MockYgoCardBox extends Mock implements Box<YgoCard> {}

class MockYgoSetBox extends Mock implements Box<YgoSet> {}

class MockDbVersionBox extends Mock implements Box<DbVersion> {}

class MockCardOwnedBox extends Mock implements Box<CardOwned> {}

class MockHiveInterface extends Mock implements HiveInterface {}

class MockRemoteClient extends Mock implements RemoteClient {}

class MockYgoProRemoteDataSource extends Mock
    implements YgoProRemoteDataSource {}

class MockYgoProLocalDataSource extends Mock implements YgoProLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockYgoProRepository extends Mock implements YgoProRepository {}

class MockFetchAllSets extends Mock implements FetchAllSets {}

class MockFetchAllCards extends Mock implements FetchAllCards {}

class MockFetchOwnedCards extends Mock implements FetchOwnedCards {}

class MockShouldReloadDb extends Mock implements ShouldReloadDb {}
