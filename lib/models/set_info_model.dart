class SetInfoModel {
  final int id;
  final String name;
  final String setName;
  final String setCode;
  final String setRarity;
  final String setPrice;

  SetInfoModel({
    required this.id,
    required this.name,
    required this.setName,
    required this.setCode,
    required this.setRarity,
    required this.setPrice,
  });

  factory SetInfoModel.fromJson(Map<String, dynamic> json) => SetInfoModel(
        id: json['id'] as int,
        name: json['name'] as String,
        setName: json['set_name'] as String,
        setCode: json['set_code'] as String,
        setRarity: json['set_rarity'] as String,
        setPrice: json['set_price'] as String,
      );
}
