import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ygo_collection_manager/models/card_info_model.dart';
import 'package:ygo_collection_manager/models/db_version_model.dart';
import 'package:ygo_collection_manager/models/set_model.dart';

class YgoProDeckProvider {
  static final baseUrl = Uri(scheme: 'https', host: 'db.ygoprodeck.com');
  static const basePath = <String>['api', 'v7'];
  static const cardInfoPath = 'cardinfo.php';
  static const randomCardPath = 'randomcard.php';
  static const setsPath = 'cardsets.php';
  static const cardSetsInfoPath = 'cardsetsinfo.php';
  static const archetypesPath = 'archetypes.php';
  static const checkDBVerPath = 'checkDBVer.php';

  final Dio _dio;

  YgoProDeckProvider(this._dio);

  // TODO(maniak): Finish query params
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
    bool misc = false,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (names != null) queryParameters['name'] = names.join('|');
    if (fname != null) queryParameters['fname'] = fname;
    if (ids != null) queryParameters['id'] = ids.join(',');
    if (types != null) queryParameters['type'] = types.join(',');
    if (atk != null) queryParameters['atk'] = atk;
    if (def != null) queryParameters['def'] = def;
    if (level != null) queryParameters['level'] = level;
    if (races != null) queryParameters['race'] = races.join(',');
    if (attributes != null) queryParameters['attribute'] = attributes.join(',');
    if (link != null) queryParameters['link'] = link;
    if (misc) queryParameters['misc'] = 'yes';

    final response = await getCall<Map<String, dynamic>>(
      [cardInfoPath],
      queryParameters: queryParameters,
    );
    return (response['data'] as Iterable)
        .map<CardInfoModel>(
          (e) => CardInfoModel.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }

  Future<List<SetModel>> getSets() async {
    final data = await getCall<Iterable>([setsPath]);
    return data
        .map<SetModel>((e) => SetModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<DBVersionModel> checkDatabaseVersion() async {
    final response = await getCall<Iterable>([checkDBVerPath]);
    return DBVersionModel.fromJson(response.first as Map<String, dynamic>);
  }

  Future<T> getCall<T>(
    Iterable<String> pathSegments, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    final response = await _dio.getUri(
      baseUrl.replace(
        pathSegments: <String>[...basePath, ...pathSegments],
        queryParameters: queryParameters,
      ),
    );
    return response.data as T;
  }
}
