import 'package:get_it/get_it.dart';

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

  //! Domain
  // Use cases
  // sl.registerLazySingleton();

  // Repository
  sl.registerLazySingleton<YgoProRepository>(
    () => YgoProRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

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
