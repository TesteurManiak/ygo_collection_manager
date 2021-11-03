import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/entities/banlist.dart';
import '../../core/entities/format.dart';
import '../../core/entities/link_markers.dart';
import '../../core/entities/sort.dart';
import '../../domain/entities/archetype.dart';
import '../../domain/entities/card_set_info.dart';
import '../../domain/entities/ygo_card.dart';
import '../../domain/entities/ygo_set.dart';
import '../../domain/repository/ygopro_repository.dart';
import '../../models/db_version_model.dart';
import '../api/ygopro_local_data_source.dart';
import '../api/ygopro_remote_data_source.dart';
import '../models/request/get_card_info_request.dart';

final ygoProRepositoryProvider = Provider<YgoProRepository>(
  (ref) => YgoProRepositoryImpl(
    remoteDataSource: ref.read(ygoProRemoteDataSourceProvider),
    localDataSource: ref.read(ygoProLocalDataSourceProvider),
  ),
);

class YgoProRepositoryImpl implements YgoProRepository {
  final YgoProRemoteDataSource remoteDataSource;
  final YgoProLocalDataSource localDataSource;

  YgoProRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Archetype>> getAllCardArchetypes() async {
    final archetypes = await remoteDataSource.getAllCardArchetypes();
    return archetypes;
  }

  @override
  Future<List<YgoSet>> getAllSets() async {
    final remoteSets = await remoteDataSource.getAllSets();
    return remoteSets;
  }

  @override
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
    final remoteCards = await remoteDataSource.getCardInfo(
      GetCardInfoRequest(
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
        linkMarkers: linkMarkers,
        scale: scale,
        cardSet: cardSet,
        archetype: archetype,
        banlist: banlist,
        sort: sort,
        format: format,
        misc: misc,
        staple: staple,
        startDate: startDate,
        endDate: endDate,
        dateRegion: dateRegion,
      ),
    );
    return remoteCards;
  }

  @override
  Future<CardSetInfo> getCardSetInformation(String setCode) =>
      remoteDataSource.getCardSetInformation(setCode);

  @override
  Future<YgoCard> getRandomCard() => remoteDataSource.getRandomCard();

  @override
  Future<List<YgoCard>> getAllCards() =>
      remoteDataSource.getCardInfo(GetCardInfoRequest(misc: true));

  @override
  Future<DBVersionModel> checkDatabaseVersion() =>
      remoteDataSource.checkDatabaseVersion();
}
