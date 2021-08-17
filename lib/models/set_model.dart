import 'package:hive_flutter/hive_flutter.dart';

part 'set_model.g.dart';

@HiveType(typeId: 3)
class SetModel {
  @HiveField(0)
  final String setName;

  @HiveField(1)
  final String setCode;

  @HiveField(2)
  final int numOfCards;

  @HiveField(3)
  final DateTime? tcgDate;

  SetModel({
    required this.setName,
    required this.setCode,
    required this.numOfCards,
    required this.tcgDate,
  });

  factory SetModel.fromJson(Map<String, dynamic> json) => SetModel(
        setName: json['set_name'] as String,
        setCode: json['set_code'] as String,
        numOfCards: json['num_of_cards'] as int,
        tcgDate: json['tcg_date'] != null
            ? DateTime.parse(json['tcg_date'] as String)
            : null,
      );
}
