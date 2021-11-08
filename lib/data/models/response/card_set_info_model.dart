import '../../../../domain/entities/card_set_info.dart';

class CardSetInfoModel extends CardSetInfo {
  CardSetInfoModel({
    required int id,
    required String name,
    required String setName,
    required String setCode,
    required String setRarity,
    required String setPrice,
  }) : super(
          id: id,
          name: name,
          setName: setName,
          setCode: setCode,
          setRarity: setRarity,
          setPrice: setPrice,
        );

  factory CardSetInfoModel.fromJson(Map<String, dynamic> json) {
    return CardSetInfoModel(
      id: json['id'] as int,
      name: json['name'] as String,
      setName: json['set_name'] as String,
      setCode: json['set_code'] as String,
      setRarity: json['set_rarity'] as String,
      setPrice: json['set_price'] as String,
    );
  }
}
