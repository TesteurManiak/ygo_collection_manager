import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote/ygopro_remote_data_source.dart';
import 'data/datasources/local/hive/ygopro_local_datasource_hive.dart';
import 'data/datasources/local/ygopro_local_datasource.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(YgoProRemoteDataSource(Dio()));
  locator.registerSingleton<YgoProLocalDataSource>(YgoProLocalDataSourceHive());
}
