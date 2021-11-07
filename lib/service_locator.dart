import 'package:get_it/get_it.dart';

import 'data/api/api.dart';
import 'data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';
import 'data/datasources/remote/ygopro_remote_data_source.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<RemoteClient>(DioClient());

  locator.registerSingleton(YgoProRemoteDataSource(locator()));
  locator.registerSingleton<YgoProLocalDataSource>(YgoProLocalDataSourceHive());
}
