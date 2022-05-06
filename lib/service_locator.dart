import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart' show Hive;

import 'data/api/api.dart';
import 'data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'data/datasources/remote/ygopro_remote_data_source.dart';
import 'data/platform/network_info.dart';
import 'data/repository/ygopro_repository_impl.dart';
import 'domain/repository/ygopro_repository.dart';
import 'domain/usecases/fetch_all_cards.dart';
import 'domain/usecases/fetch_all_sets.dart';
import 'domain/usecases/fetch_owned_cards.dart';
import 'domain/usecases/get_copies_of_card_owned.dart';
import 'domain/usecases/should_reload_db.dart';
import 'domain/usecases/update_card_owned.dart';

final sl = GetIt.instance;

void setupLocator() {
  _configDomain();
  _configData();

  //! Core
  // sl.registerLazySingleton();

  _configExternal();
}

void _configDomain() {
  //! Domain
  // Use cases
  sl.registerLazySingleton(() => FetchAllCards(sl()));
  sl.registerLazySingleton(() => FetchAllSets(sl()));
  sl.registerLazySingleton(() => FetchOwnedCards(sl()));
  sl.registerLazySingleton(() => GetCopiesOfCardOwned(sl()));
  sl.registerLazySingleton(() => UpdateCardOwned(sl()));
  sl.registerLazySingleton(() => ShouldReloadDb(sl()));

  // Repository
  sl.registerLazySingleton<YgoProRepository>(
    () => YgoProRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
}

void _configData() {
  //! Data
  // Data sources
  sl.registerLazySingleton<YgoProRemoteDataSource>(
    () => YgoProRemoteDataSourceImpl(httpClient: sl()),
  );
  sl.registerLazySingleton<YgoProLocalDataSource>(
    () => YgoProLocalDataSourceHive(hive: Hive),
  );
}

void _configExternal() {
  //! External
  sl.registerLazySingleton<RemoteClient>(() => DioClient(dio: Dio()));
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: Connectivity()),
  );
}
