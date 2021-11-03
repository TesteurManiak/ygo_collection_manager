import 'package:dio/dio.dart';

import '../../../../core/entities/banlist.dart';
import '../../../../core/entities/format.dart';
import '../../../../core/entities/link_markers.dart';
import '../../../../core/entities/sort.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../data/models/request/get_card_info_request.dart';
import '../models/archetype_model.dart';
import '../models/card_set_info_model.dart';
import '../models/db_version_model.dart';
import '../models/ygo_card_model.dart';
import '../models/ygo_set_model.dart';

abstract class YgoProRemoteDataSource {
  /// Calls the https://db.ygoprodeck.com/api/v7/cardsets.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<YgoSetModel>> getAllSets();

  /// Calls the https://db.ygoprodeck.com/api/v7/archetypes.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<ArchetypeModel>> getAllCardArchetypes();

  /// Calls the https://db.ygoprodeck.com/api/v7/cardinfo.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<YgoCardModel>> getCardInfo({
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
  });

  /// Calls the https://db.ygoprodeck.com/api/v7/cardinfo.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<YgoCardModel>> getAllCards() => getCardInfo(misc: true);

  /// Calls the
  /// https://db.ygoprodeck.com/api/v7/cardsetsinfo.php?setcode={setCode}
  /// endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<CardSetInfoModel> getCardSetInformation(String setCode);

  /// Calls the https://db.ygoprodeck.com/api/v7/checkDBVer.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DbVersionModel> getDatabaseVersion();

  /// Calls the https://db.ygoprodeck.com/api/v7/randomcard.php endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<YgoCardModel> getRandomCard();
}

class YgoProRemoteDataSourceImpl implements YgoProRemoteDataSource {
  static final baseUrl = Uri(scheme: 'https', host: 'db.ygoprodeck.com');
  static const basePath = <String>['api', 'v7'];
  static const cardInfoPath = 'cardinfo.php';
  static const randomCardPath = 'randomcard.php';
  static const setsPath = 'cardsets.php';
  static const cardSetsInfoPath = 'cardsetsinfo.php';
  static const archetypesPath = 'archetypes.php';
  static const checkDBVerPath = 'checkDBVer.php';

  final Dio client;

  YgoProRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ArchetypeModel>> getAllCardArchetypes() async {
    try {
      final response = await _getCall<Iterable>([archetypesPath]);
      return response
          .map((json) => ArchetypeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioError {
      throw ServerException();
    }
  }

  @override
  Future<List<YgoCardModel>> getAllCards() => getCardInfo(misc: true);

  @override
  Future<List<YgoSetModel>> getAllSets() async {
    try {
      final response = await _getCall<Iterable>([setsPath]);
      return response
          .map<YgoSetModel>(
            (e) => YgoSetModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioError {
      throw ServerException();
    }
  }

  @override
  Future<List<YgoCardModel>> getCardInfo({
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
    try {
      final response = await _getCall<Map<String, dynamic>>(
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
          .map<YgoCardModel>(
            (e) => YgoCardModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    } on DioError {
      throw ServerException();
    }
  }

  @override
  Future<CardSetInfoModel> getCardSetInformation(String setCode) async {
    try {
      final response = await _getCall<Map<String, dynamic>>(
        [cardSetsInfoPath],
        queryParameters: <String, Object>{'setcode': setCode},
      );
      return CardSetInfoModel.fromJson(response);
    } on DioError {
      throw ServerException();
    }
  }

  @override
  Future<DbVersionModel> getDatabaseVersion() async {
    try {
      final response = await _getCall<Iterable>([checkDBVerPath]);
      return DbVersionModel.fromJson(response.first as Map<String, dynamic>);
    } on DioError {
      throw ServerException();
    }
  }

  @override
  Future<YgoCardModel> getRandomCard() async {
    try {
      final response = await _getCall<Map<String, dynamic>>(
        [randomCardPath],
      );
      return YgoCardModel.fromJson(response);
    } on DioError {
      throw ServerException();
    }
  }

  Future<T> _getCall<T>(
    Iterable<String> pathSegments, {
    Map<String, dynamic> queryParameters = const {},
  }) async {
    final response = await client.getUri(
      baseUrl.replace(
        pathSegments: <String>[...basePath, ...pathSegments],
        queryParameters: queryParameters,
      ),
    );
    return response.data as T;
  }
}
