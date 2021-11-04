import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ygo_collection_manager/data/api/ygopro_remote_data_source.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(YgoProRemoteDataSource(Dio()));
}
