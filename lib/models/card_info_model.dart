class CardInfoModel {
  final int id;
  final String name;
  final String type;

  CardInfoModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory CardInfoModel.fromJson(Map<String, dynamic> json) => CardInfoModel(
        id: json['id'] as int,
        name: json['name'] as String,
        type: json['type'] as String,
      );
}
