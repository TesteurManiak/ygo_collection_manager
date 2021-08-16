import 'package:dio/dio.dart';
import 'package:ygo_collection_manager/api/providers/ygoprodeck_provider.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class _ApiRepository {
  final _dio = Dio();

  late final _ygoProDeckProvider = YgoProDeckProvider(_dio);

  Future<List<SetModel>> getAllSets() => _ygoProDeckProvider.getSets();
  Future<List<CardInfoModel>> getCardInfo({
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
      );
}

final apiRepository = _ApiRepository();
