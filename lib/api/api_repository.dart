import 'package:dio/dio.dart';
import 'package:ygo_collection_manager/api/providers/ygoprodeck_provider.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class _ApiRepository {
  final _dio = Dio();

  late final ygoProDeckProvider = YgoProDeckProvider(_dio);

  Future<List<SetModel>> getAllSets() => ygoProDeckProvider.getSets();
}

final apiRepository = _ApiRepository();
