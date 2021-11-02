import 'package:dio/dio.dart';
import 'package:ygo_collection_manager/api/providers/ygoprodeck_provider.dart';
import 'package:ygo_collection_manager/features/browse_cards/domain/entities/ygo_card.dart';
import 'package:ygo_collection_manager/models/db_version_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class _ApiRepository {
  final _dio = Dio();

  late final _ygoProDeckProvider = YgoProDeckProvider(_dio);

  Future<List<SetModel>> getAllSets() => _ygoProDeckProvider.getSets();

  Future<List<YgoCard>> getCardInfo({
    List<String>? names,
    String? fname,
    List<int>? ids,
    List<String>? types,
    int? atk,
    int? def,
    int? level,
    List<String>? races,
    List<String>? attributes,
    int? link,
    bool misc = false,
  }) =>
      _ygoProDeckProvider.getCardInfo(
        names: names,
        fname: fname,
        ids: ids,
        types: types,
        atk: atk,
        def: def,
        level: level,
        races: races,
        attributes: attributes,
        link: link,
        misc: misc,
      );

  Future<DBVersionModel> checkDatabaseVersion() =>
      _ygoProDeckProvider.checkDatabaseVersion();
}

final apiRepository = _ApiRepository();
