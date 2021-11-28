import 'dart:async';
import 'dart:io' show SocketException;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/error/exceptions.dart';
import '../../api/api.dart';
import '../../models/request/get_card_info_request.dart';
import '../../models/response/archetype_model.dart';
import '../../models/response/card_set_info_model.dart';
import '../../models/response/db_version_model.dart';
import '../../models/response/ygo_card_model.dart';
import '../../models/response/ygo_set_model.dart';

abstract class YgoProRemoteDataSource {
  Future<List<ArchetypeModel>> getAllCardArchetypes();
  Future<List<YgoSetModel>> getAllSets();
  Future<CardSetInfoModel> getCardSetInformation(String setCode);
  Future<YgoCardModel> getRandomCard();
  Future<List<YgoCardModel>> getCardInfo(GetCardInfoRequest request);
  Future<DbVersionModel> checkDatabaseVersion();
}

class YgoProRemoteDataSourceImpl implements YgoProRemoteDataSource {
  static final baseUrl = Uri(
    scheme: 'https',
    host: 'db.ygoprodeck.com',
    pathSegments: ['api', 'v7'],
  );
  static const cardInfoPath = 'cardinfo.php';
  static const randomCardPath = 'randomcard.php';
  static const setsPath = 'cardsets.php';
  static const cardSetsInfoPath = 'cardsetsinfo.php';
  static const archetypesPath = 'archetypes.php';
  static const checkDBVerPath = 'checkDBVer.php';

  final RemoteClient httpClient;

  YgoProRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<List<ArchetypeModel>> getAllCardArchetypes() async {
    final response = await _getCall<Iterable>([archetypesPath]);
    return response
        .cast<Map<String, dynamic>>()
        .map((e) => ArchetypeModel.fromJson(e))
        .toList();
  }

  @visibleForTesting
  static List<YgoSetModel> parseSets(Iterable<dynamic> sets) {
    return sets
        .cast<Map<String, dynamic>>()
        .map((e) => YgoSetModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<YgoSetModel>> getAllSets() async {
    final data = await _getCall<Iterable>([setsPath]);
    return compute(parseSets, data);
  }

  @override
  Future<CardSetInfoModel> getCardSetInformation(String setCode) async {
    final response = await _getCall<Map<String, dynamic>>(
      [cardSetsInfoPath],
      queryParameters: {
        'setcode': setCode,
      },
    );
    return CardSetInfoModel.fromJson(response);
  }

  @override
  Future<YgoCardModel> getRandomCard() async {
    final response = await _getCall<Map<String, dynamic>>([randomCardPath]);
    return YgoCardModel.fromJson(response);
  }

  @visibleForTesting
  static List<YgoCardModel> parseCards(Map<String, dynamic> response) {
    return (response['data'] as Iterable)
        .cast<Map<String, dynamic>>()
        .map<YgoCardModel>((e) => YgoCardModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<YgoCardModel>> getCardInfo(GetCardInfoRequest request) async {
    final names = request.names;
    final fname = request.fname;
    final ids = request.ids;
    final types = request.types;
    final atk = request.atk;
    final def = request.def;
    final level = request.level;
    final races = request.races;
    final attributes = request.attributes;
    final link = request.link;
    final linkMarkers = request.linkMarkers;
    final scale = request.scale;
    final cardSet = request.cardSet;
    final archetype = request.archetype;
    final banlist = request.banlist;
    final sort = request.sort;
    final format = request.format;
    final misc = request.misc;
    final staple = request.staple;
    final startDate = request.startDate;
    final endDate = request.endDate;
    final dateRegion = request.dateRegion;
    final response = await _getCall<Map<String, dynamic>>(
      [cardInfoPath],
      queryParameters: <String, Object>{
        if (names != null) 'name': names.join('|'),
        if (fname != null) 'fname': fname,
        if (ids != null) 'id': ids.join(','),
        if (types != null) 'type': types.join(','),
        if (atk != null) 'atk': atk.toString(),
        if (def != null) 'def': def.toString(),
        if (level != null) 'level': level.toString(),
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
    return compute(parseCards, response);
  }

  @override
  Future<DbVersionModel> checkDatabaseVersion() async {
    final response = await _getCall<Iterable>([checkDBVerPath]);
    return DbVersionModel.fromJson(response.first as Map<String, dynamic>);
  }

  Future<T> _getCall<T>(
    Iterable<String> pathSegments, {
    Map<String, Object> queryParameters = const {},
  }) async {
    try {
      final response = await httpClient.get(
        baseUrl.replace(
          pathSegments: <String>[...baseUrl.pathSegments, ...pathSegments],
          queryParameters: queryParameters,
        ).toString(),
      );
      return response as T;
    } on SocketException catch (e) {
      debugPrint(e.toString());
      throw const ServerException(message: 'Please check your connection.');
    }
  }
}
