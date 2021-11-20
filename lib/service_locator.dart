import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'core/platform/network_info.dart';
import 'data/api/api.dart';
import 'data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'data/datasources/remote/ygopro_remote_data_source.dart';
import 'data/repository/ygopro_repository_impl.dart';
import 'domain/repository/ygopro_repository.dart';
import 'domain/usecases/fetch_all_cards.dart';
import 'domain/usecases/fetch_all_sets.dart';
import 'domain/usecases/fetch_local_cards.dart';
import 'domain/usecases/fetch_owned_cards.dart';
import 'domain/usecases/update_cards.dart';
import 'domain/usecases/update_sets.dart';

final sl = GetIt.instance;

void setupLocator() {
  //! Bloc
  // sl.registerFactory();

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
  sl.registerLazySingleton(() => UpdateCards(sl()));
  sl.registerLazySingleton(() => FetchAllSets(sl()));
  sl.registerLazySingleton(() => UpdateSets(sl()));
  sl.registerLazySingleton(() => FetchLocalCards(sl()));
  sl.registerLazySingleton(() => FetchOwnedCards(sl()));

  // Repository
  sl.registerLazySingleton<YgoProRepository>(
    () => YgoProRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );
}

void _configData() {
  //! Data
  // Data sources
  sl.registerLazySingleton<YgoProRemoteDataSource>(
    () => YgoProRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<YgoProLocalDataSource>(
    () => YgoProLocalDataSourceHive(),
  );
}

void _configExternal() {
  //! External
  sl.registerLazySingleton<RemoteClient>(() => DioClient());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: Connectivity()),
  );
}
