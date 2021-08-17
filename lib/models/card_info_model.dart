import 'package:hive_flutter/adapters.dart';

part 'card_info_model.g.dart';

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
  // final List<String>? linkmarkers;

  @HiveField(12)
  final List<CardImages> cardImages;

  // TODO: add card_sets, card_prices, banlist_info, beta_name, views, viewsweek, upvotes, downvotes, formats, treated_as, tcg_date, ocg_date, has_ffect

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
    // required this.linkmarkers,
    required this.cardImages,
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
        // linkmarkers: (json['linkmarkers'] as Iterable<String>?)?.toList(),
        cardImages: (json['card_images'] as Iterable)
            .map<CardImages>(
                (e) => CardImages.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
