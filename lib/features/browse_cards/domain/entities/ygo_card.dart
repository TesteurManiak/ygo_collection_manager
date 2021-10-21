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
  // final List<CardImages> cardImages;
  final List<String>? linkmarkers;
  // final List<CardModelSet>? cardSets;
  // final List<CardPriceModel> cardPrices;
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
    // required this.cardImages,
    required this.linkmarkers,
    // required this.cardSets,
    // required this.cardPrices,
    // required this.banlistInfo,
    // required this.miscInfo,
  });
}
