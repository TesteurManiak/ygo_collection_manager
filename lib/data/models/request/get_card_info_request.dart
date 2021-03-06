import 'package:equatable/equatable.dart';

import '../../../domain/entities/banlist.dart';
import '../../../domain/entities/format.dart';
import '../../../domain/entities/link_markers.dart';
import '../../../domain/entities/sort.dart';

class GetCardInfoRequest extends Equatable {
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

  const GetCardInfoRequest({
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
    this.misc = false,
    this.scale,
    this.cardSet,
    this.archetype,
    this.banlist,
    this.sort,
    this.format,
    this.staple,
    this.startDate,
    this.endDate,
    this.dateRegion,
  });

  @override
  List<Object?> get props => [
        names,
        fname,
        ids,
        types,
        atk,
        def,
        level,
        races,
        attributes,
        link,
        linkMarkers,
        misc,
        scale,
        cardSet,
        archetype,
        banlist,
        sort,
        format,
        staple,
        startDate,
        endDate,
        dateRegion,
      ];
}

extension LinkMarkersIterableModifier on Iterable<LinkMarkers> {
  Iterable<String> toStringIterable() => map((e) => e.string);
}

extension LinkMarkersModifier on LinkMarkers {
  String get string {
    switch (this) {
      case LinkMarkers.top:
        return 'Top';
      case LinkMarkers.bottom:
        return 'Bottom';
      case LinkMarkers.left:
        return 'Left';
      case LinkMarkers.right:
        return 'Right';
      case LinkMarkers.bottomLeft:
        return 'Bottom-Left';
      case LinkMarkers.bottomRight:
        return 'Bottom-Right';
      case LinkMarkers.topLeft:
        return 'Top-Left';
      case LinkMarkers.topRight:
        return 'Top-Right';
    }
  }
}

extension SortModifier on Sort {
  String get string {
    switch (this) {
      case Sort.newest:
        return 'new';
      default:
        return name;
    }
  }
}

extension FormatModifier on Format {
  String get string {
    switch (this) {
      case Format.tcg:
        return 'tcg';
      case Format.goat:
        return 'goat';
      case Format.ocgGoat:
        return 'ocg goat';
      case Format.speedDuel:
        return 'speed duel';
      case Format.rushDuel:
        return 'rush duel';
      case Format.duelLinks:
        return 'duel links';
    }
  }
}
