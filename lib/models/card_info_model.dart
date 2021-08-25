import 'package:hive_flutter/adapters.dart';

part 'card_info_model.g.dart';

@HiveType(typeId: 7)
class CardMiscInfo {
  @HiveField(1)
  final String? betaName;

  @HiveField(2)
  final String? staple;

  @HiveField(3)
  final int? views;

  @HiveField(4)
  final int? viewsWeek;

  @HiveField(5)
  final int? upvotes;

  @HiveField(6)
  final int downvotes;

  @HiveField(7)
  final List<String> formats;

  @HiveField(8)
  final int? betaId;

  @HiveField(9)
  final DateTime? tcgDate;

  @HiveField(10)
  final DateTime? ocgDate;

  @HiveField(11)
  final int? konamiId;

  @HiveField(12)
  final int? hasEffect;

  @HiveField(13)
  final String? treatedAs;

  CardMiscInfo({
    required this.views,
    required this.betaName,
    required this.staple,
    required this.viewsWeek,
    required this.upvotes,
    required this.downvotes,
    required this.formats,
    required this.betaId,
    required this.tcgDate,
    required this.ocgDate,
    required this.konamiId,
    required this.hasEffect,
    required this.treatedAs,
  });

  factory CardMiscInfo.fromJson(Map<String, dynamic> json) => CardMiscInfo(
        views: json['views'] as int?,
        betaName: json['beta_name'] as String?,
        staple: json['staple'] as String?,
        viewsWeek: json['views_week'] as int?,
        upvotes: json['upvotes'] as int?,
        downvotes: json['downvotes'] as int,
        formats: List<String>.from(json['formats'] as Iterable),
        betaId: json['beta_id'] as int?,
        tcgDate: json['tcg_date'] != null
            ? DateTime.tryParse(json['tcg_date'] as String)
            : null,
        ocgDate: json['ocg_date'] != null
            ? DateTime.tryParse(json['ocg_date'] as String)
            : null,
        konamiId: json['konami_id'] as int?,
        hasEffect: json['has_effect'] as int?,
        treatedAs: json['treated_as'] as String?,
      );
}

@HiveType(typeId: 6)
class CardBanlistInfo {
  @HiveField(0)
  final String? tcg;

  @HiveField(1)
  final String? ocg;

  @HiveField(2)
  final String? goat;

  CardBanlistInfo({
    required this.tcg,
    required this.ocg,
    required this.goat,
  });

  factory CardBanlistInfo.fromJson(Map<String, dynamic> json) =>
      CardBanlistInfo(
        tcg: json['ban_tcg'] as String?,
        ocg: json['ban_ocg'] as String?,
        goat: json['ban_goat'] as String?,
      );
}

@HiveType(typeId: 5)
class CardPriceModel {
  @HiveField(0)
  final String cardmarket;

  @HiveField(1)
  final String tcgplayer;

  @HiveField(2)
  final String ebay;

  @HiveField(3)
  final String amazon;

  @HiveField(4)
  final String coolstuffinc;

  CardPriceModel({
    required this.cardmarket,
    required this.tcgplayer,
    required this.ebay,
    required this.amazon,
    required this.coolstuffinc,
  });

  factory CardPriceModel.fromJson(Map<String, dynamic> json) => CardPriceModel(
        cardmarket: json['cardmarket_price'] as String,
        tcgplayer: json['tcgplayer_price'] as String,
        ebay: json['ebay_price'] as String,
        amazon: json['amazon_price'] as String,
        coolstuffinc: json['coolstuffinc_price'] as String,
      );
}

@HiveType(typeId: 4)
class CardModelSet {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String code;

  @HiveField(2)
  final String rarity;

  @HiveField(3)
  final String rarityCode;

  @HiveField(4)
  final String price;

  CardModelSet({
    required this.name,
    required this.code,
    required this.rarity,
    required this.rarityCode,
    required this.price,
  });

  factory CardModelSet.fromJson(Map<String, dynamic> json) => CardModelSet(
        name: json['set_name'] as String,
        code: json['set_code'] as String,
        rarity: json['set_rarity'] as String,
        rarityCode: json['set_rarity_code'] as String,
        price: json['set_price'] as String,
      );
}

@HiveType(typeId: 2)
class CardImages {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String imageUrlSmall;

  CardImages({
    required this.id,
    required this.imageUrl,
    required this.imageUrlSmall,
  });

  factory CardImages.fromJson(Map<String, dynamic> json) => CardImages(
        id: json['id'] as int,
        imageUrl: json['image_url'] as String,
        imageUrlSmall: json['image_url_small'] as String,
      );
}

@HiveType(typeId: 1)
class CardInfoModel extends HiveObject {
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
  final List<CardModelSet>? cardSets;

  @HiveField(15)
  final List<CardPriceModel> cardPrices;

  @HiveField(16)
  final CardBanlistInfo? banlistInfo;

  @HiveField(17)
  final List<CardMiscInfo> miscInfo;

  String get levelAsset =>
      'assets/level/${type == "XYZ Monster" ? "rank.png" : "level.png"}';

  CardInfoModel({
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
    required this.linkmarkers,
    required this.cardImages,
    required this.cardSets,
    required this.cardPrices,
    required this.banlistInfo,
    required this.miscInfo,
  });

  factory CardInfoModel.fromJson(Map<String, dynamic> json) => CardInfoModel(
        id: json['id'] as int,
        name: json['name'] as String,
        type: json['type'] as String,
        desc: json['desc'] as String,
        atk: json['atk'] as int?,
        def: json['def'] as int?,
        level: json['level'] as int?,
        race: json['race'] as String,
        attribute: json['attribute'] as String?,
        archetype: json['archetype'] as String?,
        scale: json['scale'] as int?,
        linkval: json['linkval'] as int?,
        linkmarkers: json['linkmarkers'] != null
            ? List<String>.from(json['linkmarkers'] as Iterable)
            : null,
        cardImages: (json['card_images'] as Iterable)
            .map<CardImages>(
                (e) => CardImages.fromJson(e as Map<String, dynamic>))
            .toList(),
        cardSets: (json['card_sets'] as Iterable?)
            ?.map<CardModelSet>(
                (e) => CardModelSet.fromJson(e as Map<String, dynamic>))
            .toList(),
        cardPrices: (json['card_prices'] as Iterable)
            .map<CardPriceModel>(
              (e) => CardPriceModel.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
        banlistInfo: json['banlist_info'] != null
            ? CardBanlistInfo.fromJson(
                json['banlist_info'] as Map<String, dynamic>)
            : null,
        miscInfo: (json['misc_info'] as Iterable)
            .map<CardMiscInfo>(
              (e) => CardMiscInfo.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
}
