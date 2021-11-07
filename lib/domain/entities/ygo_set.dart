import 'package:hive_flutter/adapters.dart';

part 'ygo_set.g.dart';

@HiveType(typeId: 3)
class YgoSet {
  @HiveField(0)
  final String setName;

  @HiveField(1)
  final String setCode;

  @HiveField(2)
  final int numOfCards;

  @HiveField(3)
  final DateTime? tcgDate;

  YgoSet({
    required this.setName,
    required this.setCode,
    required this.numOfCards,
    required this.tcgDate,
  });
}
