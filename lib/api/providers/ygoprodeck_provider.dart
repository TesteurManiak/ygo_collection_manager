import 'dart:async';

import 'package:dio/dio.dart';

import '../../core/entities/banlist.dart';
import '../../core/entities/format.dart';
import '../../core/entities/link_markers.dart';
import '../../core/entities/sort.dart';
import '../../features/browse_cards/data/models/ygo_card_model.dart';
import '../../features/browse_cards/domain/entities/ygo_card.dart';
import '../../models/db_version_model.dart';
import '../../models/set_model.dart';

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
    List<LinkMarkers>? linkMarkers,
    int? scale,
    String? cardSet,
    String? archetype,
    Banlist? banlist,
    Sort? sort,
    Format? format,
    bool misc = false,
    bool? staple,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? dateRegion,
  }) async {
    final response = await getCall<Map<String, dynamic>>(
      [cardInfoPath],
      queryParameters: <String, Object>{
        if (names != null) 'name': names.join('|'),
        if (fname != null) 'fname': fname,
        if (ids != null) 'id': ids.join(','),
        if (types != null) 'type': types.join(','),
        if (atk != null) 'atk': atk,
        if (def != null) 'def': def,
        if (level != null) 'level': level,
        if (races != null) 'race': races.join(','),
        if (attributes != null) 'attribute': attributes.join(','),
        if (link != null) 'link': link,
        if (linkMarkers != null)
          'linkmarker': linkMarkers.toStringIterable().join(','),
        if (scale != null) 'scale': scale,
        if (cardSet != null) 'cardset': cardSet,
        if (archetype != null) 'archetype': archetype,
        if (banlist != null) 'banlist': banlist.string,
        if (sort != null) 'sort': sort.string,
        if (format != null) 'format': format.string,
        'misc': (misc ? 'yes' : 'no'),
        if (staple != null) 'staple': (staple ? 'yes' : 'no'),
        if (startDate != null) 'startdate': startDate.toIso8601String(),
        if (endDate != null) 'enddate': endDate.toIso8601String(),
        if (dateRegion != null) 'dateregion': dateRegion.toIso8601String(),
      },
    );
    return (response['data'] as Iterable)
        .map<YgoCard>(
          (e) => YgoCardModel.fromJson(e as Map<String, dynamic>),
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
    Map<String, Object> queryParameters = const {},
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
