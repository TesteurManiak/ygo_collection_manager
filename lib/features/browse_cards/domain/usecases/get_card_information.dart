import '../../../../core/entities/banlist.dart';
import '../../../../core/entities/format.dart';
import '../../../../core/entities/link_markers.dart';
import '../../../../core/entities/sort.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/ygo_card.dart';
import '../../../../domain/repositories/ygopro_repository.dart';

class GetCardInformation implements UseCase<List<YgoCard>, GetCardInfoParams> {
  final YgoProRepository repository;

  GetCardInformation(this.repository);

  @override
  Future<List<YgoCard>> call(GetCardInfoParams params) =>
      repository.getCardInfo(
        names: params.names,
        fname: params.fname,
        ids: params.ids,
        types: params.types,
        atk: params.atk,
        def: params.def,
        level: params.level,
        races: params.races,
        attributes: params.attributes,
        link: params.link,
        linkMarkers: params.linkMarkers,
        scale: params.scale,
        cardSet: params.cardSet,
        archetype: params.archetype,
        banlist: params.banlist,
        sort: params.sort,
        format: params.format,
        misc: params.misc,
        staple: params.staple,
        startDate: params.startDate,
        endDate: params.endDate,
        dateRegion: params.dateRegion,
      );
}

class GetCardInfoParams {
  final List<String>? names;
  final String? fname;
  final List<int>? ids;
  final List<String>? types;
  final int? atk;
  final int? def;
  final int? level;
  final List<String>? races;
  final List<String>? attributes;
  final int? link;
  final List<LinkMarkers>? linkMarkers;
  final int? scale;
  final String? cardSet;
  final String? archetype;
  final Banlist? banlist;
  final Sort? sort;
  final Format? format;
  final bool misc;
  final bool? staple;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? dateRegion;

  GetCardInfoParams({
    this.names,
    this.fname,
    this.ids,
    this.types,
    this.atk,
    this.def,
    this.level,
    this.races,
    this.attributes,
    this.link,
    this.linkMarkers,
    this.scale,
    this.cardSet,
    this.archetype,
    this.banlist,
    this.sort,
    this.format,
    this.misc = false,
    this.staple,
    this.startDate,
    this.endDate,
    this.dateRegion,
  });
}
