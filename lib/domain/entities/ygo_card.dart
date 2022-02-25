import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

import 'card_banlist_info.dart';
import 'card_edition_enum.dart';
import 'card_images.dart';
import 'card_misc_info.dart';
import 'card_price.dart';
import 'card_set.dart';
import 'ygo_set.dart';

part 'ygo_card.g.dart';

@HiveType(typeId: 1)
class YgoCard extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String desc;

  @HiveField(4)
  final int? atk;

  @HiveField(5)
  final int? def;

  @HiveField(6)
  final int? level;

  @HiveField(7)
  final String race;

  @HiveField(8)
  final String? attribute;

  @HiveField(9)
  final String? archetype;

  @HiveField(10)
  final int? scale;

  @HiveField(11)
  final int? linkval;

  @HiveField(12)
  final List<CardImages> cardImages;

  @HiveField(13)
  final List<String>? linkmarkers;

  @HiveField(14)
  final List<CardSet>? cardSets;

  @HiveField(15)
  final List<CardPrice> cardPrices;

  @HiveField(16)
  final CardBanlistInfo? banlistInfo;

  @HiveField(17)
  final List<CardMiscInfo>? miscInfo;

  const YgoCard({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.atk,
    required this.def,
    required this.level,
    required this.race,
    required this.attribute,
    required this.archetype,
    required this.scale,
    required this.linkval,
    required this.cardImages,
    required this.linkmarkers,
    required this.cardSets,
    required this.cardPrices,
    required this.banlistInfo,
    required this.miscInfo,
  });

  CardSet? getCardSetsFromSet(YgoSet set) => cardSets?.firstWhere(
        (e) => e.name == set.setName && e.code.contains(set.setCode),
      );

  String get levelAsset =>
      'assets/level/${type.contains(RegExp("XYZ", caseSensitive: false)) ? "rank.png" : "level.png"}';

  String getDbKey(YgoSet set, CardEditionEnum edition) {
    final cardSet = getCardSetsFromSet(set)!;
    return '${cardSet.code}-${edition.string}';
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        atk,
        def,
        level,
        race,
        attribute,
        archetype,
        scale,
        linkval,
        cardImages,
        linkmarkers,
        cardSets,
        cardPrices,
        banlistInfo,
        miscInfo,
      ];
}
