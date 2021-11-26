import '../../../../domain/entities/card_set.dart';

class CardSetModel extends CardSet {
  const CardSetModel({
    required String name,
    required String code,
    required String rarity,
    required String? rarityCode,
    required String price,
  }) : super(
          name: name,
          code: code,
          rarity: rarity,
          rarityCode: rarityCode,
          price: price,
        );

  factory CardSetModel.fromJson(Map<String, dynamic> json) {
    return CardSetModel(
      name: json['set_name'] as String,
      code: json['set_code'] as String,
      rarity: json['set_rarity'] as String,
      rarityCode: json['set_rarity_code'] as String?,
      price: json['set_price'] as String,
    );
  }
}
