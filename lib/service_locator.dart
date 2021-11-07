import 'package:get_it/get_it.dart';

import 'data/api/api.dart';
import 'data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'data/datasources/remote/ygopro_remote_data_source.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerSingleton<RemoteClient>(DioClient());

  sl.registerSingleton(YgoProRemoteDataSource(sl()));
  sl.registerSingleton<YgoProLocalDataSource>(YgoProLocalDataSourceHive());
}
