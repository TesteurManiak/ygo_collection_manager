import '../../../../domain/entities/ygo_card.dart';
import 'card_banlist_info_model.dart';
import 'card_images_model.dart';
import 'card_misc_info_model.dart';
import 'card_price_model.dart';
import 'card_set_model.dart';

class YgoCardModel extends YgoCard {
  const YgoCardModel({
    required int id,
    required String name,
    required String type,
    required String desc,
    required int? atk,
    required int? def,
    required int? level,
    required String race,
    required String? attribute,
    required String? archetype,
    required int? scale,
    required int? linkval,
    required List<CardImagesModel> cardImages,
    required List<String>? linkmarkers,
    required List<CardSetModel>? cardSets,
    required List<CardPriceModel> cardPrices,
    required CardBanlistInfoModel? banlistInfo,
    required List<CardMiscInfoModel>? miscInfo,
  }) : super(
          id: id,
          name: name,
          type: type,
          desc: desc,
          atk: atk,
          def: def,
          level: level,
          race: race,
          attribute: attribute,
          archetype: archetype,
          scale: scale,
          linkval: linkval,
          cardImages: cardImages,
          linkmarkers: linkmarkers,
          cardSets: cardSets,
          cardPrices: cardPrices,
          banlistInfo: banlistInfo,
          miscInfo: miscInfo,
        );

  factory YgoCardModel.fromJson(Map<String, dynamic> json) {
    return YgoCardModel(
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
          .map<CardImagesModel>(
            (e) => CardImagesModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      cardSets: (json['card_sets'] as Iterable?)
          ?.cast<Map<String, dynamic>>()
          .map<CardSetModel>(CardSetModel.fromJson)
          .toList(),
      cardPrices: (json['card_prices'] as Iterable)
          .cast<Map<String, dynamic>>()
          .map<CardPriceModel>(CardPriceModel.fromJson)
          .toList(),
      banlistInfo: json['banlist_info'] != null
          ? CardBanlistInfoModel.fromJson(
              json['banlist_info'] as Map<String, dynamic>,
            )
          : null,
      miscInfo: (json['misc_info'] as Iterable?)
          ?.cast<Map<String, dynamic>>()
          .map<CardMiscInfoModel>(CardMiscInfoModel.fromJson)
          .toList(),
    );
  }
}
