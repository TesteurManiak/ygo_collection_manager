import 'package:get_it/get_it.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_all_sets.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_local_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/fetch_owned_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/update_cards.dart';
import 'package:ygo_collection_manager/domain/usecases/update_sets.dart';

import 'data/api/api.dart';
import 'data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'data/datasources/remote/ygopro_remote_data_source.dart';
import 'data/repository/ygopro_repository_impl.dart';
import 'domain/repository/ygopro_repository.dart';

final sl = GetIt.instance;

void setupLocator() {
  //! Bloc
  // sl.registerFactory();

  _configDomain();

  //! Data
  // Data sources
  sl.registerLazySingleton(() => YgoProRemoteDataSource(sl()));
  sl.registerLazySingleton<YgoProLocalDataSource>(
    () => YgoProLocalDataSourceHive(),
  );

  //! Core
  // sl.registerLazySingleton();

  //! External
  sl.registerLazySingleton<RemoteClient>(() => DioClient());
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
