import 'card_images.dart';
import 'card_price.dart';
import 'card_set.dart';

class YgoCard {
  final int id;
  final String name;
  final String type;
  final String desc;
  final int? atk;
  final int? def;
  final int? level;
  final String race;
  final String? attribute;
  final String? archetype;
  final int? scale;
  final int? linkval;
  // TODO(Maniak): Implement commented entities
  final List<CardImages> cardImages;
  final List<String>? linkmarkers;
  final List<CardSet>? cardSets;
  final List<CardPrice> cardPrices;
  // final CardBanlistInfo? banlistInfo;
  // final List<CardMiscInfo> miscInfo;

  YgoCard({
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
    // required this.banlistInfo,
    // required this.miscInfo,
  });
}
