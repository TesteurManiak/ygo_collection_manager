import 'package:dio/dio.dart';
import 'package:ygo_collection_manager/data/models/request/get_card_info_request.dart';

import '../data/api/ygoprodeck_api.dart';
import '../features/browse_cards/domain/entities/ygo_card.dart';
import '../models/db_version_model.dart';
import '../models/set_model.dart';

class _ApiRepository {
  final _dio = Dio();

  late final _ygoProDeckProvider = YgoProRemoteDataSource(_dio);

  Future<List<SetModel>> getAllSets() => _ygoProDeckProvider.getSets();

  Future<List<YgoCard>> getCardInfo(GetCardInfoRequest request) =>
      _ygoProDeckProvider.getCardInfo(request);

  Future<DBVersionModel> checkDatabaseVersion() =>
      _ygoProDeckProvider.checkDatabaseVersion();
}

final apiRepository = _ApiRepository();
